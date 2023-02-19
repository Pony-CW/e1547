// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$e621Reply {
  e621Reply get _self => this as e621Reply;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is e621Reply &&
          runtimeType == other.runtimeType &&
          _self.id == other.id &&
          _self.topicId == other.topicId &&
          _self.createdAt == other.createdAt &&
          _self.updatedAt == other.updatedAt &&
          _self.body == other.body &&
          _self.creatorId == other.creatorId &&
          _self.warningType == other.warningType &&
          _self.warningUserId == other.warningUserId;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    hashCode = $hashCombine(hashCode, _self.topicId.hashCode);
    hashCode = $hashCombine(hashCode, _self.createdAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.updatedAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.body.hashCode);
    hashCode = $hashCombine(hashCode, _self.creatorId.hashCode);
    hashCode = $hashCombine(hashCode, _self.warningType.hashCode);
    hashCode = $hashCombine(hashCode, _self.warningUserId.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('e621Reply')
        ..add('id', _self.id)
        ..add('topicId', _self.topicId)
        ..add('createdAt', _self.createdAt)
        ..add('updatedAt', _self.updatedAt)
        ..add('body', _self.body)
        ..add('creatorId', _self.creatorId)
        ..add('warningType', _self.warningType)
        ..add('warningUserId', _self.warningUserId))
      .toString();
  e621Reply copyWith({
    int? id,
    int? topicId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? body,
    int? creatorId,
    WarningType? warningType,
    int? warningUserId,
  }) {
    return e621Reply(
      id: id ?? _self.id,
      topicId: topicId ?? _self.topicId,
      createdAt: createdAt ?? _self.createdAt,
      updatedAt: updatedAt ?? _self.updatedAt,
      body: body ?? _self.body,
      creatorId: creatorId ?? _self.creatorId,
      warningType: warningType ?? _self.warningType,
      warningUserId: warningUserId ?? _self.warningUserId,
    );
  }

  e621Reply change(void Function(_e621ReplyChanges c) updates) =>
      (_e621ReplyChanges._(_self)..update(updates)).build();
  _e621ReplyChanges toChanges() => _e621ReplyChanges._(_self);
}

class _e621ReplyChanges {
  _e621ReplyChanges._(e621Reply dc)
      : id = dc.id,
        topicId = dc.topicId,
        createdAt = dc.createdAt,
        updatedAt = dc.updatedAt,
        body = dc.body,
        creatorId = dc.creatorId,
        warningType = dc.warningType,
        warningUserId = dc.warningUserId;

  int id;

  int topicId;

  DateTime createdAt;

  DateTime updatedAt;

  String body;

  int creatorId;

  WarningType? warningType;

  int? warningUserId;

  void update(void Function(_e621ReplyChanges c) updates) => updates(this);
  e621Reply build() => e621Reply(
        id: id,
        topicId: topicId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        body: body,
        creatorId: creatorId,
        warningType: warningType,
        warningUserId: warningUserId,
      );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_e621Reply _$e621ReplyFromJson(Map<String, dynamic> json) => _e621Reply(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      body: json['body'] as String,
      creatorId: json['creator_id'] as int,
      updaterId: json['updater_id'] as int?,
      topicId: json['topic_id'] as int,
      isHidden: json['is_hidden'] as bool,
      warningType:
          $enumDecodeNullable(_$WarningTypeEnumMap, json['warning_type']),
      warningUserId: json['warning_user_id'] as int?,
    );

Map<String, dynamic> _$e621ReplyToJson(_e621Reply instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'body': instance.body,
      'creator_id': instance.creatorId,
      'updater_id': instance.updaterId,
      'topic_id': instance.topicId,
      'is_hidden': instance.isHidden,
      'warning_type': _$WarningTypeEnumMap[instance.warningType],
      'warning_user_id': instance.warningUserId,
    };

const _$WarningTypeEnumMap = {
  WarningType.warning: 'warning',
  WarningType.record: 'record',
  WarningType.ban: 'ban',
};
