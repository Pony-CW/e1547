import 'dart:math';

import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/shared/shared.dart';

extension PoolQuerying on PoolClient {
  static const queryKey = 'pools';

  CachedQuery get queryCache => dio.queryCache!;

  QueryBridge<Pool, int> get poolCache => queryCache.bridge(queryKey);

  Query<Pool> useGet({required int id, bool? vendored}) => Query(
    cache: queryCache,
    key: [queryKey, id],
    queryFn: () => get(id: id, force: true),
    config: poolCache.getConfig(vendored: vendored),
  );

  InfiniteQuery<List<int>, int> usePage({required QueryMap? query}) =>
      InfiniteQuery<List<int>, int>(
        cache: queryCache,
        key: [queryKey, query],
        getNextArg: (state) => state.nextPage,
        queryFn: (key) =>
            page(page: key, query: query, force: true).then(poolCache.savePage),
      );

  InfiniteQuery<List<int>, int> usePosts({
    required int id,
    required PostClient posts,
    bool orderByOldest = true,
  }) => InfiniteQuery<List<int>, int>(
    cache: queryCache,
    key: [queryKey, id, 'posts', orderByOldest],
    getNextArg: (state) => state.nextPage,
    queryFn: (page) async {
      final pool = await get(id: id);
      var ids = pool.postIds;
      if (!orderByOldest) ids = ids.reversed.toList();
      const perPage = 75;
      final lower = (page - 1) * perPage;
      if (lower >= ids.length) return const [];
      final slice = ids.sublist(lower, min(lower + perPage, ids.length));
      final fetched = await posts.byIds(ids: slice);
      return posts.postCache.savePage(fetched);
    },
  );
}
