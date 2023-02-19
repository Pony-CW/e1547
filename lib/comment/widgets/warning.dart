import 'package:e1547/comment/comment.dart';
import 'package:e1547/interface/interface.dart';
import 'package:flutter/material.dart';

class CommentWarningDisplay extends StatelessWidget {
  const CommentWarningDisplay({super.key, required this.comment});

  final CommentWithWarning comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.warning_amber,
              size: smallIconSize(context),
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          Text(
            comment.warningType!.message,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ],
      ),
    );
  }
}
