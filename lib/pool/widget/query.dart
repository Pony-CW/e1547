import 'package:e1547/client/client.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';

class PoolPageQueryBuilder extends StatelessWidget {
  const PoolPageQueryBuilder({super.key, required this.builder});

  final PageQueryBuilderCallback<Pool, int> builder;

  @override
  Widget build(BuildContext context) {
    final client = context.watch<Client>();
    final controller = context.watch<PoolParamsController>();
    final query = client.pools.usePage(query: controller.value.toQuery());

    return PagedQueryBuilder(
      query: query,
      getItem: (id) => client.pools.useGet(id: id, vendored: true),
      builder: (context, state) => QueryFilter(
        state: state,
        builder: (context, state) => builder(context, state, query),
      ),
    );
  }
}
