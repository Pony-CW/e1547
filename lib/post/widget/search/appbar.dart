import 'package:e1547/client/client.dart';
import 'package:e1547/follow/follow.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/tag/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';

class PostPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostPageAppBar({super.key, this.actions});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PostParamsController>();
    final tags = controller.value.tags ?? '';
    final map = TagMap(tags);
    final showInfo =
        map.isNotEmpty && map['order'] != 'rank' && map['fav'] == null;

    return DefaultAppBar(
      title: _PostPageTitle(tags: tags),
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

class _PostPageTitle extends StatelessWidget {
  const _PostPageTitle({required this.tags});

  final String tags;

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    final map = TagMap(tags);

    if (map.isEmpty) return const Text('Search');
    if (map['order'] == 'rank') return const Text('Hot');
    final fav = map['fav'];
    if (fav != null) {
      return Text(
        fav == client.identity.username ? 'Favorites' : "$fav's Favorites",
      );
    }

    final fallback = tagToName(map.toString());

    final poolId = poolRegex().firstMatch(tags)?.namedGroup('id');
    if (poolId != null) {
      return QueryBuilder(
        query: client.pools.useGet(id: int.parse(poolId), vendored: true),
        builder: (context, state) =>
            Text(state.data != null ? tagToName(state.data!.name) : fallback),
      );
    }

    return SubFuture<Follow?>(
      keys: [tags, client],
      create: () => client.follows.getByTags(tags: tags),
      builder: (context, snapshot) => Text(snapshot.data?.name ?? fallback),
    );
  }
}
