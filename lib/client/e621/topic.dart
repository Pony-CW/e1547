import 'package:e1547/topic/topic.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'topic.g.dart';

@JsonSerializable()
// ignore: camel_case_types
class _e621Topic {
  const _e621Topic({
    required this.id,
    required this.creatorId,
    required this.updaterId,
    required this.title,
    required this.responseCount,
    required this.isSticky,
    required this.isLocked,
    required this.isHidden,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
  });

  factory _e621Topic.fromJson(dynamic json) => _$e621TopicFromJson(json);

  final int id;
  final int creatorId;
  final int updaterId;
  final String title;
  final int responseCount;
  final bool isSticky;
  final bool isLocked;
  final bool isHidden;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int categoryId;
}

@DataClass()
// ignore: camel_case_types
class e621Topic with _$e621Topic implements Topic {
  const e621Topic({
    required this.id,
    required this.creatorId,
    required this.title,
    required this.responseCount,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
  });

  factory e621Topic.fromJson(dynamic json) {
    final raw = _e621Topic.fromJson(json);
    return e621Topic(
      id: raw.id,
      creatorId: raw.creatorId,
      title: raw.title,
      responseCount: raw.responseCount,
      createdAt: raw.createdAt,
      updatedAt: raw.updatedAt,
      categoryId: raw.categoryId,
    );
  }

  @override
  final int id;
  @override
  final int creatorId;
  @override
  final String title;
  @override
  final int responseCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final int categoryId;
}
