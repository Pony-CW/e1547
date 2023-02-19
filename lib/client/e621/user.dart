import 'package:e1547/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'user.g.dart';

@JsonSerializable()
// ignore: camel_case_types
class _e621User {
  const _e621User({
    required this.wikiPageVersionCount,
    required this.artistVersionCount,
    required this.poolVersionCount,
    required this.forumPostCount,
    required this.commentCount,
    required this.flagCount,
    required this.favoriteCount,
    required this.positiveFeedbackCount,
    required this.neutralFeedbackCount,
    required this.negativeFeedbackCount,
    required this.uploadLimit,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.level,
    required this.baseUploadLimit,
    required this.postUploadCount,
    required this.postUpdateCount,
    required this.noteUpdateCount,
    required this.isBanned,
    required this.canApprovePosts,
    required this.canUploadFree,
    required this.levelString,
    required this.avatarId,
  });

  factory _e621User.fromJson(dynamic json) => _$e621UserFromJson(json);

  final int wikiPageVersionCount;
  final int artistVersionCount;
  final int poolVersionCount;
  final int forumPostCount;
  final int commentCount;
  final int flagCount;
  final int favoriteCount;
  final int positiveFeedbackCount;
  final int neutralFeedbackCount;
  final int negativeFeedbackCount;
  final int uploadLimit;
  final int id;
  final DateTime createdAt;
  final String name;
  final int level;
  final int baseUploadLimit;
  final int postUploadCount;
  final int postUpdateCount;
  final int noteUpdateCount;
  final bool isBanned;
  final bool canApprovePosts;
  final bool canUploadFree;
  final String levelString;
  final int? avatarId;
}

@DataClass()
// ignore: camel_case_types
class e621User with _$e621User implements User, UserWithAvatar, UserWithStats {
  const e621User({
    required this.id,
    required this.name,
    required this.avatarId,
    required this.commentCount,
    required this.favoriteCount,
    required this.forumPostCount,
    required this.postUploadCount,
    required this.levelString,
    required this.postUpdateCount,
  });

  factory e621User.fromJson(dynamic json) {
    final raw = _e621User.fromJson(json);
    return e621User(
      id: raw.id,
      name: raw.name,
      avatarId: raw.avatarId,
      commentCount: raw.commentCount,
      favoriteCount: raw.favoriteCount,
      forumPostCount: raw.forumPostCount,
      postUploadCount: raw.postUploadCount,
      levelString: raw.levelString,
      postUpdateCount: raw.postUpdateCount,
    );
  }

  @override
  final int id;

  @override
  final String name;

  @override
  final int? avatarId;

  @override
  final int commentCount;

  @override
  final int favoriteCount;

  @override
  final int forumPostCount;

  @override
  final int postUploadCount;

  @override
  final String levelString;

  @override
  final int postUpdateCount;
}

@JsonSerializable()
// ignore: camel_case_types
class _e621CurrentUser {
  _e621CurrentUser({
    required this.wikiPageVersionCount,
    required this.artistVersionCount,
    required this.poolVersionCount,
    required this.forumPostCount,
    required this.commentCount,
    required this.flagCount,
    required this.positiveFeedbackCount,
    required this.neutralFeedbackCount,
    required this.negativeFeedbackCount,
    required this.uploadLimit,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.level,
    required this.baseUploadLimit,
    required this.postUploadCount,
    required this.postUpdateCount,
    required this.noteUpdateCount,
    required this.isBanned,
    required this.canApprovePosts,
    required this.canUploadFree,
    required this.levelString,
    required this.avatarId,
    required this.showAvatars,
    required this.blacklistAvatars,
    required this.blacklistUsers,
    required this.descriptionCollapsedInitially,
    required this.hideComments,
    required this.showHiddenComments,
    required this.showPostStatistics,
    required this.hasMail,
    required this.receiveEmailNotifications,
    required this.enableKeyboardNavigation,
    required this.enablePrivacyMode,
    required this.styleUsernames,
    required this.enableAutoComplete,
    required this.hasSavedSearches,
    required this.disableCroppedThumbnails,
    required this.disableMobileGestures,
    required this.enableSafeMode,
    required this.disableResponsiveMode,
    required this.disablePostTooltips,
    required this.noFlagging,
    required this.noFeedback,
    required this.disableUserDmails,
    required this.enableCompactUploader,
    required this.updatedAt,
    required this.email,
    required this.lastLoggedInAt,
    required this.lastForumReadAt,
    required this.recentTags,
    required this.commentThreshold,
    required this.defaultImageSize,
    required this.favoriteTags,
    required this.blacklistedTags,
    required this.timeZone,
    required this.perPage,
    required this.customStyle,
    required this.favoriteCount,
    required this.apiRegenMultiplier,
    required this.apiBurstLimit,
    required this.remainingApiLimit,
    required this.statementTimeout,
    required this.favoriteLimit,
    required this.tagQueryLimit,
  });

