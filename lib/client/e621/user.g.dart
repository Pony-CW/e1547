// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$e621User {
  e621User get _self => this as e621User;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is e621User &&
          runtimeType == other.runtimeType &&
          _self.id == other.id &&
          _self.name == other.name &&
          _self.avatarId == other.avatarId &&
          _self.commentCount == other.commentCount &&
          _self.favoriteCount == other.favoriteCount &&
          _self.forumPostCount == other.forumPostCount &&
          _self.postUploadCount == other.postUploadCount &&
          _self.levelString == other.levelString &&
          _self.postUpdateCount == other.postUpdateCount;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    hashCode = $hashCombine(hashCode, _self.name.hashCode);
    hashCode = $hashCombine(hashCode, _self.avatarId.hashCode);
    hashCode = $hashCombine(hashCode, _self.commentCount.hashCode);
    hashCode = $hashCombine(hashCode, _self.favoriteCount.hashCode);
    hashCode = $hashCombine(hashCode, _self.forumPostCount.hashCode);
    hashCode = $hashCombine(hashCode, _self.postUploadCount.hashCode);
    hashCode = $hashCombine(hashCode, _self.levelString.hashCode);
    hashCode = $hashCombine(hashCode, _self.postUpdateCount.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('e621User')
        ..add('id', _self.id)
        ..add('name', _self.name)
        ..add('avatarId', _self.avatarId)
        ..add('commentCount', _self.commentCount)
        ..add('favoriteCount', _self.favoriteCount)
        ..add('forumPostCount', _self.forumPostCount)
        ..add('postUploadCount', _self.postUploadCount)
        ..add('levelString', _self.levelString)
        ..add('postUpdateCount', _self.postUpdateCount))
      .toString();
  e621User copyWith({
    int? id,
    String? name,
    int? avatarId,
    int? commentCount,
    int? favoriteCount,
    int? forumPostCount,
    int? postUploadCount,
    String? levelString,
    int? postUpdateCount,
  }) {
    return e621User(
      id: id ?? _self.id,
      name: name ?? _self.name,
      avatarId: avatarId ?? _self.avatarId,
      commentCount: commentCount ?? _self.commentCount,
      favoriteCount: favoriteCount ?? _self.favoriteCount,
      forumPostCount: forumPostCount ?? _self.forumPostCount,
      postUploadCount: postUploadCount ?? _self.postUploadCount,
      levelString: levelString ?? _self.levelString,
      postUpdateCount: postUpdateCount ?? _self.postUpdateCount,
    );
  }

  e621User change(void Function(_e621UserChanges c) updates) =>
      (_e621UserChanges._(_self)..update(updates)).build();
  _e621UserChanges toChanges() => _e621UserChanges._(_self);
}

class _e621UserChanges {
  _e621UserChanges._(e621User dc)
      : id = dc.id,
        name = dc.name,
        avatarId = dc.avatarId,
        commentCount = dc.commentCount,
        favoriteCount = dc.favoriteCount,
        forumPostCount = dc.forumPostCount,
        postUploadCount = dc.postUploadCount,
        levelString = dc.levelString,
        postUpdateCount = dc.postUpdateCount;

  int id;

  String name;

  int? avatarId;

  int commentCount;

  int favoriteCount;

  int forumPostCount;

  int postUploadCount;

  String levelString;

  int postUpdateCount;

  void update(void Function(_e621UserChanges c) updates) => updates(this);
  e621User build() => e621User(
        id: id,
        name: name,
        avatarId: avatarId,
        commentCount: commentCount,
        favoriteCount: favoriteCount,
        forumPostCount: forumPostCount,
        postUploadCount: postUploadCount,
        levelString: levelString,
        postUpdateCount: postUpdateCount,
      );
}

