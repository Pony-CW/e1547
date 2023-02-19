// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$e621Tag {
  e621Tag get _self => this as e621Tag;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is e621Tag &&
          runtimeType == other.runtimeType &&
          _self.category == other.category &&
          _self.id == other.id &&
          _self.name == other.name &&
          _self.postCount == other.postCount;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.category.hashCode);
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    hashCode = $hashCombine(hashCode, _self.name.hashCode);
    hashCode = $hashCombine(hashCode, _self.postCount.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('e621Tag')
        ..add('category', _self.category)
        ..add('id', _self.id)
        ..add('name', _self.name)
        ..add('postCount', _self.postCount))
      .toString();
  e621Tag copyWith({
    int? category,
    int? id,
    String? name,
    int? postCount,
  }) {
    return e621Tag(
      category: category ?? _self.category,
      id: id ?? _self.id,
      name: name ?? _self.name,
      postCount: postCount ?? _self.postCount,
    );
  }

  e621Tag change(void Function(_e621TagChanges c) updates) =>
      (_e621TagChanges._(_self)..update(updates)).build();
  _e621TagChanges toChanges() => _e621TagChanges._(_self);
}

class _e621TagChanges {
  _e621TagChanges._(e621Tag dc)
      : category = dc.category,
        id = dc.id,
        name = dc.name,
        postCount = dc.postCount;

  int category;

  int id;

  String name;

  int postCount;

  void update(void Function(_e621TagChanges c) updates) => updates(this);
  e621Tag build() => e621Tag(
        category: category,
        id: id,
        name: name,
        postCount: postCount,
      );
}

mixin _$e621TagSuggestion {
  e621TagSuggestion get _self => this as e621TagSuggestion;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is e621TagSuggestion &&
          runtimeType == other.runtimeType &&
          _self.id == other.id &&
          _self.name == other.name &&
          _self.category == other.category &&
          _self.postCount == other.postCount;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    hashCode = $hashCombine(hashCode, _self.name.hashCode);
    hashCode = $hashCombine(hashCode, _self.category.hashCode);
    hashCode = $hashCombine(hashCode, _self.postCount.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('e621TagSuggestion')
        ..add('id', _self.id)
        ..add('name', _self.name)
        ..add('category', _self.category)
        ..add('postCount', _self.postCount))
      .toString();
  e621TagSuggestion copyWith({
    int? id,
    String? name,
    int? category,
    int? postCount,
  }) {
    return e621TagSuggestion(
      category: category ?? _self.category,
      id: id ?? _self.id,
      name: name ?? _self.name,
      postCount: postCount ?? _self.postCount,
    );
  }

  e621TagSuggestion change(
          void Function(_e621TagSuggestionChanges c) updates) =>
      (_e621TagSuggestionChanges._(_self)..update(updates)).build();
  _e621TagSuggestionChanges toChanges() => _e621TagSuggestionChanges._(_self);
}

class _e621TagSuggestionChanges {
  _e621TagSuggestionChanges._(e621TagSuggestion dc)
      : id = dc.id,
        name = dc.name,
        category = dc.category,
        postCount = dc.postCount;

  int id;

  String name;

  int category;

  int postCount;

  void update(void Function(_e621TagSuggestionChanges c) updates) =>
      updates(this);
  e621TagSuggestion build() => e621TagSuggestion(
        category: category,
        id: id,
        name: name,
        postCount: postCount,
      );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_e621Tag _$e621TagFromJson(Map<String, dynamic> json) => _e621Tag(
      id: json['id'] as int,
      name: json['name'] as String,
      postCount: json['post_count'] as int,
      relatedTags: json['related_tags'] as String,
      relatedTagsUpdatedAt:
          DateTime.parse(json['related_tags_updated_at'] as String),
      category: json['category'] as int,
      isLocked: json['is_locked'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$e621TagToJson(_e621Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'post_count': instance.postCount,
      'related_tags': instance.relatedTags,
      'related_tags_updated_at':
          instance.relatedTagsUpdatedAt.toIso8601String(),
      'category': instance.category,
      'is_locked': instance.isLocked,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_e621TagSuggestion _$e621TagSuggestionFromJson(Map<String, dynamic> json) =>
    _e621TagSuggestion(
      id: json['id'] as int,
      name: json['name'] as String,
      postCount: json['post_count'] as int,
      category: json['category'] as int,
      antecedentName: json['antecedent_name'] as String?,
    );

Map<String, dynamic> _$e621TagSuggestionToJson(_e621TagSuggestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'post_count': instance.postCount,
      'category': instance.category,
      'antecedent_name': instance.antecedentName,
    };
