import 'package:e1547/client/client.dart';
import 'package:e1547/user/user.dart';

abstract class UserClient implements Client {
  Future<User> user(
    String name, {
    bool? force,
    CancelToken? cancelToken,
  });

  Future<CurrentUser?> currentUser({
    bool? force,
    CancelToken? cancelToken,
  });
}

abstract class UserReportClient implements UserClient {
  Future<void> reportUser(int userId, String reason);
}

abstract class UserBlacklistClient implements UserClient {
  @override
  Future<CurrentUserWithBlacklist?> currentUser({
    bool? force,
    CancelToken? cancelToken,
  });

  Future<void> updateBlacklist(List<String> denylist);
}
