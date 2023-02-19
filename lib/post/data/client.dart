import 'package:e1547/client/client.dart';
import 'package:e1547/post/post.dart';

abstract class PostClient implements Client {
  Future<List<Post>> posts(
    int page, {
    int? limit,
    String? search,
    bool? force,
    CancelToken? cancelToken,
  });

  Future<Post> post(int postId, {bool? force, CancelToken? cancelToken});
}

abstract class PostOrderedClient implements PostClient {
  @override
  Future<List<Post>> posts(
    int page, {
    int? limit,
    String? search,
    bool? ordered,
    bool? orderPoolsByOldest,
    bool? orderFavoritesByAdded,
    bool? force,
    CancelToken? cancelToken,
  });
}

abstract class PostUpdateClient implements PostClient {
  Future<void> updatePost(int postId, Map<String, String?> body);
}

abstract class PostVoteClient implements PostClient {
  Future<void> votePost(int postId, bool upvote, bool replace);
}

abstract class PostFavoriteClient implements PostClient {
  Future<List<PostWithFavorites>> favorites(
    int page, {
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  });

  Future<void> addFavorite(int postId);

  Future<void> removeFavorite(int postId);
}

abstract class PostTicketClient implements PostClient {
  Future<void> reportPost(int postId, int reportId, String reason);

  Future<void> flagPost(int postId, String flag, {int? parent});
}

abstract class PostTaggedClient implements PostClient {
  Future<List<Post>> postsByTags(
    List<String> tags,
    int page, {
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  });
}

abstract class PostIdsClient implements PostClient {
  Future<List<Post>> postsByIds(
    List<int> ids, {
    int? limit,
    bool? force,
    CancelToken? cancelToken,
  });
}