  factory _e621CurrentUser.fromJson(dynamic json) =>
      _$e621CurrentUserFromJson(json);

  final int wikiPageVersionCount;
  final int artistVersionCount;
  final int poolVersionCount;
  final int forumPostCount;
  final int commentCount;
  final int flagCount;
  final int positiveFeedbackCount;
  final int neutralFeedbackCount;
  final int negativeFeedbackCount;
  final int uploadLimit;
  final int id;
  final DateTime createdAt;
  final String name;
  final int level;
  final int baseUploadLimit;
  final int postUploadCount;
  final int postUpdateCount;
  final int noteUpdateCount;
  final bool isBanned;
  final bool canApprovePosts;
  final bool canUploadFree;
  final String levelString;
  final int? avatarId;
  final bool showAvatars;
  final bool blacklistAvatars;
  final bool blacklistUsers;
  final bool descriptionCollapsedInitially;
  final bool hideComments;
  final bool showHiddenComments;
  final bool showPostStatistics;
  final bool hasMail;
  final bool receiveEmailNotifications;
  final bool enableKeyboardNavigation;
  final bool enablePrivacyMode;
  final bool styleUsernames;
  final bool enableAutoComplete;
  final bool hasSavedSearches;
  final bool disableCroppedThumbnails;
  final bool disableMobileGestures;
  final bool enableSafeMode;
  final bool disableResponsiveMode;
  final bool disablePostTooltips;
  final bool noFlagging;
  final bool noFeedback;
  final bool disableUserDmails;
  final bool enableCompactUploader;
  final DateTime updatedAt;
  final String email;
  final DateTime lastLoggedInAt;
  final DateTime? lastForumReadAt;
  final String? recentTags;
  final int commentThreshold;
  final String defaultImageSize;
  final String? favoriteTags;
  final String blacklistedTags;
  final String timeZone;
  final int perPage;
  final String? customStyle;
  final int favoriteCount;
  final int apiRegenMultiplier;
  final int apiBurstLimit;
  final int remainingApiLimit;
  final int statementTimeout;
  final int favoriteLimit;
  final int tagQueryLimit;
}

@DataClass()
// ignore: camel_case_types
class e621CurrentUser
    with _$e621CurrentUser
    implements User, UserWithAvatar, UserWithStats, CurrentUserWithBlacklist {
  e621CurrentUser({
    required this.id,
    required this.name,
    required this.avatarId,
    required this.commentCount,
    required this.favoriteCount,
    required this.forumPostCount,
    required this.postUploadCount,
    required this.levelString,
    required this.postUpdateCount,
    required this.blacklistedTags,
  });

  factory e621CurrentUser.fromJson(dynamic json) {
    final raw = _e621CurrentUser.fromJson(json);
    return e621CurrentUser(
      id: raw.id,
      name: raw.name,
      avatarId: raw.avatarId,
      commentCount: raw.commentCount,
      favoriteCount: raw.favoriteCount,
      forumPostCount: raw.forumPostCount,
      postUploadCount: raw.postUploadCount,
      levelString: raw.levelString,
      postUpdateCount: raw.postUpdateCount,
      blacklistedTags: raw.blacklistedTags,
    );
  }

  @override
  final int? avatarId;

  @override
  final String blacklistedTags;

  @override
  final int commentCount;

  @override
  final int favoriteCount;

  @override
  final int forumPostCount;

  @override
  final int id;

  @override
  final String levelString;

  @override
  final String name;

  @override
  final int postUpdateCount;

  @override
  final int postUploadCount;
}
