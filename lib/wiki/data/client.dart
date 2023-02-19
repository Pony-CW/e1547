import 'package:e1547/client/client.dart';
import 'package:e1547/wiki/wiki.dart';

abstract class WikiClient implements Client {
  Future<List<Wiki>> wikis(
    int page, {
    String? search,
    bool? force,
    CancelToken? cancelToken,
  });

  Future<Wiki> wiki(
    String name, {
    bool? force,
    CancelToken? cancelToken,
  });
}
