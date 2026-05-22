import 'package:e1547/client/client.dart';
import 'package:e1547/follow/follow.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/shared/shared.dart';

class FollowTimelineController extends PostController {
  FollowTimelineController({required super.client}) : super(canSearch: false);

  @override
  Future<List<Post>> fetch(int page, bool force) async {
    List<Follow> follows = await client.follows.all(
      query: FollowsQuery(types: [FollowType.update, FollowType.notify]),
      force: force,
    );
    return client.posts.byTags(
      tags: follows
          .where((e) => !e.tags.contains(' '))
          .map((e) => e.tags)
          .toList(),
      page: page,
      force: force,
      cancelToken: cancelToken,
    );
  }
}
