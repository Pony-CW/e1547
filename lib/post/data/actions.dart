import 'package:e1547/app/app.dart';
import 'package:e1547/interface/interface.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/tag/tag.dart';
import 'package:flutter/material.dart';

extension PostTagging on Post {
  bool hasTag(String tag) {
    if (tag.contains(':')) {
      String identifier = tag.split(':')[0];
      String value = tag.split(':')[1];
      switch (identifier) {
        case 'rating':
          if (rating == Rating.values.asNameMap()[value] ||
              value == rating.title.toLowerCase()) {
            return true;
          }
          break;
        case 'id':
          if (id == int.tryParse(value)) {
            return true;
          }
          break;
        case 'type':
          if (file.ext.toLowerCase() == value.toLowerCase()) {
            return true;
          }
          break;
        case 'pool':
          if (pools.contains(int.tryParse(value))) {
            return true;
          }
          break;
        case 'uploader':
        case 'userid':
        case 'user':
          if (uploaderId.toString() == value) {
            return true;
          }
          break;
        case 'score':
          NumberRange? range = NumberRange.tryParse(value);
          if (range == null) return false;
          return range.has(score.total);
      }
    }

    return tags.values.any((category) => category.contains(tag.toLowerCase()));
  }
}

extension PostDenying on Post {
  bool isDeniedBy(List<String> denylist) => getDeniers(denylist) != null;

  List<String>? getDeniers(List<String> denylist) {
    List<String> deniers = [];

    for (String line in denylist) {
      List<String> deny = [];
      List<String> any = [];
      List<String> allow = [];

      for (final tag in line.split(' ')) {
        if (tagToRaw(tag).isEmpty) continue;

        switch (tag[0]) {
          case '-':
            allow.add(tag.substring(1));
            break;
          case '~':
            any.add(tag.substring(1));
            break;
          default:
            deny.add(tag);
            break;
        }
      }

      bool denied = deny.every(hasTag);
      if (!denied) continue;

      bool allowed = allow.any(hasTag);
      if (allowed) continue;

      bool optional = any.isEmpty || any.any(hasTag);
      if (!optional) continue;

      deniers.add(line);
    }

    return deniers.isEmpty ? null : deniers;
  }
}

enum PostType {
  image,
  video,
  unsupported,
}

extension PostTyping on Post {
  PostType get type {
    switch (file.ext) {
      case 'mp4':
      case 'webm':
        if (PlatformCapabilities.hasVideos) {
          return PostType.video;
        }
        return PostType.unsupported;
      case 'swf':
        return PostType.unsupported;
      default:
        return PostType.image;
    }
  }
}

extension PostVideoPlaying on Post {
  VideoPlayer? getVideo(BuildContext context, {bool? listen}) {
    if (type == PostType.video && file.url != null) {
      VideoService service;
      if (listen ?? true) {
        service = context.watch<VideoService>();
      } else {
        service = context.read<VideoService>();
      }
      return service.getVideo(
        VideoConfig(
          url: file.url!,
          size: file.size,
        ),
      );
    }
    return null;
  }
}

extension PostUpdating on Post {
  Post withVote(bool upvote) {
    if (voteStatus == VoteStatus.unknown) {
      if (upvote) {
        return copyWith(
          score: score.copyWith(
            total: score.total + 1,
            up: score.up + 1,
          ),
          voteStatus: VoteStatus.upvoted,
        );
      } else {
        return copyWith(
          score: score.copyWith(
            total: score.total - 1,
            down: score.down + 1,
          ),
          voteStatus: VoteStatus.downvoted,
        );
      }
    } else {
      if (upvote) {
        if (voteStatus == VoteStatus.upvoted) {
          return copyWith(
            score: score.copyWith(
              total: score.total - 1,
              down: score.down + 1,
            ),
            voteStatus: VoteStatus.unknown,
          );
        } else {
          return copyWith(
            score: score.copyWith(
              total: score.total + 2,
              up: score.up + 1,
              down: score.down - 1,
            ),
            voteStatus: VoteStatus.upvoted,
          );
        }
      } else {
        if (voteStatus == VoteStatus.upvoted) {
          return copyWith(
            score: score.copyWith(
              total: score.total - 2,
              up: score.up - 1,
              down: score.down + 1,
            ),
            voteStatus: VoteStatus.downvoted,
          );
        } else {
          return copyWith(
            score: score.copyWith(
              total: score.total + 1,
              up: score.up + 1,
            ),
            voteStatus: VoteStatus.unknown,
          );
        }
      }
    }
  }

  Post withFav() {
    if (!isFavorited) {
      return copyWith(
        isFavorited: true,
        favCount: favCount + 1,
      );
    }
    return this;
  }

  Post withUnfav() {
    if (isFavorited) {
      return copyWith(
        isFavorited: false,
        favCount: favCount - 1,
      );
    }
    return this;
  }
}

extension PostLinking on Post {
  static String getPostLink(int id) => '/posts/$id';

  String get link => getPostLink(id);
}
