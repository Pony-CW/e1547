// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pool.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$e621Pool {
  e621Pool get _self => this as e621Pool;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is e621Pool &&
          runtimeType == other.runtimeType &&
          _self.id == other.id &&
          _self.name == other.name &&
          _self.createdAt == other.createdAt &&
          _self.updatedAt == other.updatedAt &&
          _self.description == other.description &&
          $listEquality.equals(_self.postIds, other.postIds) &&
          _self.postCount == other.postCount;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    hashCode = $hashCombine(hashCode, _self.name.hashCode);
    hashCode = $hashCombine(hashCode, _self.createdAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.updatedAt.hashCode);
    hashCode = $hashCombine(hashCode, _self.description.hashCode);
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.postIds));
    hashCode = $hashCombine(hashCode, _self.postCount.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('e621Pool')
        ..add('id', _self.id)
        ..add('name', _self.name)
        ..add('createdAt', _self.createdAt)
        ..add('updatedAt', _self.updatedAt)
        ..add('description', _self.description)
        ..add('postIds', _self.postIds)
        ..add('postCount', _self.postCount))
      .toString();
  e621Pool copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    List<int>? postIds,
    int? postCount,
  }) {
    return e621Pool(
      id: id ?? _self.id,
      name: name ?? _self.name,
      createdAt: createdAt ?? _self.createdAt,
      updatedAt: updatedAt ?? _self.updatedAt,
      description: description ?? _self.description,
      postIds: postIds ?? _self.postIds,
      postCount: postCount ?? _self.postCount,
    );
  }

  e621Pool change(void Function(_e621PoolChanges c) updates) =>
      (_e621PoolChanges._(_self)..update(updates)).build();
  _e621PoolChanges toChanges() => _e621PoolChanges._(_self);
}

class _e621PoolChanges {
  _e621PoolChanges._(e621Pool dc)
      : id = dc.id,
        name = dc.name,
        createdAt = dc.createdAt,
        updatedAt = dc.updatedAt,
        description = dc.description,
        postIds = dc.postIds,
        postCount = dc.postCount;

  int id;

  String name;

  DateTime createdAt;

  DateTime updatedAt;

  String description;

  List<int> postIds;

  int postCount;

  void update(void Function(_e621PoolChanges c) updates) => updates(this);
  e621Pool build() => e621Pool(
        id: id,
        name: name,
        createdAt: createdAt,
        updatedAt: updatedAt,
        description: description,
        postIds: postIds,
        postCount: postCount,
      );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_e621Pool _$e621PoolFromJson(Map<String, dynamic> json) => _e621Pool(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      creatorId: json['creator_id'] as int,
      description: json['description'] as String,
      isActive: json['is_active'] as bool,
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      postIds:
          (json['post_ids'] as List<dynamic>).map((e) => e as int).toList(),
      creatorName: json['creator_name'] as String,
      postCount: json['post_count'] as int,
    );

Map<String, dynamic> _$e621PoolToJson(_e621Pool instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'creator_id': instance.creatorId,
      'description': instance.description,
      'is_active': instance.isActive,
      'category': _$CategoryEnumMap[instance.category]!,
      'post_ids': instance.postIds,
      'creator_name': instance.creatorName,
      'post_count': instance.postCount,
    };

const _$CategoryEnumMap = {
  Category.series: 'series',
  Category.collection: 'collection',
};
