import 'package:e1547/client/client.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/tag/tag.dart';
import 'package:flutter/material.dart';

class PostPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostPageAppBar({super.key, this.actions});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    final controller = context.watch<PostParamsController>();
    final tags = controller.value.tags ?? '';

    String title;
    bool showInfo = false;

    final map = TagMap(tags);
    if (map.isEmpty) {
      title = 'Search';
    } else if (map['order'] == 'rank') {
      title = 'Hot';
    } else if (map['fav'] != null) {
      final username = map['fav']!;
      if (username == client.identity.username) {
        title = 'Favorites';
      } else {
        title = "$username's Favorites";
      }
    } else {
      title = tagToName(map.toString());
      showInfo = true;
    }

    return DefaultAppBar(
      title: Text(title),
      actions: [
        if (showInfo)
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showTagSearchPrompt(context: context, tag: tags),
          ),
        ...?actions,
        const ContextDrawerButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
