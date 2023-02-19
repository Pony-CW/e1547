import 'package:e1547/ticket/ticket.dart';

abstract class Reply {
  int get id;

  int get topicId;

  DateTime get createdAt;

  DateTime get updatedAt;

  String get body;

  int get creatorId;

  Reply copyWith({
    int? id,
    int? topicId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? body,
    int? creatorId,
  });
}

abstract class ReplyWithWarning extends Reply {
  WarningType? get warningType;

  int? get warningUserId;

  @override
  Reply copyWith({
    int? id,
    int? topicId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? body,
    int? creatorId,
    WarningType? warningType,
    int? warningUserId,
  });
}
