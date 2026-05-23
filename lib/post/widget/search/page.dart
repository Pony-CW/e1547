import 'package:e1547/client/client.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/settings/settings.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/traits/traits.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key, this.params, this.drawerActions = const []});

  final PostParams? params;
  final List<Widget> drawerActions;

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    return RouterDrawerEntry<PostsPage>(
      child: FilterControllerProvider(
        create: (_) => PostFilter(client),
        keys: (_) => [client],
        child: ChangeNotifierProvider(
          create: (_) => PostParamsController(params),
          child: AdaptiveScaffold(
            appBar: const PostSelectionAppBar(child: PostPageAppBar()),
            floatingActionButton: const PostsPageFab(),
            drawer: const RouterDrawer(),
            endDrawer: ContextDrawer(
              title: const Text('Posts'),
              children: [
                ...drawerActions,
                if (drawerActions.isNotEmpty) const Divider(),
                const DrawerDenySwitch(),
              ],
            ),
            body: LimitedWidthLayout(
              child: ListenableBuilder(
                listenable: context.watch<Settings>().tileSize,
                builder: (context, child) => TileLayout(
                  tileSize: context.watch<Settings>().tileSize.value,
                  child: const PostList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
