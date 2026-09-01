import 'package:e1547/history/history.dart';
import 'package:e1547/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension HistorySearchFilterDisplaying on HistoryCategory {
  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return switch (this) {
      HistoryCategory.items => l10n.items,
      HistoryCategory.searches => l10n.searches,
    };
  }

  Widget? get icon {
    switch (this) {
      case HistoryCategory.items:
        return const Icon(Icons.article);
      case HistoryCategory.searches:
        return const Icon(Icons.search);
    }
  }
}

extension HistoryTypeFilterDisplaying on HistoryType {
  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return switch (this) {
      HistoryType.posts => l10n.posts,
      HistoryType.pools => l10n.pools,
      HistoryType.topics => l10n.topics,
      HistoryType.wikis => l10n.wikis,
      HistoryType.users => l10n.users,
    };
  }

  Widget? get icon => switch (this) {
    HistoryType.posts => const Icon(Icons.image),
    HistoryType.pools => const Icon(Icons.collections),
    HistoryType.topics => const Icon(Icons.forum),
    HistoryType.users => const Icon(Icons.person),
    HistoryType.wikis => const Icon(Icons.info_outlined),
  };
}
