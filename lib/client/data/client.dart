import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:e1547/client/client.dart';
import 'package:e1547/comment/comment.dart';
import 'package:e1547/interface/interface.dart';
import 'package:e1547/logs/logs.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/reply/reply.dart';
import 'package:e1547/tag/tag.dart';
import 'package:e1547/ticket/ticket.dart';
import 'package:e1547/topic/topic.dart';
import 'package:e1547/user/user.dart';
import 'package:e1547/wiki/wiki.dart';
import 'package:rxdart/rxdart.dart';

export 'package:dio/dio.dart' show CancelToken;

class Client {
  Client({
    required this.host,
    required this.userAgent,
    this.cache,
    this.memoryCache,
    this.credentials,
    this.cookies,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: host,
        headers: {
          HttpHeaders.userAgentHeader: userAgent,
          HttpHeaders.cookieHeader: cookies
              ?.map((cookie) => '${cookie.name}=${cookie.value}')
              .join('; '),
          if (credentials != null)
            HttpHeaders.authorizationHeader: credentials!.basicAuth,
        },
        sendTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
      ),
    );
    _dio.interceptors.add(LoggyDioInterceptor(
      requestLevel: LogLevel.debug,
      responseLevel: LogLevel.debug,
      errorLevel: LogLevel.warning,
    ));
    if (cache != null) {
      _dio.interceptors.add(
        ClientCacheInterceptor(
          options: ClientCacheConfig(
            store: cache,
            maxAge: const Duration(minutes: 5),
            pageParam: 'page',
          ),
        ),
      );
    }
  }

  /// The host of this client.
  /// Must be a fully qualified URL that ends in a slash.
  final String host;

  /// The user agent of this client.
  /// Format: `appname/version (developer)`
  final String userAgent;

  /// The cache to use for this client.
  final CacheStore? cache;

  /// The memory cache to use for this client.
  /// This is used to cache the current user.
  final CacheStore? memoryCache;

  /// The credentials to use for this client.
  final Credentials? credentials;

  /// The cookies to use for this client.
  ///
  /// This is used to get past the Cloudflare bot check.
  final List<Cookie>? cookies;

  late Dio _dio;

  void close({bool force = false}) {
    _dio.close(force: force);
    _postCache.dispose();
  }

  bool get hasLogin => credentials != null;

  /// Appends [value] to [host] and returns the result.
  String withHost(String value) {
    Uri uri = Uri.parse(host);
    Uri other = Uri.parse(value);

    String path = other.path;
    if (path.startsWith('/')) path = path.substring(1);
    Map<String, dynamic>? queryParameters = other.queryParameters;
    if (queryParameters.isEmpty) queryParameters = null;
    String? fragment = other.fragment;
    if (fragment.isEmpty) fragment = null;

    return uri
        .replace(
          path: path,
          queryParameters: queryParameters,
          fragment: fragment,
        )
        .toString();
  }

  Future<void> availability() async => _dio.get('');

  late final DioPagedValueCache<int, Post> _postCache =
      DioPagedValueCache<int, Post>(
    dio: _dio,
    toId: (e) => e.id,
    size: 0,
    maxAge: const Duration(minutes: 5),
    pageQueryKey: 'page',
  );

  StreamFuture<List<Post>> posts({
    int? page,
    int? limit,
    QueryMap? query,
    bool? ordered,
    bool? orderPoolsByOldest,
    bool? orderFavoritesByAdded,
    bool? force,
    CancelToken? cancelToken,
  }) {
    ordered ??= true;
    String? tags = query?['tags'];
    if (ordered && tags != null) {
      Map<RegExp, StreamFuture<List<Post>> Function(RegExpMatch match)>
          redirects = {
        poolRegex(): (match) => postsByPool(
              id: int.parse(match.namedGroup('id')!),
              page: page,
              orderByOldest: orderPoolsByOldest ?? true,
              force: force,
              cancelToken: cancelToken,
            ),
        if ((orderFavoritesByAdded ?? false) && credentials?.username != null)
          favRegex(credentials!.username): (match) =>
              favorites(page: page, limit: limit, force: force),
      };

      for (final entry in redirects.entries) {
        RegExpMatch? match = entry.key.firstMatch(tags);
        if (match != null) {
          return entry.value(match);
        }
      }
    }

    return _postCache.requestPage(
      'posts.json',
      queryParameters: {
        'page': page,
        'limit': limit,
        ...?query,
      },
      options: forceOptions(force),
      cancelToken: cancelToken,
      parse: (response) {
        List<Post> result =
            List<Post>.from(response.data['posts'].map(Post.fromJson));

        result.removeWhere(
          (e) =>
              (e.file.url == null && !e.flags.deleted) || e.file.ext == 'swf',
        );

        return result;
      },
    );
  }

  StreamFuture<List<Post>> postsByIds({
    required List<int> ids,
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  }) {
    limit = max(0, min(limit ?? 75, 100));

    List<List<int>> chunks = [];
    for (int i = 0; i < ids.length; i += limit) {
      chunks.add(ids.sublist(i, min(i + limit, ids.length)));
    }

    BehaviorSubject<List<Post>> subject = BehaviorSubject<List<Post>>();

    Stream<List<Post>> source = CombineLatestStream.list([
      for (final chunk in chunks)
        posts(
          query: QueryMap({'tags': 'id:${chunk.join(',')}'}),
          limit: limit,
          ordered: false,
          force: force,
          cancelToken: cancelToken,
        ),
    ].map((e) => e.stream)).expand((e) => e).map((e) {
      Map<int, Post> table = {for (Post e in e) e.id: e};
      return ids.map((e) => table[e]).whereType<Post>().toList();
    });

    source.listen(
      subject.add,
      onError: subject.addError,
      onDone: subject.close,
    );

    return subject.stream.future;
  }

  StreamFuture<List<Post>> postsByTags(
    List<String> tags,
    int page, {
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  }) {
    tags.removeWhere((e) => e.contains(' ') || e.contains(':'));
    if (tags.isEmpty) return StreamFuture.value(<Post>[]);
    int max = 40;
    int pages = (tags.length / max).ceil();
    int chunkSize = (tags.length / pages).ceil();

    int tagPage = page % pages != 0 ? page % pages : pages;
    int sitePage = (page / pages).ceil();

    List<String> chunk =
        tags.sublist((tagPage - 1) * chunkSize).take(chunkSize).toList();
    String filter = chunk.map((e) => '~$e').join(' ');
    return posts(
      page: sitePage,
      query: QueryMap()..['tags'] = filter,
      limit: limit,
      ordered: false,
      force: force,
      cancelToken: cancelToken,
    );
  }

  StreamFuture<List<Post>> postsByFavoriter({
    required String username,
    int? page,
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  }) {
    return posts(
      page: page,
      query: QueryMap()..['tags'] = 'fav:$username',
      limit: limit,
      ordered: false,
      force: force,
      cancelToken: cancelToken,
    );
  }

  StreamFuture<List<Post>> postsByUploader({
    required String username,
    int? page,
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  }) {
    return posts(
      page: page,
      query: QueryMap()..['tags'] = 'user:$username',
      limit: limit,
      ordered: false,
      force: force,
      cancelToken: cancelToken,
    );
  }

  StreamFuture<Post> post(int postId, {bool? force, CancelToken? cancelToken}) {
    return _postCache.request(
      'posts/$postId.json',
      key: postId,
      options: forceOptions(force),
      parse: (response) => Post.fromJson(response.data['post']),
    );
  }

  Future<void> updatePost(int postId, Map<String, String?> body) async {
    // TODO: update cache with post update
    await _postCache.items.optimistic(postId, (post) => post, () async {
      await cache?.deleteFromPath(
        RegExp(RegExp.escape('posts/$postId.json')),
      );
      await _dio.put('posts/$postId.json', data: FormData.fromMap(body));
    });
  }

  Future<void> votePost(int postId, bool upvote, bool replace) async {
    await _postCache.items.optimistic(postId, (post) => post.withVote(upvote),
        () async {
      await cache?.deleteFromPath(RegExp(RegExp.escape('posts/$postId.json')));
      await _dio.post('posts/$postId/votes.json', queryParameters: {
        'score': upvote ? 1 : -1,
        'no_unvote': replace,
      });
    });
  }

  Future<void> reportPost(int postId, int reportId, String reason) async {
    await _dio.post(
      'tickets',
      queryParameters: {
        'ticket[reason]': reason,
        'ticket[report_reason]': reportId,
        'ticket[disp_id]': postId,
        'ticket[qtype]': 'post',
      },
      options: Options(
        validateStatus: (status) => status == 302,
      ),
    );
  }

  Future<void> flagPost(int postId, String flag, {int? parent}) async {
    await _dio.post(
      'post_flags.json',
      queryParameters: {
        'post_flag[post_id]': postId,
        'post_flag[reason_name]': flag,
        if (flag == 'inferior' && parent != null)
          'post_flag[parent_id]': parent,
      },
    );
  }

  StreamFuture<List<Post>> favorites({
    int? page,
    int? limit,
    QueryMap? query,
    bool? orderByAdded,
    bool? force,
    CancelToken? cancelToken,
  }) {
    if (credentials?.username == null) {
      throw NoUserLoginException();
    }
    orderByAdded ??= true;
    String tags = query?['tags'] ?? '';
    if (tags.isEmpty && orderByAdded) {
      return _postCache.requestPage('favorites.json',
          queryParameters: {
            'page': page,
            'limit': limit,
            ...?query,
          },
          options: forceOptions(force),
          cancelToken: cancelToken, parse: (response) {
        List<Post> result =
            List.from(response.data['posts'].map(Post.fromJson));
        result.removeWhere((e) => e.flags.deleted || e.file.url == null);
        return result;
      });
    } else {
      query = QueryMap({
        ...?query,
        'tags': QueryMap.parse(tags)..['fav'] = credentials?.username,
      });
      return posts(
        page: page,
        query: query,
        ordered: false,
        force: force,
        cancelToken: cancelToken,
      );
    }
  }

  Future<void> addFavorite(int postId) async {
    await _postCache.items.optimistic(postId, (post) => post.withFav(),
        () async {
      await cache?.deleteFromPath(RegExp(RegExp.escape('posts/$postId.json')));
      await _dio.post('favorites.json', queryParameters: {'post_id': postId});
    });
  }

  Future<void> removeFavorite(int postId) async {
    await _postCache.items.optimistic(postId, (post) => post.withUnfav(),
        () async {
      await cache?.deleteFromPath(RegExp(RegExp.escape('posts/$postId.json')));
      await _dio.delete('favorites/$postId.json');
    });
  }

  Future<List<PostFlag>> flags({
    int? page,
    int? limit,
    QueryMap? query,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    List<dynamic> body = await _dio
        .get(
          'post_flags.json',
          queryParameters: {
            'page': page,
            'limit': limit,
            ...?query,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return body.map((e) => PostFlag.fromJson(e)).toList();
  }

  late final DioPagedValueCache<int, Pool> _poolCache =
      DioPagedValueCache<int, Pool>(
    dio: _dio,
    toId: (e) => e.id,
    size: 0,
    maxAge: const Duration(minutes: 5),
    pageQueryKey: 'page',
  );

  StreamFuture<List<Pool>> pools({
    int? page,
    int? limit,
    QueryMap? query,
    bool? force,
    CancelToken? cancelToken,
  }) {
    return _poolCache.requestPage(
      'pools.json',
      queryParameters: {
        'page': page,
        'limit': limit,
        ...?query,
      },
      options: forceOptions(force),
      cancelToken: cancelToken,
      parse: (response) {
        List<Pool> result = List<Pool>.from(response.data.map(Pool.fromJson));
        return result;
      },
    );
  }

  StreamFuture<Pool> pool({
    required int id,
    bool? force,
    CancelToken? cancelToken,
  }) {
    return _poolCache.request(
      key: id,
      'pools/$id.json',
      options: forceOptions(force),
      cancelToken: cancelToken,
      parse: (response) => Pool.fromJson(response.data),
    );
  }

  StreamFuture<List<Post>> postsByPool({
    required int id,
    int? page,
    int? limit,
    bool orderByOldest = true,
    bool? force,
    CancelToken? cancelToken,
  }) {
    page ??= 1;
    // TODO: include this in the stream
    // CurrentUser? user = await currentUser(cancelToken: cancelToken);
    int limit = 75; // user?.perPage ?? 75;

    return pool(id: id, force: force, cancelToken: cancelToken)
        .stream
        .asyncExpand((e) {
      List<int> ids = e.postIds;
      if (!orderByOldest) ids = ids.reversed.toList();
      int lower = (page! - 1) * limit;
      if (lower > ids.length) return Stream.value(<Post>[]);
      ids = ids.sublist(lower).take(limit).toList();
      return postsByIds(
        ids: ids,
        limit: limit,
        force: force,
        cancelToken: cancelToken,
      ).stream;
    }).future;
  }

  Future<List<Wiki>> wikis({
    int? page,
    int? limit,
    QueryMap? query,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    List<dynamic> body = await _dio
        .get(
          'wiki_pages.json',
          queryParameters: {
            'page': page,
            'limit': limit,
            ...?query,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return body.map((entry) => Wiki.fromJson(entry)).toList();
  }

  Future<Wiki> wiki({
    required String id,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> body = await _dio
        .get(
          'wiki_pages/$id.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return Wiki.fromJson(body);
  }

  Future<User> user({
    required String id,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> body = await _dio
        .get(
          'users/$id.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return User.fromJson(body);
  }

  Future<void> reportUser({
    required int id,
    required String reason,
  }) async {
    await _dio.post(
      'tickets',
      queryParameters: {
        'ticket[reason]': reason,
        'ticket[disp_id]': id,
        'ticket[qtype]': 'user',
      },
    );
  }

  late final DioPagedValueCache<String, CurrentUser> _currentUserCache =
      DioPagedValueCache<String, CurrentUser>(
    dio: _dio,
    toId: (e) => e.name,
    size: 1,
  );

  StreamFuture<CurrentUser?> currentUser({
    bool? force,
    CancelToken? cancelToken,
  }) {
    if (!hasLogin) return StreamFuture.value(null);

    return _currentUserCache.request(
      key: credentials!.username,
      'users/${credentials!.username}.json',
      options: ClientCacheConfig(
        policy: (force ?? false) ? CachePolicy.refresh : CachePolicy.request,
      ).toOptions(),
      cancelToken: cancelToken,
      parse: (response) => CurrentUser.fromJson(response.data),
    );
  }

  Future<void> updateBlacklist(List<String> denylist) async {
    Map<String, dynamic> body = {
      'user[blacklisted_tags]': denylist.join('\n'),
    };

    await _currentUserCache.items.optimistic(
      credentials!.username,
      (user) => user.copyWith(blacklistedTags: denylist.join('\n')),
      () async {
        await _dio.put('users/${credentials!.username}.json',
            data: FormData.fromMap(body));
      },
    );
  }

  Future<List<Tag>> tags({
    int? page,
    int? limit,
    QueryMap? query,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Object body = await _dio
        .get(
          'tags.json',
          queryParameters: {
            'page': page,
            'limit': limit,
            ...?query,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    List<Tag> tags = [];
    if (body is List<dynamic>) {
      for (final tag in body) {
        tags.add(Tag.fromJson(tag));
      }
    }
    return tags;
  }

  Future<List<TagSuggestion>> autocomplete({
    required String search,
    int? category,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    if (search.contains(':')) return [];
    if (category == null) {
      if (search.length < 3) return [];
      Object body = await _dio
          .get(
            'tags/autocomplete.json',
            queryParameters: {
              'search[name_matches]': search,
            },
            options: forceOptions(force),
            cancelToken: cancelToken,
          )
          .then((response) => response.data);
      List<TagSuggestion> tags = [];
      if (body is List<dynamic>) {
        for (final tag in body) {
          tags.add(TagSuggestion.fromJson(tag));
        }
      }
      return tags;
    } else {
      List<TagSuggestion> tags = [];
      for (final tag in await this.tags(
        limit: 3,
        query: QueryMap({
          'search[name_matches]': '$search*',
          'search[category]': category,
          'search[order]': 'count',
        }),
        force: force,
      )) {
        tags.add(
          TagSuggestion(
            id: tag.id,
            name: tag.name,
            postCount: tag.postCount,
            category: tag.category,
            antecedentName: null,
          ),
        );
      }
      return tags;
    }
  }

  Future<String?> tagAliases({
    int? page,
    int? limit,
    QueryMap? query,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Object body = await _dio
        .get(
          'tag_aliases.json',
          queryParameters: {
            'page': page,
            'limit': limit,
            ...?query,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((value) => value.data);

    if (body is List<dynamic>) {
      body.removeWhere((e) => e['status'] == 'deleted');
      if (body.isEmpty) return null;
      return body.first['consequent_name'];
    }

    return null;
  }

  late final DioPagedValueCache<int, Comment> _commentCache =
      DioPagedValueCache<int, Comment>(
    dio: _dio,
    toId: (e) => e.id,
    size: 0,
    maxAge: const Duration(minutes: 5),
    pageQueryKey: 'page',
  );

  StreamFuture<List<Comment>> comments({
    int? page,
    int? limit,
    QueryMap? query,
    bool? force,
    CancelToken? cancelToken,
  }) {
    return _commentCache.requestPage('comments.json',
        queryParameters: {
          'page': page,
          'limit': limit,
          ...?query,
        },
        options: forceOptions(force),
        cancelToken: cancelToken, parse: (response) {
      List<Comment> comments = [];
      if (response.data is List<dynamic>) {
        for (Map<String, dynamic> rawComment in response.data) {
          comments.add(Comment.fromJson(rawComment));
        }
      }

      return comments;
    });
  }

  StreamFuture<List<Comment>> commentsByPost({
    required int id,
    int? page,
    int? limit,
    bool? ascending,
    bool? force,
    CancelToken? cancelToken,
  }) {
    return comments(
      page: page,
      limit: limit,
      query: QueryMap({
        'group_by': 'comment',
        'search[post_id]': id,
        'search[order]': ascending ?? false ? 'id_asc' : 'id_desc',
      }),
      force: force,
      cancelToken: cancelToken,
    );
  }

  StreamFuture<Comment> comment({
    required int id,
    bool? force,
    CancelToken? cancelToken,
  }) {
    return _commentCache.request(
      'comments.json/$id.json',
      key: id,
      options: forceOptions(force),
      cancelToken: cancelToken,
      parse: (response) => Comment.fromJson(response.data),
    );
  }

  Future<void> postComment({
    required int postId,
    required String content,
  }) async {
    await cache?.deleteFromPath(
      RegExp(RegExp.escape('comments.json')),
      queryParams: {'search[post_id]': postId.toString()},
    );

    Map<String, dynamic> body = {
      'comment[body]': content,
      'comment[post_id]': postId,
      'commit': 'Submit',
    };

    await _dio.post('comments.json', data: FormData.fromMap(body));
  }

  Future<void> updateComment({
    required int id,
    required int postId,
    required String content,
  }) async {
    await cache?.deleteFromPath(
      RegExp(RegExp.escape('comments.json')),
      queryParams: {'search[post_id]': postId.toString()},
    );

    await cache?.deleteFromPath(
      RegExp(RegExp.escape('comments/$id.json')),
    );

    Map<String, dynamic> body = {
      'comment[body]': content,
      'commit': 'Submit',
    };

    await _dio.patch('comments/$id.json', data: FormData.fromMap(body));
  }

  Future<void> voteComment({
    required int id,
    required bool upvote,
    required bool replace,
  }) async {
    await _dio.post(
      'comments/$id/votes.json',
      queryParameters: {
        'score': upvote ? 1 : -1,
        'no_unvote': replace,
      },
    );
  }

  Future<void> reportComment({
    required int id,
    required String reason,
  }) async {
    await _dio.post(
      'tickets',
      queryParameters: {
        'ticket[reason]': reason,
        'ticket[disp_id]': id,
        'ticket[qtype]': 'comment',
      },
      options: Options(
        validateStatus: (status) => status == 302,
      ),
    );
  }

  Future<List<Topic>> topics({
    int? page,
    int? limit,
    QueryMap? query,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Object body = await _dio
        .get(
          'forum_topics.json',
          queryParameters: {
            'page': page,
            'limit': limit,
            ...?query,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    List<Topic> threads = [];
    if (body is List<dynamic>) {
      for (Map<String, dynamic> raw in body) {
        threads.add(Topic.fromJson(raw));
      }
    }

    return threads;
  }

  Future<Topic> topic({
    required int id,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> body = await _dio
        .get(
          'forum_topics/$id.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return Topic.fromJson(body);
  }

  Future<List<Reply>> replies({
    required int id,
    int? page,
    int? limit,
    QueryMap? query,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Object body = await _dio
        .get(
          'forum_posts.json',
          queryParameters: {
            'page': page,
            'limit': limit,
            ...?query,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    List<Reply> replies = [];
    if (body is List<dynamic>) {
      for (Map<String, dynamic> raw in body) {
        replies.add(Reply.fromJson(raw));
      }
    }

    return replies;
  }

  Future<List<Reply>> repliesByTopic({
    required int id,
    int? page,
    int? limit,
    bool? ascending,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    return replies(
      id: id,
      page: page,
      limit: limit,
      query: QueryMap({
        'search[topic_id]': id,
        'search[order]': ascending ?? false ? 'id_asc' : 'id_desc',
      }),
      force: force,
      cancelToken: cancelToken,
    );
  }

  Future<Reply> reply({
    required int id,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> body = await _dio
        .get(
          'forum_posts/$id.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return Reply.fromJson(body);
  }
}
