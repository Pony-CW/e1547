import 'package:e1547/history/history.dart';
import 'package:e1547/l10n/app_localizations.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/topic/topic.dart';
import 'package:flutter/material.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({super.key, this.query});

  final QueryMap? query;

  @override
  Widget build(BuildContext context) {
    return RouterDrawerEntry<TopicsPage>(
      child: TopicProvider(
        query: query,
        child: Consumer<TopicController>(
          builder: (context, controller, child) => ControllerHistoryConnector(
            controller: controller,
            addToHistory: (context, client, controller) => client.histories.add(
              TopicHistoryRequest.search(
                query: controller.query,
                topics: controller.items!,
              ),
            ),
            child: AdaptiveScaffold(
              appBar: DefaultAppBar(
                title: Text(AppLocalizations.of(context)!.topics),
                actions: const [ContextDrawerButton()],
              ),
              floatingActionButton: const TopicSearchFab(),
              drawer: const RouterDrawer(),
              endDrawer: ContextDrawer(
                title: Text(AppLocalizations.of(context)!.topics),
                children: [TopicTagEditingTile(controller: controller)],
              ),
              body: const TopicList(),
            ),
          ),
        ),
      ),
    );
  }
}
