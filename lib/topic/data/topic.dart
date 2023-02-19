abstract class Topic {
  int get id;
  int get creatorId;
  String get title;
  int get responseCount;
  DateTime get createdAt;
  DateTime get updatedAt;
  int get categoryId;

  Topic copyWith({
    int? id,
    int? creatorId,
    String? title,
    int? responseCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? categoryId,
  });
}
