import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  const arbFile = 'lib/l10n/app_en.arb';
  const sourceDir = 'lib';

  final arb =
      json.decode(await File(arbFile).readAsString()) as Map<String, dynamic>;

  final keys = arb.keys.where((e) => !e.startsWith('@')).toSet();
  final used = <String>{};

  await for (final entity in Directory(
    sourceDir,
  ).list(recursive: true, followLinks: false)) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }

    final source = await entity.readAsString();

    // AppLocalizations.of(context)!.foo
    _scan(
      source,
      RegExp(r'AppLocalizations\.of\s*\([^)]*\)\s*!?\s*\.\s*([A-Za-z_]\w*)'),
      used,
    );

    // context.l10n.foo
    _scan(source, RegExp(r'context\.l10n\.([A-Za-z_]\w*)'), used);

    // l10n.foo
    _scan(source, RegExp(r'(?<!\.)\bl10n\.([A-Za-z_]\w*)'), used);
  }

  final unused = (keys.difference(used).toList()..sort());

  print('Total messages : ${keys.length}');
  print('Used messages  : ${used.length}');
  print('Unused messages: ${unused.length}');
  print('');

  if (unused.isEmpty) {
    print('🎉 No unused messages.');
    return;
  }

  for (final key in unused) {
    print(key);
  }
}

void _scan(String source, RegExp regExp, Set<String> used) {
  for (final match in regExp.allMatches(source)) {
    final key = match.group(1);
    if (key != null) {
      used.add(key);
    }
  }
}
