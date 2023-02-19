import 'package:e1547/pool/pool.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'pool.g.dart';

@JsonSerializable()
// ignore: camel_case_types
class _e621Pool {
  const _e621Pool({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.creatorId,
    required this.description,
    required this.isActive,
    required this.category,
    required this.postIds,
    required this.creatorName,
    required this.postCount,
  });

  factory _e621Pool.fromJson(dynamic json) => _$e621PoolFromJson(json);

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int creatorId;
  final String description;
  final bool isActive;
  final Category category;
  final List<int> postIds;
  final String creatorName;
  final int postCount;
}

@JsonEnum()
enum Category { series, collection }

@DataClass()
// ignore: camel_case_types
class e621Pool with _$e621Pool implements Pool {
  const e621Pool({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.postIds,
    required this.postCount,
  });

  factory e621Pool.fromJson(dynamic json) {
    final raw = _e621Pool.fromJson(json);
    return e621Pool(
        id: raw.id,
        name: raw.name,
        createdAt: raw.createdAt,
        updatedAt: raw.updatedAt,
        description: raw.description,
        postIds: raw.postIds,
        postCount: raw.postCount);
  }

  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String description;
  @override
  final List<int> postIds;
  @override
  final int postCount;
}
