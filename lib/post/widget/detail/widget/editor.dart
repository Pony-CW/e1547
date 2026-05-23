import 'package:e1547/client/client.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';

class PostEditor extends StatefulWidget {
  const PostEditor({super.key, required this.post, required this.child});

  final Post post;
  final Widget child;

  @override
  State<PostEditor> createState() => _PostEditorState();
}

class _PostEditorState extends State<PostEditor> {
  late final PostEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PostEditingController(
      canEdit: context.read<Client>().hasLogin,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostEditingController>.value(
      value: _controller,
      child: widget.child,
    );
  }
}

class PostEditorChild extends StatelessWidget {
  const PostEditorChild({
    super.key,
    required this.shown,
    required this.child,
  });

  final bool shown;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final editing =
        context.watch<PostEditingController?>()?.editing ?? false;
    return CrossFade(showChild: shown == editing, child: child);
  }
}
