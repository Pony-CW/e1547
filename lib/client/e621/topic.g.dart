// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$e621Topic {
  e621Topic get _self => this as e621Topic;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is e621Topic &&
          runtimeType == other.runtimeType &&
          _self.id == other.id &&
          _self.creatorId == other.creatorId &&
          _self.title == other.title &&
          _self.responseCount == other.responseCount &&
          _self.createdAt == other.createdAt &&
          _self.updatedAt == other.updatedAt &&
          _self.categoryId == other.categoryId;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    hashCode = $hashCombine(hashCode, _self.creatorId.hashCode);
    hashCode = $hashCombine(hashCode, _self.title.hashCode);
    hashCode = $hashCombine(hashCode, _self.responseCount.hashCode);
    hashCode = $hashCombine(hashCode, _self.createdAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.updatedAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.categoryId.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('e621Topic')
        ..add('id', _self.id)
        ..add('creatorId', _self.creatorId)
        ..add('title', _self.title)
        ..add('responseCount', _self.responseCount)
        ..add('createdAt', _self.createdAt)
        ..add('updatedAt', _self.updatedAt)
        ..add('categoryId', _self.categoryId))
      .toString();
  e621Topic copyWith({
    int? id,
    int? creatorId,
    String? title,
    int? responseCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? categoryId,
  }) {
    return e621Topic(
      id: id ?? _self.id,
      creatorId: creatorId ?? _self.creatorId,
      title: title ?? _self.title,
      responseCount: responseCount ?? _self.responseCount,
      createdAt: createdAt ?? _self.createdAt,
      updatedAt: updatedAt ?? _self.updatedAt,
      categoryId: categoryId ?? _self.categoryId,
    );
  }

  e621Topic change(void Function(_e621TopicChanges c) updates) =>
      (_e621TopicChanges._(_self)..update(updates)).build();
  _e621TopicChanges toChanges() => _e621TopicChanges._(_self);
}

class _e621TopicChanges {
  _e621TopicChanges._(e621Topic dc)
      : id = dc.id,
        creatorId = dc.creatorId,
        title = dc.title,
        responseCount = dc.responseCount,
        createdAt = dc.createdAt,
        updatedAt = dc.updatedAt,
        categoryId = dc.categoryId;

  int id;

  int creatorId;

  String title;

  int responseCount;

  DateTime createdAt;

  DateTime updatedAt;

  int categoryId;

  void update(void Function(_e621TopicChanges c) updates) => updates(this);
  e621Topic build() => e621Topic(
        id: id,
        creatorId: creatorId,
        title: title,
        responseCount: responseCount,
        createdAt: createdAt,
        updatedAt: updatedAt,
        categoryId: categoryId,
      );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_e621Topic _$e621TopicFromJson(Map<String, dynamic> json) => _e621Topic(
      id: json['id'] as int,
      creatorId: json['creator_id'] as int,
      updaterId: json['updater_id'] as int,
      title: json['title'] as String,
      responseCount: json['response_count'] as int,
      isSticky: json['is_sticky'] as bool,
      isLocked: json['is_locked'] as bool,
      isHidden: json['is_hidden'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      categoryId: json['category_id'] as int,
    );

Map<String, dynamic> _$e621TopicToJson(_e621Topic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'updater_id': instance.updaterId,
      'title': instance.title,
      'response_count': instance.responseCount,
      'is_sticky': instance.isSticky,
      'is_locked': instance.isLocked,
      'is_hidden': instance.isHidden,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'category_id': instance.categoryId,
    };
