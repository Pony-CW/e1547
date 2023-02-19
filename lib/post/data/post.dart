import 'package:e1547/interface/interface.dart';

abstract class Post {
  int get id;
  int get uploaderId;
  DateTime get createdAt;
  DateTime? get updatedAt;
  String? get file;
  String? get sample;
  String? get preview;
  int get width;
  int get height;
  String get ext;
  int get size;
  Map<String, List<String>> get tags;

  Post copyWith({
    int? id,
    int? uploaderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? file,
    String? sample,
    String? preview,
    int? width,
    int? height,
    String? ext,
    int? size,
    Map<String, List<String>>? tags,
  });
}

abstract class PostWithScore extends Post {
  int get score;
  VoteStatus get voteStatus;

  @override
  Post copyWith({
    int? id,
    int? uploaderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? file,
    String? sample,
    String? preview,
    int? width,
    int? height,
    String? ext,
    int? size,
    Map<String, List<String>>? tags,
    int? score,
    VoteStatus? voteStatus,
  });
}

abstract class PostWithFavorites extends Post {
  bool get isFavorited;
  int get favCount;

  @override
  Post copyWith({
    int? id,
    int? uploaderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? file,
    String? sample,
    String? preview,
    int? width,
    int? height,
    String? ext,
    int? size,
    Map<String, List<String>>? tags,
    bool? isFavorited,
    int? favCount,
  });
}

abstract class PostWithDescription extends Post {
  String get description;

  @override
  Post copyWith({
    int? id,
    int? uploaderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? file,
    String? sample,
    String? preview,
    int? width,
    int? height,
    String? ext,
    int? size,
    Map<String, List<String>>? tags,
    String? description,
  });
}

abstract class PostWithComments extends Post {
  int get commentCount;

  @override
  Post copyWith({
    int? id,
    int? uploaderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? file,
    String? sample,
    String? preview,
    int? width,
    int? height,
    String? ext,
    int? size,
    Map<String, List<String>>? tags,
    int? commentCount,
  });
}
