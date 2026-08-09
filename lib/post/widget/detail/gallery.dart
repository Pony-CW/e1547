import 'package:e1547/post/post.dart';
import 'package:e1547/query/query.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';

class PostDetailGallery extends StatefulWidget {
  const PostDetailGallery({
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
  State<PostDetailGallery> createState() => _PostDetailGalleryState();
}

class _PostDetailGalleryState extends State<PostDetailGallery> {
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
          builder: (context, child) => Scaffold(
            appBar: const TransparentAppBar(child: DefaultAppBar()),
            body: child,
          ),
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
          child: GalleryButtons(
            controller: pageController,
            child: PagedPageView(
              pageController: pageController,
              state: state.paging,
              fetchNextPage: query.getNextPage,
              builderDelegate: defaultPagedChildBuilderDelegate<Post>(
                onRetry: query.getNextPage,
                pageBuilder: (context, child) => Scaffold(
                  appBar: const TransparentAppBar(child: DefaultAppBar()),
                  body: child,
                ),
                onEmpty: const Text('No posts'),
                onError: const Text('Failed to load posts'),
                itemBuilder: (context, item, index) => SubScrollController(
                  builder: (context, scrollController) =>
                      PrimaryScrollController(
                        controller: scrollController,
                        child: PostDetail(
                          post: item,
                          onTapImage: () =>
                              _pushFullscreen(context, item, pageController),
                        ),
                      ),
                ),
              ),
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
                  size: PostImageSize.sample,
                );
              },
            ),
          ),
        ),
      );
    },
  );

  void _pushFullscreen(
    BuildContext context,
    Post post,
    PageController pageController,
  ) {
    final params = context.read<PostParamsController>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ChangeNotifierProvider<PostParamsController>.value(
              value: params,
              child: PostFullscreenGallery(
                initialPostId: post.id,
                onPageChanged: pageController.jumpToPage,
              ),
            ),
      ),
    );
  }
}

/// Moves [controller] onto [page] after the frame that changed its list.
void jumpGalleryTo(PageController controller, int page) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!controller.hasClients) return;
    if (controller.page?.round() == page) return;
    controller.jumpToPage(page);
  });
}

/// Shown while a gallery cannot place its post in the results.
/// Calls [onSettled] once [settled] reports the results as final.
class GalleryAbsent extends StatefulWidget {
  const GalleryAbsent({
    super.key,
    required this.settled,
    required this.onSettled,
    required this.builder,
  });

  final bool settled;
  final VoidCallback onSettled;
  final Widget Function(BuildContext context, Widget child) builder;

  @override
  State<GalleryAbsent> createState() => _GalleryAbsentState();
}

class _GalleryAbsentState extends State<GalleryAbsent> {
  @override
  void initState() {
    super.initState();
    _settle();
  }

  @override
  void didUpdateWidget(covariant GalleryAbsent oldWidget) {
    super.didUpdateWidget(oldWidget);
    _settle();
  }

  void _settle() {
    if (!widget.settled) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onSettled();
    });
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, const Center(child: CircularProgressIndicator()));
}
