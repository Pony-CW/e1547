import 'package:flutter/material.dart';

/// Represents a part of a widget tree that can be in a loading state.
///
/// [crack] can be called to change the loading state of the widget tree,
/// where `false` (default) means loading and `true` means loaded.
///
/// A [_LoadingNut] is used between a [LoadingNutShell] and a [LoadingNutCore].
class _LoadingNut extends InheritedWidget {
  /// Opens the nut.
  const _LoadingNut({
    required super.child,
    required ValueSetter<bool> this.crack,
  });

  /// Closes the nut.
  const _LoadingNut.none({
    required super.child,
  }) : crack = null;

  final ValueSetter<bool>? crack;

  static _LoadingNut? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_LoadingNut>();

  @override
  bool updateShouldNotify(covariant _LoadingNut oldWidget) =>
      crack != oldWidget.crack;
}

/// The top part of a widget tree that can be in a loading state.
///
/// This widget will show a loading screen as long as there is
/// no [LoadingNutCore] below it.
///
/// Once an enabled [LoadingNutCore] is built, the loading screen will be
/// removed.
class LoadingNutShell extends StatefulWidget {
  const LoadingNutShell({
    super.key,
    required this.child,
    required this.loadingBuilder,
  });

  final Widget child;
  final Widget Function(BuildContext context, bool loading, Widget child)
      loadingBuilder;

  @override
  State<LoadingNutShell> createState() => _LoadingNutShellState();
}

class _LoadingNutShellState extends State<LoadingNutShell> {
  bool _cracked = false;

  void _crack(bool value) {
    if (_cracked == value) return;
    setState(() => _cracked = value);
  }

  @override
  Widget build(BuildContext context) {
    return _LoadingNut(
      crack: _crack,
      child: widget.loadingBuilder(context, !_cracked, widget.child),
    );
  }
}

/// The bottom part of a widget tree that can be in a loading state.
///
/// This widget signals to the [LoadingNutShell] that the loading state
/// is over.
///
/// If [enabled] is `false`, the loading state will not end.
class LoadingNutCore extends StatefulWidget {
  const LoadingNutCore({
    super.key,
    required this.child,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;

  @override
  State<LoadingNutCore> createState() => _LoadingNutCoreState();
}

class _LoadingNutCoreState extends State<LoadingNutCore> {
  _LoadingNut? nut;

  void crack(bool value) {
    ValueSetter<bool>? crack = nut?.crack;
    if (crack == null) {
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary('LoadingCore is not a descendant of LoadingShell'),
          ErrorDescription(
            'Each LoadingCore must have a corresponding LoadingShell ancestor.',
          ),
        ],
      );
    }
    crack(value);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nut = _LoadingNut.of(context);
      crack(widget.enabled);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nut = _LoadingNut.of(context);
  }

  @override
  void didUpdateWidget(covariant LoadingNutCore oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        crack(widget.enabled);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      crack(false);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _LoadingNut.none(
        child: widget.child,
      );
}
