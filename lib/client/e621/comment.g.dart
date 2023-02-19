// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$e621Comment {
  e621Comment get _self => this as e621Comment;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is e621Comment &&
          runtimeType == other.runtimeType &&
          _self.id == other.id &&
          _self.createdAt == other.createdAt &&
          _self.postId == other.postId &&
          _self.creatorId == other.creatorId &&
          _self.body == other.body &&
          _self.score == other.score &&
          _self.updatedAt == other.updatedAt &&
          _self.warningType == other.warningType &&
          _self.warningUserId == other.warningUserId &&
          _self.creatorName == other.creatorName &&
          _self.voteStatus == other.voteStatus;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    hashCode = $hashCombine(hashCode, _self.createdAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.postId.hashCode);
    hashCode = $hashCombine(hashCode, _self.creatorId.hashCode);
    hashCode = $hashCombine(hashCode, _self.body.hashCode);
    hashCode = $hashCombine(hashCode, _self.score.hashCode);
    hashCode = $hashCombine(hashCode, _self.updatedAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.warningType.hashCode);
    hashCode = $hashCombine(hashCode, _self.warningUserId.hashCode);
    hashCode = $hashCombine(hashCode, _self.creatorName.hashCode);
    hashCode = $hashCombine(hashCode, _self.voteStatus.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('e621Comment')
        ..add('id', _self.id)
        ..add('createdAt', _self.createdAt)
        ..add('postId', _self.postId)
        ..add('creatorId', _self.creatorId)
        ..add('body', _self.body)
        ..add('score', _self.score)
        ..add('updatedAt', _self.updatedAt)
        ..add('warningType', _self.warningType)
        ..add('warningUserId', _self.warningUserId)
        ..add('creatorName', _self.creatorName)
        ..add('voteStatus', _self.voteStatus))
      .toString();
  e621Comment copyWith({
    int? id,
    DateTime? createdAt,
    int? postId,
    int? creatorId,
    String? body,
    int? score,
    DateTime? updatedAt,
    WarningType? warningType,
    int? warningUserId,
    String? creatorName,
    VoteStatus? voteStatus,
  }) {
    return e621Comment(
      id: id ?? _self.id,
      createdAt: createdAt ?? _self.createdAt,
      postId: postId ?? _self.postId,
      creatorId: creatorId ?? _self.creatorId,
      body: body ?? _self.body,
      score: score ?? _self.score,
      updatedAt: updatedAt ?? _self.updatedAt,
      warningType: warningType ?? _self.warningType,
      warningUserId: warningUserId ?? _self.warningUserId,
      creatorName: creatorName ?? _self.creatorName,
      voteStatus: voteStatus ?? _self.voteStatus,
    );
  }

  e621Comment change(void Function(_e621CommentChanges c) updates) =>
      (_e621CommentChanges._(_self)..update(updates)).build();
  _e621CommentChanges toChanges() => _e621CommentChanges._(_self);
}

class _e621CommentChanges {
  _e621CommentChanges._(e621Comment dc)
      : id = dc.id,
        createdAt = dc.createdAt,
        postId = dc.postId,
        creatorId = dc.creatorId,
        body = dc.body,
        score = dc.score,
        updatedAt = dc.updatedAt,
        warningType = dc.warningType,
        warningUserId = dc.warningUserId,
        creatorName = dc.creatorName,
        voteStatus = dc.voteStatus;

  int id;

  DateTime createdAt;

  int postId;

  int creatorId;

  String body;

  int score;

  DateTime updatedAt;

  WarningType? warningType;

  int? warningUserId;

  String creatorName;

  VoteStatus voteStatus;

  void update(void Function(_e621CommentChanges c) updates) => updates(this);
  e621Comment build() => e621Comment(
        id: id,
        createdAt: createdAt,
        postId: postId,
        creatorId: creatorId,
        body: body,
        score: score,
        updatedAt: updatedAt,
        warningType: warningType,
        warningUserId: warningUserId,
        creatorName: creatorName,
        voteStatus: voteStatus,
      );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_e621Comment _$e621CommentFromJson(Map<String, dynamic> json) => _e621Comment(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      postId: json['post_id'] as int,
      creatorId: json['creator_id'] as int,
      body: json['body'] as String,
      score: json['score'] as int,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      updaterId: json['updater_id'] as int,
      doNotBumpPost: json['do_not_bump_post'] as bool,
      isHidden: json['is_hidden'] as bool,
      isSticky: json['is_sticky'] as bool,
      warningType:
          $enumDecodeNullable(_$WarningTypeEnumMap, json['warning_type']),
      warningUserId: json['warning_user_id'] as int?,
      creatorName: json['creator_name'] as String,
      updaterName: json['updater_name'] as String,
    );

Map<String, dynamic> _$e621CommentToJson(_e621Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'post_id': instance.postId,
      'creator_id': instance.creatorId,
      'body': instance.body,
      'score': instance.score,
      'updated_at': instance.updatedAt.toIso8601String(),
      'updater_id': instance.updaterId,
      'do_not_bump_post': instance.doNotBumpPost,
      'is_hidden': instance.isHidden,
      'is_sticky': instance.isSticky,
      'warning_type': _$WarningTypeEnumMap[instance.warningType],
      'warning_user_id': instance.warningUserId,
      'creator_name': instance.creatorName,
      'updater_name': instance.updaterName,
    };

const _$WarningTypeEnumMap = {
  WarningType.warning: 'warning',
  WarningType.record: 'record',
  WarningType.ban: 'ban',
};
