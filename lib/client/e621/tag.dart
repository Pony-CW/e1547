import 'package:e1547/tag/tag.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'tag.g.dart';

@JsonSerializable()
// ignore: camel_case_types
class _e621Tag {
  _e621Tag({
    required this.id,
    required this.name,
    required this.postCount,
    required this.relatedTags,
    required this.relatedTagsUpdatedAt,
    required this.category,
    required this.isLocked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _e621Tag.fromJson(dynamic json) => _$e621TagFromJson(json);

  final int id;
  final String name;
  final int postCount;
  final String relatedTags;
  final DateTime relatedTagsUpdatedAt;
  final int category;
  final bool isLocked;
  final DateTime createdAt;
  final DateTime updatedAt;
}

@DataClass()
// ignore: camel_case_types
class e621Tag implements Tag {
  e621Tag({
    required this.category,
    required this.id,
    required this.name,
    required this.postCount,
  });

  factory e621Tag.fromJson(dynamic json) {
    final raw = _e621Tag.fromJson(json);
    return e621Tag(
      category: raw.category,
      id: raw.id,
      name: raw.name,
      postCount: raw.postCount,
    );
  }

  @override
  final int category;
  @override
  final int id;
  @override
  final String name;
  @override
  final int postCount;
}

@JsonSerializable()
// ignore: camel_case_types
class _e621TagSuggestion {
  _e621TagSuggestion({
    required this.id,
    required this.name,
    required this.postCount,
    required this.category,
    required this.antecedentName,
  });

  factory _e621TagSuggestion.fromJson(dynamic json) =>
      _$e621TagSuggestionFromJson(json);

  final int id;
  final String name;
  final int postCount;
  final int category;
  final String? antecedentName;
}

@DataClass()
// ignore: camel_case_types
class e621TagSuggestion implements TagSuggestion {
  e621TagSuggestion({
    required this.category,
    required this.id,
    required this.name,
    required this.postCount,
  });

  factory e621TagSuggestion.fromJson(dynamic json) {
    final raw = _e621TagSuggestion.fromJson(json);
    return e621TagSuggestion(
      category: raw.category,
      id: raw.id,
      name: raw.name,
      postCount: raw.postCount,
    );
  }

  @override
  final int id;
  @override
  final String name;
  @override
  final int category;
  @override
  final int postCount;
}
