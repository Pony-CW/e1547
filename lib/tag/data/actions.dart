import 'package:e1547/tag/tag.dart';

final List<String> wikiMetaTags =
    List.unmodifiable(['help:', 'e621:', 'howto:']);

String sortTags(String tags) => Tagset.parse(tags).toString();

/// Removes prefixes from tags.
String tagToRaw(String tags) => tags
    .trim()
    .split(' ')
    .map((tag) => tag.replaceAllMapped(RegExp(r'^[-~]'), (_) => ''))
    .join(' ');

/// Removes underscored from tags, adds commas.
String tagToName(String tags) =>
    tags.trim().split(' ').join(', ').replaceAll('_', ' ');

/// Removes underscores and prefixes from tags
String tagToTitle(String tags) => tagToName(tagToRaw(tags));

bool tagIsSingle(String tags) => !(tags.contains(' ') || tags.contains(':'));

List<String> filterArtists(List<String> artists) {
  List<String> excluded = [
    'epilepsy_warning',
    'conditional_dnp',
    'sound_warning',
    'avoid_posting',
  ];

  return List.from(artists)..removeWhere((artist) => excluded.contains(artist));
}
