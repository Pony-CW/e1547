import 'package:e1547/client/client.dart';
import 'package:e1547/comment/comment.dart';

abstract class CommentClient implements Client {
  Future<List<Comment>> comments(
    int postId,
    String page, {
    bool? force,
    CancelToken? cancelToken,
  });

  Future<Comment> comment(
    int commentId, {
    bool? force,
    CancelToken? cancelToken,
  });

  Future<void> postComment(int postId, String text);

  Future<void> updateComment(int commentId, int postId, String text);
}

abstract class CommentVoteClient extends CommentClient {
  Future<void> voteComment(int commentId, bool upvote, bool replace);
}

abstract class CommentReportClient extends CommentClient {
  Future<void> reportComment(int commentId, String reason);
}
