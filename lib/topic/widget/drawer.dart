import 'package:e1547/l10n/app_localizations.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/topic/topic.dart';
import 'package:flutter/material.dart';

class TopicListDrawer extends StatelessWidget {
  const TopicListDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TopicFilter>();
    return ContextDrawer(
      title: Text(AppLocalizations.of(context)!.topics),
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.sell),
          title: Text(AppLocalizations.of(context)!.topicsHide),
          subtitle: Text(
            controller.value.hideTagEditing
                ? AppLocalizations.of(context)!.topicsHideOn
                : AppLocalizations.of(context)!.topicsHideOff,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          value: controller.value.hideTagEditing,
          onChanged: (value) {
            controller.value = (hideTagEditing: value);
            Scaffold.of(context).closeEndDrawer();
          },
        ),
      ],
    );
  }
}
