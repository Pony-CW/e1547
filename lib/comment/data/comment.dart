import 'package:e1547/interface/interface.dart';
import 'package:e1547/ticket/ticket.dart';

abstract class Comment {
  int get id;

  int get postId;

  String get body;

  DateTime get createdAt;

  DateTime get updatedAt;

  int get creatorId;

  String get creatorName;

  Comment copyWith({
    int? id,
    int? postId,
    String? body,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? creatorId,
    String? creatorName,
  });
}

abstract class CommentWithVotes extends Comment {
  int get score;

  VoteStatus get voteStatus;

  @override
  Comment copyWith({
    int? id,
    int? postId,
    String? body,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? creatorId,
    String? creatorName,
    int? score,
    VoteStatus? voteStatus,
  });
}

abstract class CommentWithWarning extends Comment {
  WarningType? get warningType;

  int? get warningUserId;

  @override
  Comment copyWith({
    int? id,
    int? postId,
    String? body,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? creatorId,
    String? creatorName,
    WarningType? warningType,
    int? warningUserId,
  });
}
