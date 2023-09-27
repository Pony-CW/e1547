import 'package:e1547/settings/settings.dart';
import 'package:flutter/material.dart';

class AppLoadingScreen extends StatefulWidget {
  const AppLoadingScreen({
    super.key,
    this.loading = true,
    required this.child,
  });

  final bool loading;
  final Widget child;

  static AppLoadingScreenState of(BuildContext context) => maybeOf(context)!;

  static AppLoadingScreenState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<AppLoadingScreenState>();

  @override
  State<AppLoadingScreen> createState() => AppLoadingScreenState();
}

class AppLoadingScreenState extends State<AppLoadingScreen> {
  String? get message => _message;
  set message(String? value) => setState(() => _message = value);

  String? _message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        widget.child,
        if (widget.loading)
          Positioned.fill(
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 300,
                      child: Center(
                        child: AppIcon(radius: 64),
                      ),
                    ),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    if (_message != null) Text(_message!),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
