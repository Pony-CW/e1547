import 'package:flutter/widgets.dart';

enum Language {
  en('English', Locale('en')),
  zhCN('简体中文', Locale('zh', 'CN'));

  const Language(this.languages, this.locale);

  final String languages;
  final Locale locale;
}
