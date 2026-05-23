import 'package:e1547/client/client.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    return RouterDrawerEntry<FavPage>(
      child: client.identity.username == null
          ? const AdaptiveScaffold(
              appBar: DefaultAppBar(title: Text('Favorites')),
              body: Center(
                child: Text('Favorites are unavailable for anonymous users'),
              ),
            )
          : PostsPage(
              params: PostParams(tags: 'fav:${client.identity.username}'),
            ),
    );
  }
}
