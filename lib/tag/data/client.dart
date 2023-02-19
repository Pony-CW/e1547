import 'dart:ui';

import 'package:e1547/client/client.dart';
import 'package:e1547/tag/tag.dart';

abstract class TagClient implements Client {
  Future<List<Tag>> tags(
    String search, {
    int? category,
    bool? force,
    CancelToken? cancelToken,
  });

  Future<List<TagSuggestion>> autocomplete(
    String search, {
    int? category,
    bool? force,
    CancelToken? cancelToken,
  });

  Color? tagCategoryColor(String tag);

  int? tagCategoryId(String tag);

  String? tagCategoryName(int id);

  List<String> tagCategories();
}

abstract class TagAliasClient implements TagClient {
  Future<String?> tagAlias(
    String tag, {
    bool? force,
    CancelToken? cancelToken,
  });
}

extension TagColorById on TagClient {
  Color? tagCategoryColorById(int id) {
    Color? color;
    String? name = tagCategoryName(id);
    if (name != null) {
      color = tagCategoryColor(name);
    }
    return color;
  }
}
