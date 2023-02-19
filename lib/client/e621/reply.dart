import 'package:e1547/reply/reply.dart';
import 'package:e1547/ticket/ticket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'reply.g.dart';

@JsonSerializable()
// ignore: camel_case_types
class _e621Reply {
  const _e621Reply({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.body,
    required this.creatorId,
    required this.updaterId,
    required this.topicId,
    required this.isHidden,
    required this.warningType,
    required this.warningUserId,
  });

  factory _e621Reply.fromJson(dynamic json) => _$e621ReplyFromJson(json);

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String body;
  final int creatorId;
  final int? updaterId;
  final int topicId;
  final bool isHidden;
  final WarningType? warningType;
  final int? warningUserId;
}

@DataClass()
// ignore: camel_case_types
class e621Reply with _$e621Reply implements Reply, ReplyWithWarning {
  const e621Reply({
    required this.id,
    required this.topicId,
    required this.createdAt,
    required this.updatedAt,
    required this.body,
    required this.creatorId,
    required this.warningType,
    required this.warningUserId,
  });

  factory e621Reply.fromJson(dynamic json) {
    final raw = _e621Reply.fromJson(json);
    return e621Reply(
      id: raw.id,
      topicId: raw.topicId,
      createdAt: raw.createdAt,
      updatedAt: raw.updatedAt,
      body: raw.body,
      creatorId: raw.creatorId,
      warningType: raw.warningType,
      warningUserId: raw.warningUserId,
    );
  }

  @override
  final int id;
  @override
  final int topicId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String body;
  @override
  final int creatorId;
  @override
  final WarningType? warningType;
  @override
  final int? warningUserId;
}
