abstract class Wiki {
  int get id;
  DateTime get createdAt;
  DateTime? get updatedAt;
  String get title;
  String get body;
  int get category;

  Wiki copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? body,
  });
}
