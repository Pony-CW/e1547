import 'package:e1547/client/client.dart';
import 'package:e1547/follow/follow.dart';
import 'package:e1547/l10n/app_localizations.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/settings/settings.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';

class FollowsSubscriptionsPage extends StatelessWidget {
  const FollowsSubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RouterDrawerEntry<FollowsSubscriptionsPage>(
      child: ValueListenableBuilder(
        valueListenable: context.watch<Settings>().filterUnseenFollows,
        builder: (context, filterUnseenFollows, child) =>
            SubChangeNotifierProvider<Client, FollowController>(
              create: (context, value) => FollowController(
                client: value,
                types: [FollowType.update, FollowType.notify],
                filterUnseen: filterUnseenFollows,
              ),
              keys: (context) => [filterUnseenFollows],
              child: child,
            ),
        child: Consumer<FollowController>(
          builder: (context, controller, _) => SubEffect(
            effect: () {
              // remove this when the paged grid view is implemented
              controller.getNextPage();
              final client = context.read<Client>();
              client.followServer.sync();
              return null;
            },
            keys: [controller],
            child: SelectionLayout<Follow>(
              items: controller.items,
              child: PromptActions(
                child: AdaptiveScaffold(
                  appBar: FollowSelectionAppBar(
                    child: DefaultAppBar(
                      title: Text(AppLocalizations.of(context)!.subscriptions),
                      actions: const [ContextDrawerButton()],
                    ),
                  ),
                  drawer: const RouterDrawer(),
                  endDrawer: ContextDrawer(
                    title: Text(AppLocalizations.of(context)!.subscriptions),
                    children: const [
                      FollowEditingTile(),
                      Divider(),
                      FollowFilterReadTile(),
                      FollowMarkReadTile(),
                      Divider(),
                      FollowForceSyncTile(),
                    ],
                  ),
                  floatingActionButton: AddTagFloatingActionButton(
                    title: 'Add to subscriptions',
                    onSubmit: (value) async {
                      value = value.trim();
                      if (value.isEmpty) return;
                      await context.read<Client>().follows.create(
                        tags: value,
                        type: FollowType.update,
                      );
                    },
                  ),
                  body: TileLayout(
                    child: ListenableBuilder(
                      listenable: controller,
                      builder: (context, _) => PullToRefresh(
                        onRefresh: () =>
                            controller.refresh(force: true, background: true),
                        child: PagedAlignedGridView<int, Follow>.count(
                          primary: true,
                          padding: defaultActionListPadding,
                          state: controller.state,
                          fetchNextPage: controller.getNextPage,
                          addAutomaticKeepAlives: false,
                          builderDelegate: defaultPagedChildBuilderDelegate(
                            onRetry: controller.getNextPage,
                            itemBuilder: (context, item, index) =>
                                FollowTile(follow: item),
                            onEmpty: Text(
                              AppLocalizations.of(context)!.subscriptionsEmpty,
                            ),
                            onError: Text(
                              AppLocalizations.of(context)!.subscriptionsError,
                            ),
                          ),
                          crossAxisCount: TileLayout.of(context).crossAxisCount,
                        ),
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
