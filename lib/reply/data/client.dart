import 'package:e1547/client/client.dart';
import 'package:e1547/reply/reply.dart';

abstract class ReplyClient implements Client {
  Future<List<Reply>> replies(
    int topicId,
    String page, {
    bool? force,
    CancelToken? cancelToken,
  });

  Future<Reply> reply(
    int replyId, {
    bool? force,
    CancelToken? cancelToken,
  });
}
