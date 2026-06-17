import 'package:e1547/client/client.dart';
import 'package:e1547/history/history.dart';
import 'package:e1547/l10n/app_localizations.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:intl/intl.dart';

class HistoryEnableTile extends StatelessWidget {
  const HistoryEnableTile({super.key});

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    return SubStream<int>(
      create: () => client.histories.count().streamed,
      keys: [client],
      builder: (context, countSnapshot) => ValueListenableBuilder(
        valueListenable: client.traits,
        builder: (context, traits, child) => SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enabled),
          subtitle: Text(
            AppLocalizations.of(
              context,
            )!.historySubtitle(countSnapshot.data ?? 0),
          ),
          secondary: const Icon(Icons.history),
          value: traits.writeHistory ?? true,
          onChanged: (value) => client.traits.value = client.traits.value
              .copyWith(writeHistory: value),
        ),
      ),
    );
  }
}

class HistoryClearTile extends StatelessWidget {
  const HistoryClearTile({super.key});

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    return ListTile(
      title: Text(AppLocalizations.of(context)!.historyClear),
      subtitle: Text(AppLocalizations.of(context)!.historyClearSub),
      leading: const Icon(Icons.clear_all),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.historyClearWarn),
          content: Text(AppLocalizations.of(context)!.historyClearWarnInfo),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                client.histories.removeAll(null);
              },
              child: Text(AppLocalizations.of(context)!.clear),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryLimitTile extends StatelessWidget {
  const HistoryLimitTile({super.key});

  static const int trimAmount = 5000;
  static const Duration trimAge = Duration(days: 30 * 3);

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    return ValueListenableBuilder(
      valueListenable: client.traits,
      builder: (context, traits, child) => SwitchListTile(
        value: traits.trimHistory ?? false,
        onChanged: (value) {
          if (value) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  AppLocalizations.of(context)!.historyLimitWarnTitle,
                ),
                content: Text(
                  AppLocalizations.of(context)!.historyLimitWarn(
                    NumberFormat.compact().format(trimAmount),
                    trimAge.inDays ~/ 30,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: Text(AppLocalizations.of(context)!.cancelUC),
                  ),
                  TextButton(
                    onPressed: () {
                      client.traits.value = client.traits.value.copyWith(
                        trimHistory: value,
                      );
                      Navigator.of(context).maybePop();
                    },
                    child: Text(AppLocalizations.of(context)!.okUC),
                  ),
                ],
              ),
            );
          } else {
            client.traits.value = client.traits.value.copyWith(
              trimHistory: value,
            );
          }
        },
        secondary: Icon(
          (traits.trimHistory ?? false)
              ? Icons.hourglass_bottom
              : Icons.hourglass_empty,
        ),
        title: Text(AppLocalizations.of(context)!.historyLimit),
        subtitle: (traits.trimHistory ?? false)
            ? Text(
                AppLocalizations.of(context)!.historyLimitSub(
                  trimAge.inDays ~/ 30,
                  NumberFormat.compact().format(trimAmount),
                ),
              )
            : Text(AppLocalizations.of(context)!.historyInfinite),
      ),
    );
  }
}

class HistoryCategoryFilterTile extends StatelessWidget {
  const HistoryCategoryFilterTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryController>(
      builder: (context, controller, child) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ListTileHeader(title: AppLocalizations.of(context)!.entries),
          ),
          for (final filter in HistoryCategory.values)
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                HistoryQuery query = HistoryQuery.from(controller.search);
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CheckboxListTile(
                    secondary: filter.icon,
                    title: Text(filter.title),
                    value: query.categories?.contains(filter) ?? true,
                    onChanged: (value) {
                      if (value == null) return;
                      Set<HistoryCategory> filters =
                          query.categories ?? HistoryCategory.values.toSet();
                      if (value) {
                        filters.add(filter);
                      } else {
                        filters.remove(filter);
                      }
                      controller.search = query.copy()..categories = filters;
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class HistoryTypeFilterTile extends StatelessWidget {
  const HistoryTypeFilterTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryController>(
      builder: (context, controller, child) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ListTileHeader(title: AppLocalizations.of(context)!.type),
          ),
          for (final filter in HistoryType.values)
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                HistoryQuery query = HistoryQuery.from(controller.search);
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CheckboxListTile(
                    secondary: filter.icon,
                    title: Text(filter.title(context)),
                    value: query.types?.contains(filter) ?? true,
                    onChanged: (value) {
                      if (value == null) return;
                      Set<HistoryType> filters =
                          query.types ?? HistoryType.values.toSet();
                      if (value) {
                        filters.add(filter);
                      } else {
                        filters.remove(filter);
                      }
                      controller.search = query.copy()..types = filters;
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
