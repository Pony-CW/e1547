abstract class Pool {
  int get id;

  String get name;

  DateTime get createdAt;

  DateTime get updatedAt;

  String get description;

  List<int> get postIds;

  int get postCount;

  Pool copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    List<int>? postIds,
  });
}

abstract class PoolWithActivity implements Pool {
  bool get isActive;

  @override
  Pool copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    List<int>? postIds,
    bool? isActive,
  });
}
