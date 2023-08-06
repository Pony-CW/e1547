import 'package:e1547/follow/follow.dart';
import 'package:e1547/interface/interface.dart';
import 'package:e1547/post/post.dart';

class FollowTimelineController extends PostsController {
  FollowTimelineController({
    required super.client,
    required super.denylist,
    required this.follows,
  }) : super(canSearch: false);

  final FollowsService follows;

  @override
  StreamFuture<List<Post>> stream(int page, bool force) {
    return follows
        .all(
          host: client.host,
          types: [FollowType.update, FollowType.notify],
        )
        .stream
        .map((e) => e.map((e) => e.tags))
        .asyncExpand(
          (e) => client
              .postsByTags(
                e.toList(),
                page,
                force: force,
                cancelToken: cancelToken,
              )
              .stream,
        )
        .future;
  }
}
