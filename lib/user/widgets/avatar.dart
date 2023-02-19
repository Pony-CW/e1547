import 'package:cached_network_image/cached_network_image.dart';
import 'package:e1547/client/client.dart';
import 'package:e1547/denylist/denylist.dart';
import 'package:e1547/interface/interface.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/settings/settings.dart';
import 'package:e1547/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';

Future<void> initializeCurrentUserAvatar(BuildContext context) async {
  PostsController? controller =
      await context.read<CurrentUserAvatarValue>().controller;
  Post? avatar = controller?.itemList?.first;
  if (avatar?.sample != null) {
    // The buildcontext used here comes from MaterialApp,
    // therefore if it goes invalid, the app is already closed.
    // ignore: use_build_context_synchronously
    await precacheImage(
      CachedNetworkImageProvider(avatar!.sample!),
      context,
    );
  }
}

class CurrentUserAvatar extends StatelessWidget {
  const CurrentUserAvatar();

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserAvatarValue>(
      // TODO: replace this with AsyncBuilder and fix it
      builder: (context, value, child) => FutureBuilder<PostsController?>(
        future: value.controller,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: const Icon(Icons.warning_amber),
            );
          }

          return UserAvatar(
            id: snapshot.data?.itemList!.first.id,
            controller: snapshot.data,
          );
        },
      ),
    );
  }
}

class CurrentUserAvatarValue {
  CurrentUserAvatarValue({
    required this.client,
    required this.denylist,
  });

  final UserClient client;
  final DenylistService denylist;
  late final Future<PostsController?> _controller = _createController();

  Future<PostsController?> get controller => _controller;

  Future<PostsController?> _createController() async {
    try {
      if (client is! PostClient) return null;
      int? id = (await client.currentUser())?.avatarIdOrNull;
      if (id != null) {
        PostsController controller = PostsController.single(
          client: assertType<PostClient>(client),
          denylist: denylist,
          id: id,
          filterMode: PostFilterMode.unavailable,
        );
        await controller.loadFirstPage();
        return controller;
      }
    } on Exception {
      return null;
    }
    return null;
  }
}

class CurrentUserAvatarProvider
    extends SubProvider2<Client, DenylistService, CurrentUserAvatarValue> {
  CurrentUserAvatarProvider({super.child, super.builder})
      : super(
          create: (context, client, denylist) => CurrentUserAvatarValue(
            client: assertType<UserClient>(client),
            denylist: denylist,
          ),
          dispose: (context, value) => value.controller
              .then((value) => value?.dispose())
              .onError((error, stackTrace) => null),
        );
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.id,
    required this.controller,
  });

  final int? id;
  final PostsController? controller;

  @override
  Widget build(BuildContext context) {
    int? id = this.id;
    PostsController? controller = this.controller;
    if (id == null || controller == null) {
      return const EmptyAvatar();
    }
    return SubFuture<PostsController>(
      create: () => Future<PostsController>(() async {
        await controller.loadFirstPage();
        return controller;
      }),
      keys: [controller],
      builder: (context, _) => PostsControllerConnector(
        id: id,
        controller: controller,
        builder: (context, post) => Avatar(
          post,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PostsControllerConnector(
                id: id,
                controller: controller,
                builder: (context, post) => PostsRouteConnector(
                  controller: controller,
                  child: PostDetail(post: post!),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PostAvatar extends StatelessWidget {
  const PostAvatar({super.key, required this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return const EmptyAvatar();
    } else {
      return PostsProvider.single(
        id: id!,
        child: Consumer<PostsController>(
          builder: (context, controller, child) =>
              UserAvatar(id: id, controller: controller),
        ),
      );
    }
  }
}

class Avatar extends StatelessWidget {
  const Avatar(this.post, {this.onTap});

  final Post? post;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (post?.sample != null) {
      return GestureDetector(
        onTap: onTap,
        child: PostTileOverlay(
          post: post!,
          child: Hero(
            tag: post!.link,
            child: CircleAvatar(
              foregroundImage: CachedNetworkImageProvider(post!.sample!),
            ),
          ),
        ),
      );
    } else {
      return const EmptyAvatar();
    }
  }
}

class EmptyAvatar extends StatelessWidget {
  const EmptyAvatar({super.key});

  @override
  Widget build(BuildContext context) => const AppIcon();
}
