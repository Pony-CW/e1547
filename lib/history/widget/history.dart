import 'package:e1547/client/client.dart';
import 'package:e1547/history/history.dart';
import 'package:e1547/l10n/app_localizations.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';

class HistoriesPage extends StatelessWidget {
  const HistoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubChangeNotifierProvider<Client, HistoryController>(
      create: (context, client) => HistoryController(client: client),
      child: Consumer<HistoryController>(
        builder: (context, controller, child) => SelectionLayout<History>(
          items: controller.items,
          child: AdaptiveScaffold(
            appBar: const HistoryAppBar(),
            floatingActionButton: const HistorySearchFab(),
            drawer: const RouterDrawer(),
            endDrawer: ContextDrawer(
              title: Text(AppLocalizations.of(context)!.history),
              children: const [
                HistoryEnableTile(),
                HistoryLimitTile(),
                HistoryClearTile(),
                Divider(),
                HistoryCategoryFilterTile(),
                HistoryTypeFilterTile(),
              ],
            ),
            body: const HistoryList(),
          ),
        ),
      ),
    );
  }
}
