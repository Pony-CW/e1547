import 'package:e1547/post/post.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/tag/tag.dart';
import 'package:flutter/material.dart';

class DrawerDenySwitch extends StatelessWidget {
  const DrawerDenySwitch({super.key, this.filter});

  final PostFilter? filter;

  @override
  Widget build(BuildContext context) {
    final resolved = filter ?? context.watch<PostFilter>();
    return AnimatedBuilder(
      animation: resolved,
      builder: (context, child) => DrawerDenySwitchBody(
        denying: resolved.denying,
        entryCounts: _entryCounts(resolved),
        updateAllowedList: (value) => resolved.allowedEntries = value,
        updateDenying: (value) => resolved.denying = value,
        allowedList: resolved.allowedEntries,
      ),
    );
  }

  static Map<String, int> _entryCounts(PostFilter filter) {
    final result = <String, int>{};
    for (final entries in filter.postFilterEntries.values) {
      for (final entry in entries) {
        result[entry] = (result[entry] ?? 0) + 1;
      }
    }
    return result;
  }
}

class DrawerMultiDenySwitch extends StatefulWidget {
  const DrawerMultiDenySwitch({super.key, required this.filters});

  final List<PostFilter> filters;

  @override
  State<DrawerMultiDenySwitch> createState() => _DrawerMultiDenySwitchState();
}

class _DrawerMultiDenySwitchState extends State<DrawerMultiDenySwitch> {
  bool denying = true;
  List<String> allowedList = [];

  void updateDenying(bool value) {
    denying = value;
    for (final f in widget.filters) {
      f.denying = denying;
    }
  }

  void updateAllowedList(List<String> value) {
    allowedList = value;
    for (final f in widget.filters) {
      f.allowedEntries = allowedList;
    }
  }

  @override
  void initState() {
    super.initState();
    updateDenying(denying);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(widget.filters),
      builder: (context, child) {
        final Map<String, int> entryCounts = {};
        final List<String> allowed = [];
        for (final filter in widget.filters) {
          for (final entries in filter.postFilterEntries.values) {
            for (final entry in entries) {
              entryCounts[entry] = (entryCounts[entry] ?? 0) + 1;
            }
          }
          allowed.addAll(filter.allowedEntries);
        }

        return DrawerDenySwitchBody(
          denying: denying,
          entryCounts: entryCounts,
          updateAllowedList: updateAllowedList,
          updateDenying: updateDenying,
          allowedList: allowed.toSet().toList(),
        );
      },
    );
  }
}

class DrawerDenyTile extends StatelessWidget {
  const DrawerDenyTile({
    super.key,
    required this.entry,
    required this.count,
    required this.isAllowed,
    required this.onChanged,
  });

  final bool isAllowed;
  final int count;
  final void Function(bool? value) onChanged;
  final String entry;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isAllowed,
      onChanged: onChanged,
      title: Row(
        children: [
          Expanded(
            child: Wrap(
              children: entry
                  .split(' ')
                  .where((tag) => tag.isNotEmpty)
                  .map(DenyListTagCard.new)
                  .toList(),
            ),
          ),
        ],
      ),
      secondary: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 24),
        child: TweenAnimationBuilder(
          tween: IntTween(begin: 0, end: count),
          duration: const Duration(milliseconds: 200),
          builder: (context, value, child) => Text(
            value.toString(),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class DrawerDenySwitchBody extends StatelessWidget {
  const DrawerDenySwitchBody({
    super.key,
    required this.denying,
    required this.entryCounts,
    required this.allowedList,
    required this.updateDenying,
    required this.updateAllowedList,
  });

  final bool denying;
  final Map<String, int> entryCounts;
  final List<String> allowedList;

  final ValueChanged<bool> updateDenying;
  final ValueChanged<List<String>> updateAllowedList;

  @override
  Widget build(BuildContext context) {
    final entries = <String, int>{
      ...entryCounts,
      for (final e in allowedList) e: entryCounts[e] ?? 0,
    };
    final sortedKeys = entries.keys.toList()..sort();

    final int totalBlocked = entryCounts.values.fold(0, (a, b) => a + b);

    return Column(
      children: [
        SwitchListTile(
          title: const Text('Blacklist'),
          subtitle: denying && totalBlocked > 0
              ? TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: totalBlocked),
                  duration: defaultAnimationDuration,
                  builder: (context, value, child) =>
                      Text('blocked $value posts'),
                )
              : null,
          secondary: const Icon(Icons.block),
          value: denying,
          onChanged: updateDenying,
        ),
        CrossFade(
          showChild: entries.isNotEmpty,
          child: Column(
            children: [
              const Divider(),
              ...sortedKeys.map(
                (key) => DrawerDenyTile(
                  entry: key,
                  count: entries[key] ?? 0,
                  isAllowed: !allowedList.contains(key),
                  onChanged: (value) {
                    final allowed = List<String>.from(allowedList);
                    if (value!) {
                      allowed.remove(key);
                    } else {
                      allowed.add(key);
                    }
                    updateAllowedList(allowed);
                  },
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
