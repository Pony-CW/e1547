import 'package:e1547/post/post.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'editing.freezed.dart';

@freezed
abstract class PostEdit with _$PostEdit {
  const factory PostEdit({
    required Post post,
    String? editReason,
    required Rating rating,
    required String description,
    int? parentId,
    required List<String> sources,
    required Map<String, List<String>> tags,
  }) = _PostEdit;

  const PostEdit._();

  factory PostEdit.fromPost(Post post) => PostEdit(
    post: post,
    rating: post.rating,
    description: post.description,
    parentId: post.relationships.parentId,
    sources: post.sources,
    tags: {
      for (final entry in post.tags.entries)
        entry.key: List<String>.from(entry.value),
    },
  );

  Map<String, String?>? toForm() {
    Map<String, String?> body = {};

    List<String> oldTags = post.tags.values
        .expand((category) => category)
        .toList();
    List<String> newTags = tags.values
        .expand((category) => category)
        .toList();
    List<String> removedTags = oldTags
        .where((element) => !newTags.contains(element))
        .map((t) => '-$t')
        .toList();
    List<String> addedTags = newTags
        .where((element) => !oldTags.contains(element))
        .toList();
    List<String> tagDiff = [...removedTags, ...addedTags];

    if (tagDiff.isNotEmpty) {
      body['post[tag_string_diff]'] = tagDiff.join(' ');
    }

    List<String> removedSource = post.sources
        .where((element) => !sources.contains(element))
        .map((s) => '-$s')
        .toList();
    List<String> addedSource = sources
        .where((element) => !post.sources.contains(element))
        .toList();
    List<String> sourceDiff = [...removedSource, ...addedSource];

    if (sourceDiff.isNotEmpty) {
      body['post[source_diff]'] = sourceDiff.join('\n');
    }

    if (post.relationships.parentId != parentId) {
      body['post[parent_id]'] = parentId?.toString();
    }

    if (post.description != description) {
      body['post[description]'] = description;
    }

    if (post.rating != rating) {
      body['post[rating]'] = rating.name;
    }

    if (body.isNotEmpty) {
      if (editReason?.trim().isNotEmpty ?? false) {
        body['post[edit_reason]'] = editReason!.trim();
      }
      return body;
    } else {
      return null;
    }
  }
}

class PostEditingController extends ValueNotifier<PostEdit?> {
  PostEditingController({required this.canEdit, PostEdit? initial})
    : super(initial);

  final bool canEdit;

  bool _editing = false;
  bool get editing => _editing;
  set editing(bool value) {
    if (_editing == value) return;
    _editing = value;
    notifyListeners();
  }

  void start(Post post) {
    value = PostEdit.fromPost(post);
    editing = true;
  }

  void cancel() {
    value = null;
    editing = false;
  }
}
