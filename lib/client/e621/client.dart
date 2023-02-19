import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:e1547/client/client.dart';
import 'package:e1547/client/e621.dart';
import 'package:e1547/comment/comment.dart';
import 'package:e1547/follow/follow.dart';
import 'package:e1547/interface/interface.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/reply/reply.dart';
import 'package:e1547/tag/tag.dart';
import 'package:e1547/topic/topic.dart';
import 'package:e1547/user/user.dart';
import 'package:e1547/wiki/wiki.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class e621Client extends Client
    implements
        AvailabilityClient,
        PostOrderedClient,
        PostUpdateClient,
        PostVoteClient,
        PostFavoriteClient,
        PostTicketClient,
        PostTaggedClient,
        PostIdsClient,
        CommentReportClient,
        CommentVoteClient,
        PoolClient,
        WikiClient,
        UserReportClient,
        UserBlacklistClient,
        TopicClient,
        ReplyClient,
        TagAliasClient,
        FollowClient {
  e621Client({
    required super.host,
    required super.userAgent,
    super.cache,
    super.credentials,
    super.cookies,
  });

  @override
  Future<void> availability() async => dio.get('');

  @override
  Future<List<Post>> posts(
    int page, {
    int? limit,
    String? search,
    bool? ordered,
    bool? orderPoolsByOldest,
    bool? orderFavoritesByAdded,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    ordered ??= true;
    if (ordered) {
      Map<RegExp, Future<List<Post>> Function(RegExpMatch match)> redirects = {
        poolRegex(): (match) => poolPosts(
              int.parse(match.namedGroup('id')!),
              page,
              orderByOldest: orderPoolsByOldest ?? true,
              force: force,
              cancelToken: cancelToken,
            ),
        if ((orderFavoritesByAdded ?? false) && credentials?.username != null)
          favRegex(credentials!.username): (match) =>
              favorites(page, limit: limit, force: force),
      };

      for (final entry in redirects.entries) {
        RegExpMatch? match = entry.key.firstMatch(search!.trim());
        if (match != null) {
          return entry.value(match);
        }
      }
    }

    String? tags = search != null ? sortTags(search) : '';
    Map<String, dynamic> body = await dio
        .get(
          'posts.json',
          queryParameters: {
            'tags': tags,
            'page': page,
            'limit': limit,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    List<Post> posts =
        List<Post>.from(body['posts'].map((e) => Post.fromJson(e)));

    if (ordered) {
      posts.removeWhere((e) => e.isIgnored());
    }

    return posts;
  }

  @override
  Future<List<Post>> postsByIds(
    List<int> ids, {
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    limit = max(0, min(limit ?? 80, 100));

    List<List<int>> chunks = [];
    while (true) {
      chunks.add(ids.sublist(chunks.length * limit).take(limit).toList());
      if (chunks.last.length < limit) break;
    }

    List<Post> result = [];
    for (final chunk in chunks) {
      if (chunk.isEmpty) continue;
      String filter = 'id:${chunk.join(',')}';
      List<Post> part = await posts(
        1,
        search: filter,
        ordered: false,
        force: force,
        cancelToken: cancelToken,
      );
      Map<int, Post> table = {for (Post e in part) e.id: e};
      part = (chunk.map((e) => table[e]).toList()
            ..removeWhere((e) => e == null))
          .cast<Post>();
      result.addAll(part);
    }
    return result;
  }

  @override
  Future<List<Post>> postsByTags(
    List<String> tags,
    int page, {
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    if (tags.isEmpty) return [];
    int max = 40;
    int pages = (tags.length / max).ceil();
    int chunkSize = (tags.length / pages).ceil();

    int tagPage = page % pages != 0 ? page % pages : pages;
    int sitePage = (page / pages).ceil();

    List<String> chunk =
        tags.sublist((tagPage - 1) * chunkSize).take(chunkSize).toList();
    String filter = chunk.map((e) => '~$e').join(' ');
    return posts(
      sitePage,
      search: filter,
      ordered: false,
      limit: limit,
      force: force,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Post> post(int postId, {bool? force, CancelToken? cancelToken}) async {
    Map<String, dynamic> body = await dio
        .get(
          'posts/$postId.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return Post.fromJson(body['post']);
  }

  @override
  Future<void> updatePost(int postId, Map<String, String?> body) async {
    await cache?.deleteFromPath(
      RegExp(RegExp.escape('posts/$postId.json')),
    );

    await dio.put('posts/$postId.json', data: FormData.fromMap(body));
  }

  @override
  Future<void> votePost(int postId, bool upvote, bool replace) async {
    ensureLogin();

    await cache?.deleteFromPath(RegExp(RegExp.escape('posts/$postId.json')));

    await dio.post('posts/$postId/votes.json', queryParameters: {
      'score': upvote ? 1 : -1,
      'no_unvote': replace,
    });
  }

  @override
  Future<void> reportPost(int postId, int reportId, String reason) async {
    await dio.post(
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

  @override
  Future<void> flagPost(int postId, String flag, {int? parent}) async =>
      dio.post(
        'post_flags.json',
        queryParameters: {
          'post_flag[post_id]': postId,
          'post_flag[reason_name]': flag,
          if (flag == 'inferior' && parent != null)
            'post_flag[parent_id]': parent,
        },
      );

  @override
  Future<List<PostWithFavorites>> favorites(
    int page, {
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> body = await dio
        .get(
          'favorites.json',
          queryParameters: {
            'page': page,
            'limit': limit,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return List<Post>.from(body['posts'].map((e) => Post.fromJson(e)));
  }

  @override
  Future<void> addFavorite(int postId) async {
    ensureLogin();

    await cache?.deleteFromPath(RegExp(RegExp.escape('posts/$postId.json')));

    await dio.post('favorites.json', queryParameters: {'post_id': postId});
  }

  @override
  Future<void> removeFavorite(int postId) async {
    ensureLogin();

    await cache?.deleteFromPath(RegExp(RegExp.escape('posts/$postId.json')));

    await dio.delete('favorites/$postId.json');
  }

  @override
  Future<List<Pool>> pools(
    int page, {
    String? search,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    List<dynamic> body = await dio
        .get(
          'pools.json',
          queryParameters: {
            'search[name_matches]': search,
            'page': page,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    List<Pool> pools = [];
    for (Map<String, dynamic> raw in body) {
      Pool pool = e621Pool.fromJson(raw);
      pools.add(pool);
    }

    return pools;
  }

  @override
  Future<Pool> pool(int poolId, {bool? force, CancelToken? cancelToken}) async {
    Map<String, dynamic> body = await dio
        .get(
          'pools/$poolId.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return e621Pool.fromJson(body);
  }

  @override
  Future<List<Post>> poolPosts(
    int poolId,
    int page, {
    bool orderByOldest = false,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    int limit = 80;
    Pool pool = await this.pool(poolId, force: force, cancelToken: cancelToken);
    List<int> ids =
        orderByOldest ? pool.postIds.reversed.toList() : pool.postIds;
    int lower = (page - 1) * limit;
    if (lower > ids.length) return [];
    ids = ids.sublist(lower).take(limit).toList();
    return postsByIds(ids,
        limit: limit, force: force, cancelToken: cancelToken);
  }

  @override
  Future<List<Wiki>> wikis(
    int page, {
    String? search,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    List<dynamic> body = await dio
        .get(
          'wiki_pages.json',
          queryParameters: {
            'search[title]': search,
            'page': page,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return body.map((entry) => e621Wiki.fromJson(entry)).toList();
  }

  @override
  Future<Wiki> wiki(
    String name, {
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> body = await dio
        .get(
          'wiki_pages/$name.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return e621Wiki.fromJson(body);
  }

  @override
  Future<User> user(
    String name, {
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> body = await dio
        .get(
          'users/$name.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return e621User.fromJson(body);
  }

  @override
  Future<void> reportUser(int userId, String reason) async {
    await dio.post(
      'tickets',
      queryParameters: {
        'ticket[reason]': reason,
        'ticket[disp_id]': userId,
        'ticket[qtype]': 'user',
      },
    );
  }

  @override
  Future<CurrentUserWithBlacklist?> currentUser({
    bool? force,
    CancelToken? cancelToken,
  }) async {
    if (!hasLogin) {
      return null;
    }

    Map<String, dynamic> body = await dio
        .get(
          'users/${credentials!.username}.json',
          options: CacheConfig(
            store: memoryCache,
            policy:
                (force ?? false) ? CachePolicy.refresh : CachePolicy.request,
          ).toOptions(),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return e621CurrentUser.fromJson(body);
  }

  @override
  Future<void> updateBlacklist(List<String> denylist) async {
    Map<String, String?> body = {
      'user[blacklisted_tags]': denylist.join('\n'),
    };

    await dio.put('users/${credentials!.username}.json',
        data: FormData.fromMap(body));
  }

  @override
  Future<List<Tag>> tags(
    String search, {
    int? category,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    final body = await dio
        .get(
          'tags.json',
          queryParameters: {
            'search[name_matches]': search,
            'search[category]': category,
            'search[order]': 'count',
            'limit': 3,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);
    List<Tag> tags = [];
    if (body is List<dynamic>) {
      for (final tag in body) {
        tags.add(e621Tag.fromJson(tag));
      }
    }
    return tags;
  }

  @override
  Future<List<TagSuggestion>> autocomplete(
    String search, {
    int? category,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    if (category == null) {
      if (search.length < 3) {
        return [];
      }
      final body = await dio
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
          tags.add(e621TagSuggestion.fromJson(tag));
        }
      }
      return tags;
    } else {
      List<TagSuggestion> tags = [];
      for (final tag in await this.tags(
        '$search*',
        category: category,
        force: force,
      )) {
        tags.add(
          e621TagSuggestion(
            id: tag.id,
            name: tag.name,
            postCount: tag.postCount,
            category: tag.category,
          ),
        );
      }
      return tags;
    }
  }

  @override
  Future<String?> tagAlias(
    String tag, {
    bool? force,
    CancelToken? cancelToken,
  }) async {
    final body = await dio
        .get(
          'tag_aliases.json',
          queryParameters: {
            'search[antecedent_name]': tag,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((value) => value.data);

    if (body is List<dynamic> && body.isNotEmpty) {
      return body.first['consequent_name'];
    }

    return null;
  }

  @override
  Future<List<Comment>> comments(
    int postId,
    String page, {
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Object body = await dio
        .get(
          'comments.json',
          queryParameters: {
            'group_by': 'comment',
            'search[post_id]': postId,
            'page': page,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    List<Comment> comments = [];
    if (body is List<dynamic>) {
      for (Map<String, dynamic> rawComment in body) {
        comments.add(e621Comment.fromJson(rawComment));
      }
    }

    return comments;
  }

  @override
  Future<Comment> comment(
    int commentId, {
    bool? force,
    CancelToken? cancelToken,
  }) async {
    ensureLogin();

    Map<String, dynamic> body = await dio
        .get(
          'comments.json/$commentId.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return e621Comment.fromJson(body);
  }

  @override
  Future<void> postComment(int postId, String text) async {
    ensureLogin();
    await cache?.deleteFromPath(
      RegExp(RegExp.escape('comments.json')),
      queryParams: {'search[post_id]': postId.toString()},
    );

    Map<String, dynamic> body = {
      'comment[body]': text,
      'comment[post_id]': postId,
      'commit': 'Submit',
    };

    await dio.post('comments.json', data: FormData.fromMap(body));
  }

  @override
  Future<void> updateComment(int commentId, int postId, String text) async {
    ensureLogin();
    await cache?.deleteFromPath(
      RegExp(RegExp.escape('comments.json')),
      queryParams: {'search[post_id]': postId.toString()},
    );

    await cache?.deleteFromPath(
      RegExp(RegExp.escape('comments/$commentId.json')),
    );

    Map<String, dynamic> body = {
      'comment[body]': text,
      'comment[post_id]': postId,
      'commit': 'Submit',
    };

    await dio.patch('comments/$commentId.json', data: FormData.fromMap(body));
  }

  @override
  Future<void> voteComment(int commentId, bool upvote, bool replace) async {
    ensureLogin();
    await dio.post(
      'comments/$commentId/votes.json',
      queryParameters: {
        'score': upvote ? 1 : -1,
        'no_unvote': replace,
      },
    );
  }

  @override
  Future<void> reportComment(int commentId, String reason) async {
    ensureLogin();
    await dio.post(
      'tickets',
      queryParameters: {
        'ticket[reason]': reason,
        'ticket[disp_id]': commentId,
        'ticket[qtype]': 'comment',
      },
      options: Options(
        validateStatus: (status) => status == 302,
      ),
    );
  }

  @override
  Future<List<Topic>> topics(
    int page, {
    String? search,
    bool? force,
    CancelToken? cancelToken,
  }) async {
    String? title = search?.isNotEmpty ?? false ? search : null;
    final body = await dio
        .get(
          'forum_topics.json',
          queryParameters: {
            'page': page,
            'search[title_matches]': title,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    List<Topic> threads = [];
    if (body is List<dynamic>) {
      for (Map<String, dynamic> raw in body) {
        threads.add(e621Topic.fromJson(raw));
      }
    }

    return threads;
  }

  @override
  Future<Topic> topic(
    int topicId, {
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> body = await dio
        .get(
          'forum_topics/$topicId.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return e621Topic.fromJson(body);
  }

  @override
  Future<List<Reply>> replies(
    int topicId,
    String page, {
    bool? force,
    CancelToken? cancelToken,
  }) async {
    final body = await dio
        .get(
          'forum_posts.json',
          queryParameters: {
            'search[topic_id]': topicId,
            'page': page,
          },
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    List<Reply> replies = [];
    if (body is List<dynamic>) {
      for (Map<String, dynamic> raw in body) {
        replies.add(e621Reply.fromJson(raw));
      }
    }

    return replies;
  }

  @override
  Future<Reply> reply(
    int replyId, {
    bool? force,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> body = await dio
        .get(
          'forum_posts/$replyId.json',
          options: forceOptions(force),
          cancelToken: cancelToken,
        )
        .then((response) => response.data);

    return e621Reply.fromJson(body);
  }

  @override
  Color? tagCategoryColor(String tag) => _TagCategory.byName(tag).color;

  @override
  int? tagCategoryId(String tag) => _TagCategory.byName(tag).id;

  @override
  String? tagCategoryName(int id) => _TagCategory.byId(id).name;

  @override
  List<String> tagCategories() =>
      _TagCategory.values.map((e) => e.name).toList();
}

enum _TagCategory {
  general,
  species,
  character,
  copyright,
  meta,
  lore,
  artist,
  invalid;

  Color? get color {
    switch (this) {
      case general:
        return Colors.indigo[300];
      case species:
        return Colors.teal[300];
      case character:
        return Colors.lightGreen[300];
      case copyright:
        return Colors.yellow[300];
      case meta:
        return Colors.deepOrange[300];
      case lore:
        return Colors.pink[300];
      case artist:
        return Colors.deepPurple[300];
      case invalid:
      default:
        return Colors.grey[300];
    }
  }

  int get id {
    switch (this) {
      case general:
        return 0;
      case species:
        return 5;
      case character:
        return 4;
      case copyright:
        return 3;
      case meta:
        return 7;
      case lore:
        return 8;
      case artist:
        return 1;
      case invalid:
        return 6;
      default:
        return -1;
    }
  }

  static _TagCategory byId(int id) => values.firstWhere((e) => e.id == id);

  static _TagCategory byName(String name) =>
      values.asNameMap()[name.toLowerCase()]!;
}
