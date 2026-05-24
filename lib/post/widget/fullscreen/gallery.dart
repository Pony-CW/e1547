import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';

class PostFullscreenGallery extends StatelessWidget {
  const PostFullscreenGallery({
    super.key,
    this.params,
    this.initialPostId,
    this.pageController,
    this.onPageChanged,
  }) : assert(
         initialPostId == null || pageController == null,
         'Cannot pass both initialPostId and pageController',
       );

  final PostParams? params;
  final int? initialPostId;
  final PageController? pageController;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => PostParamsController(params),
    child: PostPageQueryBuilder(
      builder: (context, state, query) {
        final items = state.paging.items;
        final initialPage = initialPostId == null
            ? 0
            : items?.indexWhere((p) => p.id == initialPostId) ?? -1;

        if (initialPostId != null && initialPage < 0) {
          return ScaffoldFrame(
            child: Center(
              child: items == null
                  ? const CircularProgressIndicator()
                  : const Text('Post not in current results'),
            ),
          );
        }

        return SubDefault<PageController>(
          value: pageController,
          create: () => PageController(initialPage: initialPage),
          builder: (context, pageController) => ScaffoldFrame(
            child: GalleryButtons(
              controller: pageController,
              child: PagedPageView<int, Post>(
                pageController: pageController,
                state: state.paging,
                fetchNextPage: query.getNextPage,
                onPageChanged: (index) {
                  onPageChanged?.call(index);
                  preloadPostImages(
                    context: context,
                    index: index,
                    posts: state.paging.items ?? [],
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
        );
      },
    ),
  );
}
