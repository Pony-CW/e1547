import 'package:e1547/client/client.dart';
import 'package:e1547/comment/comment.dart';
import 'package:e1547/interface/interface.dart';
import 'package:e1547/user/data/client.dart';
import 'package:flutter/material.dart';

class CommentVoteDisplay extends StatelessWidget {
  const CommentVoteDisplay({super.key, required this.comment});

  final CommentWithVotes comment;

  @override
  Widget build(BuildContext context) {
    bool canVote = false;
    Client client = context.watch<Client>();
    if (client is UserClient) {
      canVote = client.hasLogin;
    }
    return VoteDisplay(
      padding: EdgeInsets.zero,
      score: comment.score,
      status: comment.voteStatus,
      onUpvote: canVote
          ? (isLiked) async {
              CommentsController controller =
                  context.read<CommentsController>();
              final messenger = ScaffoldMessenger.of(context);
              controller
                  .vote(comment: comment, upvote: true, replace: !isLiked)
                  .then((value) {
                if (!value) {
                  messenger.showSnackBar(SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Text('Failed to upvote comment #${comment.id}'),
                  ));
                }
              });
              return !isLiked;
            }
          : null,
      onDownvote: canVote
          ? (isLiked) async {
              CommentsController controller =
                  context.read<CommentsController>();
              final messenger = ScaffoldMessenger.of(context);
              controller
                  .vote(comment: comment, upvote: false, replace: !isLiked)
                  .then((value) {
                if (!value) {
                  messenger.showSnackBar(SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Text('Failed to downvote comment #${comment.id}'),
                  ));
                }
              });
              return !isLiked;
            }
          : null,
    );
  }
}
