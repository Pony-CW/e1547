import 'package:e1547/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'params.freezed.dart';

enum CommentGroupBy { post, comment }

enum CommentOrder {
  newest('id_desc'),
  oldest('id_asc');

  const CommentOrder(this.value);

  final String value;
}

@freezed
abstract class CommentParams with _$CommentParams {
  const CommentParams._();

  const factory CommentParams({
    @Default(CommentGroupBy.post) CommentGroupBy groupBy,
    int? postId,
    String? body,
    String? creator,
    List<String>? postTags,
    @Default(CommentOrder.newest) CommentOrder order,
  }) = _CommentParams;

  QueryMap toQuery() => {
    if (groupBy != CommentGroupBy.post) 'group_by': groupBy.name,
    if (postId != null) 'search[post_id]': postId!.toString(),
    if (body != null && body!.isNotEmpty) 'search[body_matches]': body!,
    if (creator != null && creator!.isNotEmpty) 'search[creator_name]': creator!,
    if (postTags != null && postTags!.isNotEmpty)
      'search[post_tags_match]': postTags!.join(' '),
    if (order != CommentOrder.newest) 'search[order]': order.value,
  };
}

class CommentParamsController extends ValueNotifier<CommentParams> {
  CommentParamsController([CommentParams? initial])
    : super(initial ?? const CommentParams());

  void update(CommentParams Function(CommentParams) updater) =>
      value = updater(value);
}
