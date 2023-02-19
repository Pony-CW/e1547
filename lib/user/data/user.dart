abstract class User {
  int get id;

  String get name;

  User copyWith({
    int? id,
    String? name,
  });
}

abstract class UserWithAvatar implements User {
  int? get avatarId;

  @override
  User copyWith({
    int? id,
    String? name,
    int? avatarId,
  });
}

abstract class UserWithStats implements User {
  String get levelString;
  int get favoriteCount;
  int get postUpdateCount;
  int get postUploadCount;
  int get forumPostCount;
  int get commentCount;

  @override
  User copyWith({
    int? id,
    String? name,
    String? levelString,
    int? favoriteCount,
    int? postUpdateCount,
    int? postUploadCount,
    int? forumPostCount,
    int? commentCount,
  });
}

abstract class CurrentUser implements User {}

abstract class CurrentUserWithBlacklist implements CurrentUser {
  String get blacklistedTags;

  @override
  User copyWith({
    int? id,
    String? name,
    String? blacklistedTags,
  });
}
