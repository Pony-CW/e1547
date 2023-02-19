import 'package:e1547/interface/interface.dart';
import 'package:flutter/widgets.dart';

/// Ensures that [value] is [T]. Otherwise, a Runtime Error is thrown.
T assertType<T>(Object? value) {
  if (value is! T) throw StateError('${value.runtimeType} was not $T');
  return value;
}
