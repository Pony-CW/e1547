import 'package:e1547/client/client.dart';
import 'package:e1547/topic/topic.dart';

abstract class TopicClient implements Client {
  Future<List<Topic>> topics(
    int page, {
    String? search,
    bool? force,
    CancelToken? cancelToken,
  });

  Future<Topic> topic(
    int topicId, {
    bool? force,
    CancelToken? cancelToken,
  });
}