mixin _$e621CurrentUser {
  e621CurrentUser get _self => this as e621CurrentUser;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is e621CurrentUser &&
          runtimeType == other.runtimeType &&
          _self.avatarId == other.avatarId &&
          _self.blacklistedTags == other.blacklistedTags &&
          _self.commentCount == other.commentCount &&
          _self.favoriteCount == other.favoriteCount &&
          _self.forumPostCount == other.forumPostCount &&
          _self.id == other.id &&
          _self.levelString == other.levelString &&
          _self.name == other.name &&
          _self.postUpdateCount == other.postUpdateCount &&
          _self.postUploadCount == other.postUploadCount;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.avatarId.hashCode);
    hashCode = $hashCombine(hashCode, _self.blacklistedTags.hashCode);
    hashCode = $hashCombine(hashCode, _self.commentCount.hashCode);
    hashCode = $hashCombine(hashCode, _self.favoriteCount.hashCode);
    hashCode = $hashCombine(hashCode, _self.forumPostCount.hashCode);
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    hashCode = $hashCombine(hashCode, _self.levelString.hashCode);
    hashCode = $hashCombine(hashCode, _self.name.hashCode);
    hashCode = $hashCombine(hashCode, _self.postUpdateCount.hashCode);
    hashCode = $hashCombine(hashCode, _self.postUploadCount.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('e621CurrentUser')
        ..add('avatarId', _self.avatarId)
        ..add('blacklistedTags', _self.blacklistedTags)
        ..add('commentCount', _self.commentCount)
        ..add('favoriteCount', _self.favoriteCount)
        ..add('forumPostCount', _self.forumPostCount)
        ..add('id', _self.id)
        ..add('levelString', _self.levelString)
        ..add('name', _self.name)
        ..add('postUpdateCount', _self.postUpdateCount)
        ..add('postUploadCount', _self.postUploadCount))
      .toString();
  e621CurrentUser copyWith({
    int? avatarId,
    String? blacklistedTags,
    int? commentCount,
    int? favoriteCount,
    int? forumPostCount,
    int? id,
    String? levelString,
    String? name,
    int? postUpdateCount,
    int? postUploadCount,
  }) {
    return e621CurrentUser(
      id: id ?? _self.id,
      name: name ?? _self.name,
      avatarId: avatarId ?? _self.avatarId,
      commentCount: commentCount ?? _self.commentCount,
      favoriteCount: favoriteCount ?? _self.favoriteCount,
      forumPostCount: forumPostCount ?? _self.forumPostCount,
      postUploadCount: postUploadCount ?? _self.postUploadCount,
      levelString: levelString ?? _self.levelString,
      postUpdateCount: postUpdateCount ?? _self.postUpdateCount,
      blacklistedTags: blacklistedTags ?? _self.blacklistedTags,
    );
  }

  e621CurrentUser change(void Function(_e621CurrentUserChanges c) updates) =>
      (_e621CurrentUserChanges._(_self)..update(updates)).build();
  _e621CurrentUserChanges toChanges() => _e621CurrentUserChanges._(_self);
}

class _e621CurrentUserChanges {
  _e621CurrentUserChanges._(e621CurrentUser dc)
      : avatarId = dc.avatarId,
        blacklistedTags = dc.blacklistedTags,
        commentCount = dc.commentCount,
        favoriteCount = dc.favoriteCount,
        forumPostCount = dc.forumPostCount,
        id = dc.id,
        levelString = dc.levelString,
        name = dc.name,
        postUpdateCount = dc.postUpdateCount,
        postUploadCount = dc.postUploadCount;

  int? avatarId;

  String blacklistedTags;

  int commentCount;

  int favoriteCount;

  int forumPostCount;

  int id;

  String levelString;

  String name;

  int postUpdateCount;

  int postUploadCount;

