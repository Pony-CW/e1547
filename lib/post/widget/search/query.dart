import 'package:e1547/client/client.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';

class PostPageQueryBuilder extends StatelessWidget {
  const PostPageQueryBuilder({super.key, required this.builder});

  final PageQueryBuilderCallback<Post, int> builder;

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    final controller = context.watch<PostParamsController>();
    final query = client.posts.usePage(query: controller.value.toQuery());

    return PagedQueryBuilder(
      query: query,
      getItem: (id) => client.posts.useGet(id: id, vendored: true),
      builder: (context, state) => QueryFilter(
        state: state,
        builder: (context, state) => builder(context, state, query),
      ),
    );
  }
}

/// Renders the last query that carried pages until a newer one has its own.
class RetainedPostPageQueryBuilder extends StatelessWidget {
  const RetainedPostPageQueryBuilder({super.key, required this.builder});

  final PageQueryBuilderCallback<Post, int> builder;

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    final controller = context.watch<PostParamsController>();
    final query = client.posts.usePage(query: controller.value.toQuery());

    Query<Post> getItem(int id) => client.posts.useGet(id: id, vendored: true);

    return PagedQueryBuilder(
      query: query,
      getItem: getItem,
      builder: (context, incoming) => SubValue<InfiniteQuery<List<int>, int>>(
        create: () => query,
        keys: [client],
        update: (previous) =>
            (incoming.data?.pages.isNotEmpty ?? false) || incoming.isError
            ? query
            : previous,
        builder: (context, shown) => PagedQueryBuilder(
          query: shown,
          getItem: getItem,
          builder: (context, state) => QueryFilter(
            state: state,
            builder: (context, state) => builder(context, state, shown),
          ),
        ),
      ),
    );
  }
}
