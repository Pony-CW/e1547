import 'package:e1547/follow/follow.dart';
import 'package:e1547/history/history.dart';
import 'package:e1547/l10n/app_localizations.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/settings/settings.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/task/task.dart';
import 'package:e1547/topic/topic.dart';
import 'package:e1547/traits/traits.dart';
import 'package:flutter/material.dart';

const String _drawerSearchGroup = 'search';
const String _drawerFollowsGroup = 'follows';
const String _drawerCollectionsGroup = 'collections';
const String _drawerSettingsGroup = 'settings';

//PonyCW: ChatGPT help me
enum DrawerTitle {
  home,
  hot,
  search,
  favorites,
  timeline,
  subscriptions,
  bookmarks,
  pools,
  forum,
  history,
  tasks,
  settings,
  about,
}

final Map<DrawerTitle, String Function(AppLocalizations)> drawerTitleMap = {
  DrawerTitle.home: (l10n) => l10n.home,
  DrawerTitle.hot: (l10n) => l10n.hot,
  DrawerTitle.search: (l10n) => l10n.search,
  DrawerTitle.favorites: (l10n) => l10n.favorites,
  DrawerTitle.timeline: (l10n) => l10n.timeline,
  DrawerTitle.subscriptions: (l10n) => l10n.subscriptions,
  DrawerTitle.bookmarks: (l10n) => l10n.bookmarks,
  DrawerTitle.pools: (l10n) => l10n.pools,
  DrawerTitle.forum: (l10n) => l10n.forum,
  DrawerTitle.history: (l10n) => l10n.history,
  DrawerTitle.tasks: (l10n) => l10n.tasks,
  DrawerTitle.settings: (l10n) => l10n.settings,
  DrawerTitle.about: (l10n) => l10n.about,
};

String drawerTitleText(BuildContext context, DrawerTitle name) {
  final l10n = AppLocalizations.of(context)!;
  return drawerTitleMap[name]?.call(l10n) ?? '';
}

final List<RouterDrawerDestination> rootDestintations = [
  NamedRouterDrawerDestination(
    path: '/',
    name: DrawerTitle.home,
    icon: const Icon(Icons.home),
    builder: (context) => const HomePage(),
    unique: true,
    group: _drawerSearchGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/hot',
    name: DrawerTitle.hot,
    icon: const Icon(Icons.whatshot),
    builder: (context) => const HotPage(),
    unique: true,
    group: _drawerSearchGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/search',
    name: DrawerTitle.search,
    icon: const Icon(Icons.search),
    builder: (context) => const PostsPage(),
    group: _drawerSearchGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/favorites',
    name: DrawerTitle.favorites,
    icon: const Icon(Icons.favorite),
    builder: (context) => const FavPage(),
    unique: true,
    group: _drawerFollowsGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/timeline',
    name: DrawerTitle.timeline,
    icon: const Icon(Icons.feed),
    builder: (context) => const FollowsTimelinePage(),
    unique: true,
    group: _drawerFollowsGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/subscriptions',
    name: DrawerTitle.subscriptions,
    icon: const Icon(Icons.person_add),
    builder: (context) => const FollowsSubscriptionsPage(),
    unique: true,
    group: _drawerFollowsGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/bookmarks',
    name: DrawerTitle.bookmarks,
    icon: const Icon(Icons.bookmark),
    builder: (context) => const FollowsBookmarkPage(),
    unique: true,
    group: _drawerFollowsGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/pools',
    name: DrawerTitle.pools,
    icon: const Icon(Icons.collections),
    builder: (context) => const PoolsPage(),
    unique: true,
    group: _drawerCollectionsGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/forum',
    name: DrawerTitle.forum,
    icon: const Icon(Icons.forum),
    builder: (context) => const TopicsPage(),
    unique: true,
    group: _drawerCollectionsGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/history',
    name: DrawerTitle.history,
    icon: const Icon(Icons.history),
    builder: (context) => const HistoriesPage(),
    group: _drawerSettingsGroup,
  ),
  RouterDrawerDestination(
    path: '/blacklist',
    builder: (context) => const DenyListPage(),
  ),
  NamedRouterDrawerDestination(
    path: '/tasks',
    name: DrawerTitle.tasks,
    icon: const Icon(Icons.task_alt),
    builder: (context) => const TasksPage(),
    enabled: _nonRecursive<TasksPage>,
    group: _drawerSettingsGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/settings',
    name: DrawerTitle.settings,
    icon: const Icon(Icons.settings),
    builder: (context) => const SettingsPage(),
    enabled: _nonRecursive<SettingsPage>,
    group: _drawerSettingsGroup,
  ),
  NamedRouterDrawerDestination(
    path: '/about',
    name: DrawerTitle.about,
    icon: const DrawerUpdateIcon(),
    builder: (context) => const AboutPage(),
    group: _drawerSettingsGroup,
  ),
];

bool _nonRecursive<T extends Widget>(BuildContext context) =>
    context.findAncestorWidgetOfExactType<T>() == null;