  void update(void Function(_e621CurrentUserChanges c) updates) =>
      updates(this);
  e621CurrentUser build() => e621CurrentUser(
        id: id,
        name: name,
        avatarId: avatarId,
        commentCount: commentCount,
        favoriteCount: favoriteCount,
        forumPostCount: forumPostCount,
        postUploadCount: postUploadCount,
        levelString: levelString,
        postUpdateCount: postUpdateCount,
        blacklistedTags: blacklistedTags,
      );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_e621User _$e621UserFromJson(Map<String, dynamic> json) => _e621User(
      wikiPageVersionCount: json['wiki_page_version_count'] as int,
      artistVersionCount: json['artist_version_count'] as int,
      poolVersionCount: json['pool_version_count'] as int,
      forumPostCount: json['forum_post_count'] as int,
      commentCount: json['comment_count'] as int,
      flagCount: json['flag_count'] as int,
      favoriteCount: json['favorite_count'] as int,
      positiveFeedbackCount: json['positive_feedback_count'] as int,
      neutralFeedbackCount: json['neutral_feedback_count'] as int,
      negativeFeedbackCount: json['negative_feedback_count'] as int,
      uploadLimit: json['upload_limit'] as int,
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      level: json['level'] as int,
      baseUploadLimit: json['base_upload_limit'] as int,
      postUploadCount: json['post_upload_count'] as int,
      postUpdateCount: json['post_update_count'] as int,
      noteUpdateCount: json['note_update_count'] as int,
      isBanned: json['is_banned'] as bool,
      canApprovePosts: json['can_approve_posts'] as bool,
      canUploadFree: json['can_upload_free'] as bool,
      levelString: json['level_string'] as String,
      avatarId: json['avatar_id'] as int?,
    );

Map<String, dynamic> _$e621UserToJson(_e621User instance) => <String, dynamic>{
      'wiki_page_version_count': instance.wikiPageVersionCount,
      'artist_version_count': instance.artistVersionCount,
      'pool_version_count': instance.poolVersionCount,
      'forum_post_count': instance.forumPostCount,
      'comment_count': instance.commentCount,
      'flag_count': instance.flagCount,
      'favorite_count': instance.favoriteCount,
      'positive_feedback_count': instance.positiveFeedbackCount,
      'neutral_feedback_count': instance.neutralFeedbackCount,
      'negative_feedback_count': instance.negativeFeedbackCount,
      'upload_limit': instance.uploadLimit,
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'level': instance.level,
      'base_upload_limit': instance.baseUploadLimit,
      'post_upload_count': instance.postUploadCount,
      'post_update_count': instance.postUpdateCount,
      'note_update_count': instance.noteUpdateCount,
      'is_banned': instance.isBanned,
      'can_approve_posts': instance.canApprovePosts,
      'can_upload_free': instance.canUploadFree,
      'level_string': instance.levelString,
      'avatar_id': instance.avatarId,
    };

_e621CurrentUser _$e621CurrentUserFromJson(Map<String, dynamic> json) =>
    _e621CurrentUser(
      wikiPageVersionCount: json['wiki_page_version_count'] as int,
      artistVersionCount: json['artist_version_count'] as int,
      poolVersionCount: json['pool_version_count'] as int,
      forumPostCount: json['forum_post_count'] as int,
      commentCount: json['comment_count'] as int,
      flagCount: json['flag_count'] as int,
      positiveFeedbackCount: json['positive_feedback_count'] as int,
      neutralFeedbackCount: json['neutral_feedback_count'] as int,
      negativeFeedbackCount: json['negative_feedback_count'] as int,
      uploadLimit: json['upload_limit'] as int,
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      level: json['level'] as int,
      baseUploadLimit: json['base_upload_limit'] as int,
      postUploadCount: json['post_upload_count'] as int,
      postUpdateCount: json['post_update_count'] as int,
      noteUpdateCount: json['note_update_count'] as int,
      isBanned: json['is_banned'] as bool,
      canApprovePosts: json['can_approve_posts'] as bool,
      canUploadFree: json['can_upload_free'] as bool,
      levelString: json['level_string'] as String,
      avatarId: json['avatar_id'] as int?,
      showAvatars: json['show_avatars'] as bool,
      blacklistAvatars: json['blacklist_avatars'] as bool,
      blacklistUsers: json['blacklist_users'] as bool,
      descriptionCollapsedInitially:
          json['description_collapsed_initially'] as bool,
      hideComments: json['hide_comments'] as bool,
      showHiddenComments: json['show_hidden_comments'] as bool,
      showPostStatistics: json['show_post_statistics'] as bool,
      hasMail: json['has_mail'] as bool,
      receiveEmailNotifications: json['receive_email_notifications'] as bool,
      enableKeyboardNavigation: json['enable_keyboard_navigation'] as bool,
      enablePrivacyMode: json['enable_privacy_mode'] as bool,
      styleUsernames: json['style_usernames'] as bool,
      enableAutoComplete: json['enable_auto_complete'] as bool,
      hasSavedSearches: json['has_saved_searches'] as bool,
      disableCroppedThumbnails: json['disable_cropped_thumbnails'] as bool,
      disableMobileGestures: json['disable_mobile_gestures'] as bool,
      enableSafeMode: json['enable_safe_mode'] as bool,
      disableResponsiveMode: json['disable_responsive_mode'] as bool,
      disablePostTooltips: json['disable_post_tooltips'] as bool,
      noFlagging: json['no_flagging'] as bool,
      noFeedback: json['no_feedback'] as bool,
      disableUserDmails: json['disable_user_dmails'] as bool,
      enableCompactUploader: json['enable_compact_uploader'] as bool,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      email: json['email'] as String,
      lastLoggedInAt: DateTime.parse(json['last_logged_in_at'] as String),
      lastForumReadAt: json['last_forum_read_at'] == null
          ? null
          : DateTime.parse(json['last_forum_read_at'] as String),
      recentTags: json['recent_tags'] as String?,
      commentThreshold: json['comment_threshold'] as int,
      defaultImageSize: json['default_image_size'] as String,
      favoriteTags: json['favorite_tags'] as String?,
      blacklistedTags: json['blacklisted_tags'] as String,
      timeZone: json['time_zone'] as String,
      perPage: json['per_page'] as int,
      customStyle: json['custom_style'] as String?,
      favoriteCount: json['favorite_count'] as int,
      apiRegenMultiplier: json['api_regen_multiplier'] as int,
      apiBurstLimit: json['api_burst_limit'] as int,
      remainingApiLimit: json['remaining_api_limit'] as int,
      statementTimeout: json['statement_timeout'] as int,
      favoriteLimit: json['favorite_limit'] as int,
      tagQueryLimit: json['tag_query_limit'] as int,
    );

Map<String, dynamic> _$e621CurrentUserToJson(_e621CurrentUser instance) =>
    <String, dynamic>{
      'wiki_page_version_count': instance.wikiPageVersionCount,
      'artist_version_count': instance.artistVersionCount,
      'pool_version_count': instance.poolVersionCount,
      'forum_post_count': instance.forumPostCount,
      'comment_count': instance.commentCount,
      'flag_count': instance.flagCount,
      'positive_feedback_count': instance.positiveFeedbackCount,
      'neutral_feedback_count': instance.neutralFeedbackCount,
      'negative_feedback_count': instance.negativeFeedbackCount,
      'upload_limit': instance.uploadLimit,
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'level': instance.level,
      'base_upload_limit': instance.baseUploadLimit,
      'post_upload_count': instance.postUploadCount,
      'post_update_count': instance.postUpdateCount,
      'note_update_count': instance.noteUpdateCount,
      'is_banned': instance.isBanned,
      'can_approve_posts': instance.canApprovePosts,
      'can_upload_free': instance.canUploadFree,
      'level_string': instance.levelString,
      'avatar_id': instance.avatarId,
      'show_avatars': instance.showAvatars,
      'blacklist_avatars': instance.blacklistAvatars,
      'blacklist_users': instance.blacklistUsers,
      'description_collapsed_initially': instance.descriptionCollapsedInitially,
      'hide_comments': instance.hideComments,
      'show_hidden_comments': instance.showHiddenComments,
      'show_post_statistics': instance.showPostStatistics,
      'has_mail': instance.hasMail,
      'receive_email_notifications': instance.receiveEmailNotifications,
      'enable_keyboard_navigation': instance.enableKeyboardNavigation,
      'enable_privacy_mode': instance.enablePrivacyMode,
      'style_usernames': instance.styleUsernames,
      'enable_auto_complete': instance.enableAutoComplete,
      'has_saved_searches': instance.hasSavedSearches,
      'disable_cropped_thumbnails': instance.disableCroppedThumbnails,
      'disable_mobile_gestures': instance.disableMobileGestures,
      'enable_safe_mode': instance.enableSafeMode,
      'disable_responsive_mode': instance.disableResponsiveMode,
      'disable_post_tooltips': instance.disablePostTooltips,
      'no_flagging': instance.noFlagging,
      'no_feedback': instance.noFeedback,
      'disable_user_dmails': instance.disableUserDmails,
      'enable_compact_uploader': instance.enableCompactUploader,
      'updated_at': instance.updatedAt.toIso8601String(),
      'email': instance.email,
      'last_logged_in_at': instance.lastLoggedInAt.toIso8601String(),
      'last_forum_read_at': instance.lastForumReadAt?.toIso8601String(),
      'recent_tags': instance.recentTags,
      'comment_threshold': instance.commentThreshold,
      'default_image_size': instance.defaultImageSize,
      'favorite_tags': instance.favoriteTags,
      'blacklisted_tags': instance.blacklistedTags,
      'time_zone': instance.timeZone,
      'per_page': instance.perPage,
      'custom_style': instance.customStyle,
      'favorite_count': instance.favoriteCount,
      'api_regen_multiplier': instance.apiRegenMultiplier,
      'api_burst_limit': instance.apiBurstLimit,
      'remaining_api_limit': instance.remainingApiLimit,
      'statement_timeout': instance.statementTimeout,
      'favorite_limit': instance.favoriteLimit,
      'tag_query_limit': instance.tagQueryLimit,
    };
