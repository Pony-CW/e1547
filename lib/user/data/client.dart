import 'package:dio/dio.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/user/user.dart';

class UserClient {
  UserClient({required this.dio});

  final Dio dio;

  // Technically missing users()
  Future<User> get({required int id, bool? force, CancelToken? cancelToken}) =>
      _get(id.toString(), force: force, cancelToken: cancelToken);

  Future<User> getByName({
    required String name,
    bool? force,
    CancelToken? cancelToken,
  }) => _get(name, force: force, cancelToken: cancelToken);

  Future<User> _get(String lookup, {bool? force, CancelToken? cancelToken}) =>
      dio
          .get(
            '/users/$lookup.json',
            options: forceOptions(force),
            cancelToken: cancelToken,
          )
          .then((response) => E621User.fromJson(response.data));
}
