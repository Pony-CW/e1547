import 'package:e1547/app/app.dart';
import 'package:e1547/client/client.dart';
import 'package:e1547/history/history.dart';
import 'package:e1547/l10n/app_localizations.dart';
import 'package:e1547/shared/shared.dart';
import 'package:e1547/tag/tag.dart';
import 'package:flutter/widgets.dart';

extension Identification on History {
  bool isItem(LinkType type) {
    Link? parsed = const E621LinkParser().parse(link);
    return type == parsed?.type && parsed?.id != null;
  }

  bool isSearch(LinkType type) {
    Link? parsed = const E621LinkParser().parse(link);
    return type == parsed?.type && (parsed?.query?.isNotEmpty ?? false);
  }

  String getName(BuildContext context) {
    Link? parsed = const E621LinkParser().parse(link);
    LinkType? type = parsed?.type;
    if (parsed == null || type == null) {
      if (title != null) {
        return title!;
      }
      return link;
    }

    if (title != null) {
      switch (type) {
        case LinkType.pool:
        case LinkType.wiki:
          return tagToName(title!);
        default:
          break;
      }
      return title!;
    }

    if (parsed.id case final id when id is String) {
      switch (type) {
        case LinkType.user:
          return '$id - User';
        case LinkType.wiki:
          return '$id - Wiki';
        default:
          break;
      }
    }

    if (parsed.id case final id when id is int) {
      switch (type) {
        case LinkType.post:
          return 'Post #$id';
        case LinkType.pool:
          return 'Pool #$id';
        case LinkType.user:
          return 'User #$id';
        case LinkType.wiki:
          return 'Wiki #$id';
        case LinkType.topic:
          return 'Topic #$id';
        case LinkType.reply:
          return 'Reply #$id';
      }
    }

    QueryMap? search = parsed.query;
    if (search != null && search.isNotEmpty) {
      switch (type) {
        case LinkType.post:
          String? username = context.read<Client>().identity.username;
          if (username != null &&
              favRegex(username).hasMatch(search['tags'] ?? '')) {
            return AppLocalizations.of(context)!.favorites;
          }
          if (search['tags'] == 'order:rank') {
            return AppLocalizations.of(context)!.hotPosts;
          }
          return AppLocalizations.of(
            context,
          )!.historyPosts(tagToName(search['tags'] ?? ''));
        case LinkType.pool:
          return AppLocalizations.of(
            context,
          )!.historyPools(search['search[name_matches]'] ?? '');
        case LinkType.user:
          return AppLocalizations.of(
            context,
          )!.historyUsers(search['search[name_matches]'] ?? '');
        case LinkType.wiki:
          return AppLocalizations.of(
            context,
          )!.historyWikis(search['search[title]'] ?? '');
        case LinkType.topic:
          return AppLocalizations.of(
            context,
          )!.historyTopics(search['search[title_matches]'] ?? '');
        case LinkType.reply:
          return AppLocalizations.of(
            context,
          )!.historyReplies(search['search[topic_title_matches]'] ?? '');
      }
    }

    switch (type) {
      case LinkType.post:
        return AppLocalizations.of(context)!.posts;
      case LinkType.pool:
        return AppLocalizations.of(context)!.pools;
      case LinkType.user:
        return AppLocalizations.of(context)!.users;
      case LinkType.wiki:
        return AppLocalizations.of(context)!.wikis;
      case LinkType.topic:
        return AppLocalizations.of(context)!.topics;
      case LinkType.reply:
        return AppLocalizations.of(context)!.replies;
    }
  }
}
