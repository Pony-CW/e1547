import 'dart:math';

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

  InfiniteQuery<List<int>, int> useSearch({
    required PostParams params,
    required Client client,
  }) {
    final normalized = _normalizeSearchParams(
      params,
      identity: client.identity.username,
    );
    return InfiniteQuery<List<int>, int>(
      cache: queryCache,
      key: [queryKey, 'search', normalized],
      getNextArg: (state) => state.nextPage,
      queryFn: (pageKey) async {
        final result = await _dispatchSearch(
          client: client,
          params: normalized,
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
        queryFn: (page) => byTags(
          tags: tags,
          page: page,
          force: true,
        ).then(postCache.savePage),
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

PostParams _normalizeSearchParams(PostParams params, {String? identity}) {
  final tags = TagMap(params.tags);
  if (tags.length != 1) return params;
  if (tags['order'] != null) return params;

  if (int.tryParse(tags['pool'] ?? '') != null) {
    tags['order'] = 'pool';
    return params.copyWith(tags: tags.toString());
  }
  if (identity != null && tags['fav'] == identity) {
    tags['order'] = 'fav';
    return params.copyWith(tags: tags.toString());
  }
  return params;
}

Future<List<Post>> _dispatchSearch({
  required Client client,
  required PostParams params,
  required int page,
}) {
  final tags = TagMap(params.tags);
  final identity = client.identity.username;

  if (tags.length == 2 &&
      tags['order'] == 'pool' &&
      int.tryParse(tags['pool'] ?? '') != null) {
    return _fetchPoolPage(
      client: client,
      poolId: int.parse(tags['pool']!),
      page: page,
    );
  }

  if (tags.length == 2 &&
      tags['order'] == 'fav' &&
      identity != null &&
      tags['fav'] == identity) {
    return client.posts.favorites(page: page, force: true);
  }

  return client.posts.page(page: page, query: params.toQuery());
}

Future<List<Post>> _fetchPoolPage({
  required Client client,
  required int poolId,
  required int page,
}) async {
  final pool = await client.pools.get(id: poolId);
  final perPage = client.traits.value.perPage ?? 75;
  final ids = pool.postIds;
  final lower = (page - 1) * perPage;
  if (lower >= ids.length) return const [];
  final slice = ids.sublist(lower, min(lower + perPage, ids.length));
  return client.posts.byIds(ids: slice);
}
