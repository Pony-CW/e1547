import 'package:e1547/client/client.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';

abstract class PoolClient implements Client {
  Future<List<Pool>> pools(
    int page, {
    String? search,
    bool? force,
    CancelToken? cancelToken,
  });

  Future<Pool> pool(int poolId, {bool? force, CancelToken? cancelToken});

  Future<List<Post>> poolPosts(
    int poolId,
    int page, {
    bool orderByOldest = false,
    bool? force,
    CancelToken? cancelToken,
  });
}
