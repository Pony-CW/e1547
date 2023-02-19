import 'package:e1547/user/user.dart';

extension Linking on User {
  String get link => '/users/$name';
}

extension UserAvatarIds on User {
  int? get avatarIdOrNull {
    User userWithAvatar = this;
    if (userWithAvatar is UserWithAvatar) {
      return userWithAvatar.avatarId;
    }
    return null;
  }
}
