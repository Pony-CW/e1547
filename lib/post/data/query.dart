import 'package:e1547/client/client.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/tag/tag.dart';

extension PostQuerying on PostClient {
  static const queryKey = 'posts';

  CachedQuery get queryCache => dio.queryCache!;

  QueryBridge<Post, int> get postCache => queryCache.bridge(queryKey);

  Query<Post> useGet({required int id, bool? vendored}) => Query(
    cache: queryCache,
    key: [queryKey, id],
    queryFn: () => get(id: id),
    config: postCache.getConfig(vendored: vendored),
  );

  InfiniteQuery<List<int>, int> usePage({
    required QueryMap? query,
    required Client client,
  }) {
    final normalized = _normalizeSearchQuery(
      query,
      username: client.identity.username,
    );
    return InfiniteQuery<List<int>, int>(
      cache: queryCache,
      key: [queryKey, normalized],
      getNextArg: (state) => state.nextPage,
      queryFn: (pageKey) async {
        final result = await _dispatchSearch(
          client: client,
          query: normalized,
          page: pageKey,
        );
        return postCache.savePage(result);
      },
    );
  }

  InfiniteQuery<List<int>, int> useByTags({required List<String> tags}) =>
      InfiniteQuery<List<int>, int>(
        cache: queryCache,
        key: [queryKey, 'by_tags', tags],
        getNextArg: (state) => state.nextPage,
        queryFn: (page) =>
            byTags(tags: tags, page: page).then(postCache.savePage),
      );

  Query<List<Post>> useByIds({required List<int> ids, int? limit}) => Query(
    cache: queryCache,
    key: [queryKey, 'ids', ids, limit],
    queryFn: () => byIds(ids: ids, limit: limit),
  );

  Mutation<void, Map<String, String?>> useUpdate({required int id}) => Mutation(
    mutationFn: (data) => postCache.optimistic(
      id,
      (post) => post,
      () => update(id: id, data: data),
    ),
  );

  Mutation<void, VoteRequest> useVote({required int id}) => Mutation(
    mutationFn: (p) {
      final (:upvote, :replace) = p;
      return postCache.optimistic(
        id,
        (post) => post.withVote(upvote: upvote, replace: replace),
        () => vote(id: id, upvote: upvote, replace: replace),
      );
    },
  );

  Mutation<void, int> useAddFavorite() => Mutation(
    mutationFn: (postId) => postCache.optimistic(
      postId,
      (post) => post.copyWith(isFavorited: true, favCount: post.favCount + 1),
      () => addFavorite(postId),
    ),
  );

  Mutation<void, int> useRemoveFavorite() => Mutation(
    mutationFn: (postId) => postCache.optimistic(
      postId,
      (post) => post.copyWith(isFavorited: false, favCount: post.favCount - 1),
      () => removeFavorite(postId),
    ),
  );
}

QueryMap? _normalizeSearchQuery(QueryMap? query, {String? username}) {
  final tags = TagMap(query?['tags']);
  if (tags.length != 1) return query;
  if (tags['order'] != null) return query;

  if (username != null && tags['fav'] == username) {
    tags['order'] = 'fav';
    return {...?query, 'tags': tags.toString()};
  }
  return query;
}

Future<List<Post>> _dispatchSearch({
  required Client client,
  required QueryMap? query,
  required int page,
}) {
  final tags = TagMap(query?['tags']);
  final username = client.identity.username;

  if (tags.length == 2 &&
      tags['order'] == 'fav' &&
      username != null &&
      tags['fav'] == username) {
    return client.posts.favorites(page: page, force: true);
  }

  return client.posts.page(page: page, query: query);
}
