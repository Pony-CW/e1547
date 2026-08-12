import 'package:e1547/query/query.dart';
import 'package:e1547/reply/reply.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/topic/topic.dart';

extension ReplyQuerying on ReplyClient {
  static const queryKey = 'replies';

  CachedQuery get queryCache => dio.queryCache!;

  QueryBridge<Reply, int> get replyCache => queryCache.bridge(queryKey);

  Query<Reply> useGet({required int id, bool? vendored}) => Query(
    cache: queryCache,
    key: [queryKey, id],
    queryFn: () => get(id: id, force: true),
    config: replyCache.getConfig(vendored: vendored),
  );

  InfiniteQuery<List<int>, int> usePage({required QueryMap? query}) =>
      InfiniteQuery<List<int>, int>(
        cache: queryCache,
        key: [queryKey, query],
        getNextArg: (state) => state.nextPage,
        queryFn: (key) => page(
          page: key,
          query: query,
          force: true,
        ).then(replyCache.savePage),
      );

  Mutation<void, String> useCreate({required int topicId}) => Mutation(
    mutationFn: (content) => create(topicId: topicId, content: content),
    onSuccess: (data, content) {
      queryCache.invalidateKey(
        queryKey,
        where: (params) => params['search[topic_id]'] == topicId.toString(),
      );
      queryCache
          .bridge<Topic, int>(TopicQuerying.queryKey)
          .update(
            topicId,
            (topic) => topic.copyWith(responseCount: topic.responseCount + 1),
          );
    },
  );

  Mutation<void, String> useUpdate({required int id}) => Mutation(
    mutationFn: (content) => replyCache.optimistic(
      id,
      (reply) => reply.copyWith(body: content, updatedAt: DateTime.now()),
      () => update(id: id, content: content),
    ),
  );
}
