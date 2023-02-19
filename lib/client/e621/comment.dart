import 'package:e1547/comment/comment.dart';
import 'package:e1547/interface/interface.dart';
import 'package:e1547/ticket/ticket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'comment.g.dart';

@JsonSerializable()
// ignore: camel_case_types
class _e621Comment {
  const _e621Comment({
    required this.id,
    required this.createdAt,
    required this.postId,
    required this.creatorId,
    required this.body,
    required this.score,
    required this.updatedAt,
    required this.updaterId,
    required this.doNotBumpPost,
    required this.isHidden,
    required this.isSticky,
    required this.warningType,
    required this.warningUserId,
    required this.creatorName,
    required this.updaterName,
  });

  factory _e621Comment.fromJson(dynamic json) => _$e621CommentFromJson(json);

  final int id;
  final DateTime createdAt;
  final int postId;
  final int creatorId;
  final String body;
  final int score;
  final DateTime updatedAt;
  final int updaterId;
  final bool doNotBumpPost;
  final bool isHidden;
  final bool isSticky;
  final WarningType? warningType;
  final int? warningUserId;
  final String creatorName;
  final String updaterName;
}

@DataClass()
// ignore: camel_case_types
class e621Comment
    with _$e621Comment
    implements CommentWithVotes, CommentWithWarning {
  const e621Comment({
    required this.id,
    required this.createdAt,
    required this.postId,
    required this.creatorId,
    required this.body,
    required this.score,
    required this.updatedAt,
    required this.warningType,
    required this.warningUserId,
    required this.creatorName,
    @JsonKey(ignore: true) this.voteStatus = VoteStatus.unknown,
  });

  factory e621Comment.fromJson(dynamic json) {
    final raw = _e621Comment.fromJson(json);
    return e621Comment(
      id: raw.id,
      createdAt: raw.createdAt,
      postId: raw.postId,
      creatorId: raw.creatorId,
      body: raw.body,
      score: raw.score,
      updatedAt: raw.updatedAt,
      warningType: raw.warningType,
      warningUserId: raw.warningUserId,
      creatorName: raw.creatorName,
    );
  }

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final int postId;
  @override
  final int creatorId;
  @override
  final String body;
  @override
  final int score;
  @override
  final DateTime updatedAt;
  @override
  final WarningType? warningType;
  @override
  final int? warningUserId;
  @override
  final String creatorName;
  @override
  final VoteStatus voteStatus;
}
