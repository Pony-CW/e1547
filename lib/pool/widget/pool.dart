import 'package:e1547/client/client.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/settings/settings.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/tag/tag.dart';
import 'package:e1547/traits/traits.dart';
import 'package:flutter/material.dart';

class PoolPage extends StatefulWidget {
  const PoolPage({super.key, required this.pool, this.orderByOldest});

  final Pool pool;
  final bool? orderByOldest;

  @override
  State<PoolPage> createState() => _PoolPageState();
}

class _PoolPageState extends State<PoolPage> {
  bool readerMode = true;

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    final orderByOldest = widget.orderByOldest ?? true;
    return FilterControllerProvider(
      create: (_) => PostFilter(client),
      keys: (_) => [client],
      child: ChangeNotifierProvider(
        create: (_) => PostParamsController(
          PostParams(
            tags: orderByOldest
                ? 'pool:${widget.pool.id} order:pool'
                : 'pool:${widget.pool.id} order:${PostOrder.newest.value}',
          ),
        ),
        child: PoolHistoryConnector(
          pool: widget.pool,
          child: PostPageQueryBuilder(
            builder: (context, state, query) => AdaptiveScaffold(
              appBar: DefaultAppBar(
                title: Text(tagToName(widget.pool.name)),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    tooltip: 'Info',
                    onPressed: () =>
                        showPoolPrompt(context: context, pool: widget.pool),
                  ),
                  const ContextDrawerButton(),
                ],
              ),
              endDrawer: ContextDrawer(
                title: const Text('Pool'),
                children: [
                  PoolReaderSwitch(
                    readerMode: readerMode,
                    onChange: (value) => setState(() => readerMode = value),
                  ),
                  const PoolOrderSwitch(),
                  const DrawerDenySwitch(),
                  DrawerTagCounter(
                    posts: state.data?.pages.expand((p) => p).toList(),
                  ),
                ],
              ),
              body: LimitedWidthLayout(
                child: ListenableBuilder(
                  listenable: context.watch<Settings>().tileSize,
                  builder: (context, child) => TileLayout(
                    tileSize: context.watch<Settings>().tileSize.value,
                    child: PostList(
                      displayType: readerMode
                          ? PostDisplayType.comic
                          : PostDisplayType.grid,
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

class PoolOrderSwitch extends StatelessWidget {
  const PoolOrderSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PostParamsController>();
    final tags = TagMap(controller.value.tags);
    final oldestFirst = tags['order'] == 'pool';
    return SwitchListTile(
      secondary: const Icon(Icons.sort),
      title: const Text('Pool order'),
      subtitle: Text(oldestFirst ? 'oldest first' : 'newest first'),
      value: oldestFirst,
      onChanged: (value) {
        final next = TagMap(controller.value.tags);
        if (value) {
          next['order'] = 'pool';
        } else {
          next['order'] = PostOrder.newest.value;
        }
        controller.update((p) => p.copyWith(tags: next.toString()));
      },
    );
  }
}

class PoolReaderSwitch extends StatelessWidget {
  const PoolReaderSwitch({
    super.key,
    required this.readerMode,
    required this.onChange,
  });

  final bool readerMode;
  final ValueChanged<bool> onChange;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: const Icon(Icons.auto_stories),
      title: const Text('Pool reader mode'),
      subtitle: Text(readerMode ? 'large images' : 'normal grid'),
      value: readerMode,
      onChanged: (value) {
        onChange(value);
        Scaffold.of(context).closeEndDrawer();
      },
    );
  }
}
