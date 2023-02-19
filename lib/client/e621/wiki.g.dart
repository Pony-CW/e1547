// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiki.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$e621Wiki {
  e621Wiki get _self => this as e621Wiki;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is e621Wiki &&
          runtimeType == other.runtimeType &&
          _self.id == other.id &&
          _self.createdAt == other.createdAt &&
          _self.updatedAt == other.updatedAt &&
          _self.title == other.title &&
          _self.body == other.body &&
          _self.category == other.category;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    hashCode = $hashCombine(hashCode, _self.createdAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.updatedAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.title.hashCode);
    hashCode = $hashCombine(hashCode, _self.body.hashCode);
    hashCode = $hashCombine(hashCode, _self.category.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('e621Wiki')
        ..add('id', _self.id)
        ..add('createdAt', _self.createdAt)
        ..add('updatedAt', _self.updatedAt)
        ..add('title', _self.title)
        ..add('body', _self.body)
        ..add('category', _self.category))
      .toString();
  e621Wiki copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? body,
    int? category,
  }) {
    return e621Wiki(
      id: id ?? _self.id,
      createdAt: createdAt ?? _self.createdAt,
      updatedAt: updatedAt ?? _self.updatedAt,
      title: title ?? _self.title,
      body: body ?? _self.body,
      category: category ?? _self.category,
    );
  }

  e621Wiki change(void Function(_e621WikiChanges c) updates) =>
      (_e621WikiChanges._(_self)..update(updates)).build();
  _e621WikiChanges toChanges() => _e621WikiChanges._(_self);
}

class _e621WikiChanges {
  _e621WikiChanges._(e621Wiki dc)
      : id = dc.id,
        createdAt = dc.createdAt,
        updatedAt = dc.updatedAt,
        title = dc.title,
        body = dc.body,
        category = dc.category;

  int id;

  DateTime createdAt;

  DateTime? updatedAt;

  String title;

  String body;

  int category;

  void update(void Function(_e621WikiChanges c) updates) => updates(this);
  e621Wiki build() => e621Wiki(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        title: title,
        body: body,
        category: category,
      );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_e621Wiki _$e621WikiFromJson(Map<String, dynamic> json) => _e621Wiki(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      title: json['title'] as String,
      body: json['body'] as String,
      creatorId: json['creator_id'] as int,
      isLocked: json['is_locked'] as bool,
      updaterId: json['updater_id'] as int?,
      isDeleted: json['is_deleted'] as bool,
      otherNames: (json['other_names'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      creatorName: json['creator_name'] as String,
      categoryName: json['category_name'] as int,
    );

Map<String, dynamic> _$e621WikiToJson(_e621Wiki instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'title': instance.title,
      'body': instance.body,
      'creator_id': instance.creatorId,
      'is_locked': instance.isLocked,
      'updater_id': instance.updaterId,
      'is_deleted': instance.isDeleted,
      'other_names': instance.otherNames,
      'creator_name': instance.creatorName,
      'category_name': instance.categoryName,
    };
