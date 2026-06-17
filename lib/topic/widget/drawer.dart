import 'package:e1547/l10n/app_localizations.dart';
import 'package:e1547/topic/topic.dart';
import 'package:flutter/material.dart';

class TopicTagEditingTile extends StatelessWidget {
  const TopicTagEditingTile({super.key, required this.controller});

  final TopicController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => SwitchListTile(
        secondary: const Icon(Icons.inventory_outlined),
        title: Text(AppLocalizations.of(context)!.topicsHide),
        subtitle: Text(
          controller.hideTagEditing
              ? AppLocalizations.of(context)!.topicsHideOn
              : AppLocalizations.of(context)!.topicsHideOff,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        value: controller.hideTagEditing,
        onChanged: (value) => controller.hideTagEditing = value,
      ),
    );
  }
}
