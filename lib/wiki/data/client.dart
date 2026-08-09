import 'package:dio/dio.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/wiki/wiki.dart';

class WikiClient {
  WikiClient({required this.dio});

  final Dio dio;

  Future<Wiki> get({required int id, bool? force, CancelToken? cancelToken}) =>
      _get(id.toString(), force: force, cancelToken: cancelToken);

  Future<Wiki> getByTitle({
    required String title,
    bool? force,
    CancelToken? cancelToken,
  }) => _get(title, force: force, cancelToken: cancelToken);

  Future<Wiki> _get(String lookup, {bool? force, CancelToken? cancelToken}) =>
      dio
          .get(
            '/wiki_pages/$lookup.json',
            options: forceOptions(force),
            cancelToken: cancelToken,
          )
          .then((response) => E621Wiki.fromJson(response.data));

  Future<List<Wiki>> page({
    int? page,
    int? limit,
    QueryMap? query,
    bool? force,
    CancelToken? cancelToken,
  }) => dio
      .get(
        '/wiki_pages.json',
        queryParameters: {'page': page, 'limit': limit, ...?query},
        options: forceOptions(force),
        cancelToken: cancelToken,
      )
      .then(unwrapRailsArray)
      .then(
        (response) =>
            (response.data as List).map<Wiki>(E621Wiki.fromJson).toList(),
      );
}
