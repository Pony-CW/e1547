import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

abstract class FilterController<T> extends ChangeNotifier {
  FilterController();

  final Map<Object, List<T>> _tracked = {};

  bool _notifyScheduled = false;

  /// Identity used for cross-source deduplication when aggregating tracked
  /// items.
  Object idOf(T item);

  /// Per-item predicate: return true to keep the item, false to drop it.
  bool filter(T item);

  /// Records [items] as the current full contribution from [key] and returns
  /// the filtered view. Calling again with the same key replaces the previous
  /// contribution. Use [untrack] when the source goes away.
  List<T> track(Object key, List<T> items) {
    final previous = _tracked[key];
    _tracked[key] = items;
    if (!identical(previous, items)) {
      _scheduleNotify();
    }
    return items.where(filter).toList();
  }

  /// Forgets [key]'s contribution.
  void untrack(Object key) {
    if (_tracked.remove(key) != null) {
      _scheduleNotify();
    }
  }

  /// All currently tracked items across every source, deduplicated by [idOf].
  Iterable<T> get tracked {
    final seen = <Object>{};
    return _tracked.values
        .expand((items) => items)
        .where((item) => seen.add(idOf(item)));
  }

  /// How many distinct tracked items would be dropped by [filter].
  int get blockedCount => tracked.where((item) => !filter(item)).length;

  void _scheduleNotify() {
    if (_notifyScheduled) return;
    _notifyScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _notifyScheduled = false;
      notifyListeners();
    });
  }
}
