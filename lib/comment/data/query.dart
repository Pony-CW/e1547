import 'package:e1547/comment/comment.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/shared/shared.dart';

extension CommentQuerying on CommentClient {
  static const queryKey = 'comments';

  CachedQuery get queryCache => dio.queryCache!;

  QueryBridge<Comment, int> get commentCache => queryCache.bridge(queryKey);

  Query<Comment> useGet({required int id, bool? vendored}) => Query(
    cache: queryCache,
    key: [queryKey, id],
    queryFn: () => get(id: id, force: true),
    config: commentCache.getConfig(vendored: vendored),
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
        ).then(commentCache.savePage),
      );

  Mutation<void, String> useCreate({required int postId}) => Mutation(
    mutationFn: (content) => create(postId: postId, content: content),
    onSuccess: (data, content) {
      queryCache.invalidateCache(
        filterFn: (key, _) {
          if (key is! List || key.length < 2) return false;
          if (key.first != queryKey) return false;
          final params = key[1];
          if (params is! Map) return false;
          return params['search[post_id]'] == postId.toString();
        },
      );
      queryCache
          .bridge<Post, int>(PostQuerying.queryKey)
          .update(
            postId,
            (post) => post.copyWith(commentCount: post.commentCount + 1),
          );
    },
  );

  Mutation<void, String> useUpdate({required int id, required int postId}) =>
      Mutation(
        mutationFn: (content) => commentCache.optimistic(
          id,
          (comment) =>
              comment.copyWith(body: content, updatedAt: DateTime.now()),
          () => update(id: id, postId: postId, content: content),
        ),
      );

  Mutation<VoteResult, VoteRequest> useVote({required int id}) => Mutation(
    mutationFn: (params) {
      final (:upvote, :replace) = params;
      return commentCache.optimistic(
        id,
        (comment) => comment.withVote(upvote: upvote, replace: replace),
        () => vote(id: id, upvote: upvote, replace: replace),
      );
    },
  );
}
