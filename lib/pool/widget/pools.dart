import 'package:e1547/client/client.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/settings/settings.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/traits/traits.dart';
import 'package:flutter/material.dart';

class PoolsPage extends StatefulWidget {
  const PoolsPage({super.key, this.search});

  final PoolParams? search;

  @override
  State<StatefulWidget> createState() => _PoolsPageState();
}

class _PoolsPageState extends State<PoolsPage> with RouterDrawerEntryWidget {
  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    return ChangeNotifierProvider(
      create: (_) => PoolParamsController(widget.search),
      child: PoolsHistoryConnector(
        child: FilterControllerProvider<PostFilter, Post>(
          create: (_) => PostFilter(client),
          keys: (_) => [client],
          child: AdaptiveScaffold(
            appBar: const DefaultAppBar(
              title: Text('Pools'),
              actions: [ContextDrawerButton()],
            ),
            floatingActionButton: const PoolsPageFloatingActionButton(),
            drawer: const RouterDrawer(),
            endDrawer: const ContextDrawer(
              title: Text('Pools'),
              children: [DrawerDenySwitch()],
            ),
            body: LimitedWidthLayout(
              child: ValueListenableBuilder<int>(
                valueListenable: context.watch<Settings>().tileSize,
                builder: (context, value, child) =>
                    TileLayout(tileSize: value, child: child!),
                child: PoolPageQueryBuilder(
                  builder: (context, state, query) => PullToRefresh(
                    onRefresh: query.invalidate,
                    child: PagedMasonryGridView<int, Pool>.count(
                      primary: true,
                      showNewPageProgressIndicatorAsGridChild: false,
                      showNewPageErrorIndicatorAsGridChild: false,
                      showNoMoreItemsIndicatorAsGridChild: false,
                      padding: defaultListPadding,
                      state: state.paging,
                      fetchNextPage: query.getNextPage,
                      crossAxisCount:
                          (TileLayout.of(context).crossAxisCount * 0.5).round(),
                      builderDelegate: defaultPagedChildBuilderDelegate<Pool>(
                        onRetry: query.getNextPage,
                        itemBuilder: (context, item, index) =>
                            ImageCacheSizeProvider(
                              size: TileLayout.of(context).tileSize * 4,
                              child: PoolTile(
                                pool: item,
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PoolPage(pool: item),
                                  ),
                                ),
                              ),
                            ),
                        onEmpty: const Text('No pools'),
                        onError: const Text('Failed to load pools'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
