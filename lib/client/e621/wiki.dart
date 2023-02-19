import 'package:e1547/wiki/wiki.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'wiki.g.dart';

@JsonSerializable()
// ignore: camel_case_types
class _e621Wiki {
  const _e621Wiki({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.body,
    required this.creatorId,
    required this.isLocked,
    required this.updaterId,
    required this.isDeleted,
    required this.otherNames,
    required this.creatorName,
    required this.categoryName,
  });

  factory _e621Wiki.fromJson(dynamic json) => _$e621WikiFromJson(json);

  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String title;
  final String body;
  final int creatorId;
  final bool isLocked;
  final int? updaterId;
  final bool isDeleted;
  final List<String> otherNames;
  final String creatorName;
  final int categoryName;
}

@DataClass()
// ignore: camel_case_types
class e621Wiki with _$e621Wiki implements Wiki {
  e621Wiki({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.body,
    required this.category,
  });

  factory e621Wiki.fromJson(dynamic json) {
    final raw = _e621Wiki.fromJson(json);
    return e621Wiki(
      id: raw.id,
      createdAt: raw.createdAt,
      updatedAt: raw.updatedAt,
      title: raw.title,
      body: raw.body,
      category: raw.categoryName,
    );
  }

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String title;
  @override
  final String body;
  @override
  final int category;
}
