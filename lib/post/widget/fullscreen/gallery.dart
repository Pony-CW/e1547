import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';

class PostFullscreenGallery extends StatefulWidget {
  const PostFullscreenGallery({
    super.key,
    this.initialPostId,
    this.pageController,
    this.onPageChanged,
  }) : assert(
         initialPostId == null || pageController == null,
         'Cannot pass both initialPostId and pageController',
       );

  final int? initialPostId;
  final PageController? pageController;
  final ValueChanged<int>? onPageChanged;

  @override
  State<PostFullscreenGallery> createState() => _PostFullscreenGalleryState();
}

class _PostFullscreenGalleryState extends State<PostFullscreenGallery> {
  late int? postId = widget.initialPostId;

  @override
  Widget build(BuildContext context) => RetainedPostPageQueryBuilder(
    builder: (context, state, query) {
      final items = state.paging.items;
      final index = postId == null
          ? 0
          : items?.indexWhere((post) => post.id == postId) ?? -1;

      if (index < 0) {
        return GalleryAbsent(
          settled: items != null,
          onSettled: () => Navigator.of(context).maybePop(),
          builder: (context, child) => ScaffoldFrame(child: child),
        );
      }

      return SubDefault<PageController>(
        value: widget.pageController,
        create: () => PageController(initialPage: index),
        builder: (context, pageController) => SubEffect(
          keys: [query],
          effect: () {
            jumpGalleryTo(pageController, index);
            return null;
          },
          child: ScaffoldFrame(
            child: GalleryButtons(
              controller: pageController,
              child: PagedPageView<int, Post>(
                pageController: pageController,
                state: state.paging,
                fetchNextPage: query.getNextPage,
                onPageChanged: (index) {
                  final items = state.paging.items;
                  if (items != null && index < items.length) {
                    postId = items[index].id;
                  }
                  widget.onPageChanged?.call(index);
                  preloadPostImages(
                    context: context,
                    index: index,
                    posts: items ?? [],
                    size: PostImageSize.file,
                  );
                },
                builderDelegate: defaultPagedChildBuilderDelegate(
                  onRetry: query.getNextPage,
                  itemBuilder: (context, item, index) =>
                      PostFullscreen(post: item),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
