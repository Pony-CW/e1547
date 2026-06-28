import 'package:e1547/client/client.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/tag/tag.dart';
import 'package:flutter/material.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    return RouterDrawerEntry<FavPage>(
      child: client.identity.username == null
          ? const AdaptiveScaffold(
              appBar: DefaultAppBar(title: Text('Favorites')),
              body: IconMessage(
                icon: Icon(Icons.person_search),
                title: Text('Favorites are unavailable for anonymous users'),
              ),
            )
          : PostsPage(
              params: PostParams(tags: 'fav:${client.identity.username}'),
              drawerActions: const [FavoriteOrderSwitch()],
            ),
    );
  }
}

class FavoriteOrderSwitch extends StatelessWidget {
  const FavoriteOrderSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PostParamsController>();
    final tags = TagMap(controller.value.tags);
    final order = tags['order'];
    final addedOrder = order == null || order == 'fav';
    return SwitchListTile(
      secondary: const Icon(Icons.sort),
      title: const Text('Favorite order'),
      subtitle: Text(addedOrder ? 'added order' : 'id order'),
      value: addedOrder,
      onChanged: (value) {
        final next = TagMap(controller.value.tags);
        if (value) {
          next.remove('order');
        } else {
          next['order'] = PostOrder.newest.value;
        }
        controller.update((p) => p.copyWith(tags: next.toString()));
      },
    );
  }
}
