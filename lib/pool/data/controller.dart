import 'package:e1547/client/client.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/foundation.dart';

class PoolController extends PageClientDataController<Pool> {
  PoolController({required this.client, QueryMap? query})
    : _query = query ?? QueryMap();

  @override
  final Client client;

  QueryMap _query;
  QueryMap get query => _query;
  set query(QueryMap value) {
    if (mapEquals(_query, value)) return;
    _query = Map.of(value);
    refresh();
  }

  @override
  @protected
  Future<List<Pool>> fetch(int page, bool force) async {
    final pools = await client.pools.page(
      page: page,
      query: query,
      force: force,
      cancelToken: cancelToken,
    );
    _prefetchThumbnails(pools);
    return pools;
  }

  void _prefetchThumbnails(List<Pool> pools) {
    final ids = pools
        .map((e) => e.postIds.isNotEmpty ? e.postIds.first : null)
        .whereType<int>()
        .toList();
    if (ids.isEmpty) return;
    client.posts
        .byIds(ids: ids, cancelToken: cancelToken)
        .then(client.posts.postCache.savePage)
        .ignore();
  }
}

class PoolsProvider extends SubChangeNotifierProvider<Client, PoolController> {
  PoolsProvider({QueryMap? search, super.child, super.builder})
    : super(
        create: (context, client) =>
            PoolController(client: client, query: search),
        keys: (context) => [search],
      );
}
