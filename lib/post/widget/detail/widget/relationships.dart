import 'package:e1547/post/post.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';

class RelationshipDisplay extends StatelessWidget {
  const RelationshipDisplay({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    int? parentId = context.select<PostEditingController?, int?>(
      (value) => value?.value?.parentId ?? post.relationships.parentId,
    );
    bool editing = context.select<PostEditingController?, bool>(
      (value) => value?.editing ?? false,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HiddenWidget(
          show: parentId != null || editing,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text('Parent', style: TextStyle(fontSize: 16)),
              ),
              ListTile(
                leading: const Icon(Icons.supervisor_account),
                title: Text(parentId?.toString() ?? 'none'),
                trailing: const Icon(Icons.arrow_right),
                onTap: parentId != null
                    ? () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostLoadingPage(parentId),
                        ),
                      )
                    : null,
              ),
              const Divider(),
            ],
          ),
        ),
        HiddenWidget(
          show:
              post.relationships.children.isNotEmpty &&
              (post.relationships.hasActiveChildren ?? true) &&
              !editing,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text('Children', style: TextStyle(fontSize: 16)),
              ),
              ...post.relationships.children.map(
                (child) => ListTile(
                  leading: const Icon(Icons.supervised_user_circle),
                  title: Text(child.toString()),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PostLoadingPage(child),
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
