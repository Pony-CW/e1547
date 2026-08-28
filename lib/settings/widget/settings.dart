import 'dart:async';
import 'dart:io';

import 'package:e1547/app/app.dart';
import 'package:e1547/client/client.dart';
import 'package:e1547/follow/follow.dart';
import 'package:e1547/identity/identity.dart';
import 'package:e1547/l10n/app_localizations.dart';
import 'package:e1547/logs/logs.dart';
import 'package:e1547/settings/settings.dart';
import 'package:e1547/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:local_auth/local_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) => Scaffold(
        appBar: DefaultAppBar(
          title: Text(AppLocalizations.of(context)!.settings),
        ),
        body: LimitedWidthLayout.builder(
          builder: (context) => ListView(
            primary: true,
            padding: defaultActionListPadding.add(
              LimitedWidthLayout.of(context).padding,
            ),
            children: [
              SectionHeader(
                indent: SectionHeader.listTileIndent,
                title: AppLocalizations.of(context)!.account,
              ),
              Consumer<IdentityClient>(
                builder: (context, client, child) => IdentityTile(
                  identity: client.identity,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IdentitiesPage(),
                    ),
                  ),
                  trailing: const Icon(Icons.swap_horiz),
                ),
              ),
              const Divider(),
              SectionHeader(
                indent: SectionHeader.listTileIndent,
                title: AppLocalizations.of(context)!.user,
              ),
              Consumer<Client>(
                builder: (context, client, child) => ValueListenableBuilder(
                  valueListenable: client.traits,
                  builder: (context, traits, child) => ListTile(
                    title: Text(AppLocalizations.of(context)!.blacklist),
                    leading: const Icon(Icons.block),
                    subtitle: traits.denylist.isNotEmpty
                        ? Text(
                            '${traits.denylist.join(' ').split(' ').trim().where((e) => e[0] != '-').length} tags blocked',
                          )
                        : null,
                    onTap: () => Navigator.pushNamed(context, '/blacklist'),
                  ),
                ),
              ),
              Consumer<Client>(
                builder: (context, client, child) => SubStream<int>(
                  create: () => client.follows.count().streamed,
                  keys: [client],
                  builder: (context, snapshot) => ListTile(
                    title: Text(AppLocalizations.of(context)!.follows),
                    subtitle: snapshot.data != null && snapshot.data != 0
                        ? Text('${snapshot.data} searches followed')
                        : null,
                    leading: const Icon(Icons.person_add),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FollowEditor(),
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<Client>(
                builder: (context, client, child) => SubStream<int>(
                  create: () => client.histories.count().streamed,
                  keys: [client],
                  builder: (context, countSnapshot) {
                    int? count = countSnapshot.data;
                    return ValueListenableBuilder(
                      valueListenable: client.traits,
                      builder: (context, traits, child) {
                        bool enabled = traits.writeHistory ?? true;
                        return DividerListTile(
                          title: Text(AppLocalizations.of(context)!.history),
                          subtitle: enabled && count != null
                              ? Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.historySubtitle(count),
                                )
                              : null,
                          leading: const Icon(Icons.history),
                          onTap: () => Navigator.pushNamed(context, '/history'),
                          onTapSeparated: () => client.traits.value = client
                              .traits
                              .value
                              .copyWith(writeHistory: !enabled),
                          separated: Switch(
                            value: enabled,
                            onChanged: (value) => client.traits.value = client
                                .traits
                                .value
                                .copyWith(writeHistory: value),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const Divider(),
              SectionHeader(
                indent: SectionHeader.listTileIndent,
                title: AppLocalizations.of(context)!.appearance,
              ),
              //PonyCW: ChatGPT
              ValueListenableBuilder<Language>(
                valueListenable: settings.languages,
                builder: (context, value, child) => ListTile(
                  title: Text(AppLocalizations.of(context)!.language),
                  subtitle: Text(value.languages),
                  leading: const Icon(Icons.language),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: Text(AppLocalizations.of(context)!.language),
                        children: Language.values
                            .map(
                              (language) => SimpleDialogOption(
                                onPressed: () {
                                  settings.languages.value = language;
                                  Navigator.of(context).maybePop();
                                },
                                child: Text(language.languages),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
              ValueListenableBuilder<AppTheme>(
                valueListenable: settings.theme,
                builder: (context, value, child) => ListTile(
                  title: Text(AppLocalizations.of(context)!.theme),
                  subtitle: Text(value.name),
                  leading: const Icon(Icons.brightness_6),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: Text(AppLocalizations.of(context)!.theme),
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: AppTheme.values
                                .map(
                                  (theme) => ListTile(
                                    title: Text(theme.name),
                                    trailing: Container(
                                      height: 28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: theme.data.cardColor,
                                        border: Border.all(
                                          color: Theme.of(
                                            context,
                                          ).iconTheme.color!,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      settings.theme.value = theme;
                                      Navigator.of(context).maybePop();
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Column(
                children: [
                  ValueListenableBuilder<int>(
                    valueListenable: settings.tileSize,
                    builder: (context, value, child) => ListTile(
                      title: Text(AppLocalizations.of(context)!.tileSize),
                      subtitle: Text(value.toString()),
                      leading: const Icon(Icons.crop),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => RangeDialog(
                          title: Text(AppLocalizations.of(context)!.tileSize),
                          value: NumberRange(value),
                          initialMode: RangeDialogMode.exact,
                          enforceMax: false,
                          canChangeMode: false,
                          division: (300 / 50).round(),
                          min: 100,
                          max: 400,
                          onSubmit: (value) {
                            if (value == null || value.value <= 0) {
                              return;
                            }
                            settings.tileSize.value = value.value;
                          },
                        ),
                      ),
                    ),
                  ),
                  ValueListenableBuilder<GridQuilt>(
                    valueListenable: settings.quilt,
                    builder: (context, value, child) => GridSettingsTile(
                      state: value,
                      onChange: (value) => settings.quilt.value = value,
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder<bool>(
                valueListenable: settings.showPostInfo,
                builder: (context, value, child) => SwitchListTile(
                  title: Text(AppLocalizations.of(context)!.postInfo),
                  subtitle: Text(
                    value ? 'info on post tiles' : 'image tiles only',
                  ),
                  secondary: const Icon(Icons.subtitles),
                  value: value,
                  onChanged: (value) => settings.showPostInfo.value = value,
                ),
              ),
              const Divider(),
              SectionHeader(
                indent: SectionHeader.listTileIndent,
                title: AppLocalizations.of(context)!.interactions,
              ),
              if (!Platform.isIOS)
                ValueListenableBuilder<String?>(
                  valueListenable: settings.downloadPath,
                  builder: (context, value, child) => ListTile(
                    title: Text(AppLocalizations.of(context)!.downloadLocation),
                    subtitle: value != null
                        ? Text(Uri.decodeComponent(Uri.parse(value).path))
                        : null,
                    leading: const Icon(Icons.folder),
                    onTap: () async {
                      String? result = await FileDownloader.pickDirectory(
                        initial: value,
                      );
                      if (result != null) {
                        unawaited(FileDownloader.forgetDirectory(value));
                        settings.downloadPath.value = result;
                      }
                    },
                  ),
                ),
              ValueListenableBuilder<bool>(
                valueListenable: settings.upvoteFavs,
                builder: (context, value, child) => SwitchListTile(
                  title: Text(AppLocalizations.of(context)!.upvoteFavorites),
                  subtitle: Text(
                    value
                        ? AppLocalizations.of(context)!.upvoteFavoritesTrue
                        : AppLocalizations.of(context)!.upvoteFavoritesFalse,
                  ),
                  secondary: const Icon(Icons.arrow_upward),
                  value: value,
                  onChanged: (value) => settings.upvoteFavs.value = value,
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: settings.muteVideos,
                builder: (context, value, child) => SwitchListTile(
                  title: Text(AppLocalizations.of(context)!.videoVolume),
                  subtitle: Text(
                    value
                        ? AppLocalizations.of(context)!.videoVolumeTrue
                        : AppLocalizations.of(context)!.videoVolumeFalse,
                  ),
                  secondary: Icon(value ? Icons.volume_off : Icons.volume_up),
                  value: value,
                  onChanged: (value) => settings.muteVideos.value = value,
                ),
              ),
              ValueListenableBuilder<VideoResolution>(
                valueListenable: settings.videoResolution,
                builder: (context, value, child) => ListTile(
                  title: Text(AppLocalizations.of(context)!.videoResolution),
                  subtitle: Text(value.title(context)),
                  leading: const Icon(Icons.video_settings),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: Text(
                        AppLocalizations.of(context)!.videoResolution,
                      ),
                      children: VideoResolution.values
                          .map(
                            (resolution) => ListTile(
                              title: Text(resolution.title(context)),
                              onTap: () {
                                settings.videoResolution.value = resolution;
                                Navigator.of(context).maybePop();
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              const Divider(),
              SectionHeader(
                indent: SectionHeader.listTileIndent,
                title: AppLocalizations.of(context)!.security,
              ),
              if (PlatformCapabilities.hasSecureDisplay)
                ValueListenableBuilder<bool>(
                  valueListenable: settings.secureDisplay,
                  builder: (context, value, child) => SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.secureDisplay),
                    subtitle: Text(
                      value
                          ? AppLocalizations.of(context)!.secureDisplayTrue
                          : AppLocalizations.of(context)!.secureDisplayFalse,
                    ),
                    secondary: const Icon(Icons.stop_screen_share_outlined),
                    value: value,
                    onChanged: (value) => settings.secureDisplay.value = value,
                  ),
                ),
              if (Platform.isAndroid)
                ValueListenableBuilder<bool>(
                  valueListenable: settings.incognitoKeyboard,
                  builder: (context, value, child) => SwitchListTile(
                    title: Text(
                      AppLocalizations.of(context)!.incognitoKeyboard,
                    ),
                    subtitle: Text(
                      value
                          ? AppLocalizations.of(context)!.enabledLC
                          : AppLocalizations.of(context)!.disabledLC,
                    ),
                    secondary: const Icon(Icons.keyboard),
                    value: value,
                    onChanged: (value) =>
                        settings.incognitoKeyboard.value = value,
                  ),
                ),
              ValueListenableBuilder<String?>(
                valueListenable: settings.appPin,
                builder: (context, value, child) => SwitchListTile(
                  title: Text(AppLocalizations.of(context)!.pinLock),
                  subtitle: Text(
                    value != null
                        ? AppLocalizations.of(context)!.pinLockTrue
                        : AppLocalizations.of(context)!.pinLockFalse,
                  ),
                  secondary: const Icon(Icons.pin),
                  value: value != null,
                  onChanged: (value) async {
                    if (value) {
                      String? pin = await registerPin(context);
                      if (pin != null) {
                        settings.appPin.value = pin;
                      }
                    } else {
                      settings.appPin.value = null;
                    }
                  },
                ),
              ),
              SubFuture<bool>(
                create: () => LocalAuthentication()
                    .getAvailableBiometrics()
                    .then((e) => e.isNotEmpty),
                builder: (context, snapshot) => ValueListenableBuilder<bool>(
                  valueListenable: settings.biometricAuth,
                  builder: (context, value, child) => SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.biometricLock),
                    subtitle: Text(
                      value
                          ? AppLocalizations.of(context)!.biometricLockTrue
                          : AppLocalizations.of(context)!.biometricLockFalse,
                    ),
                    secondary: const Icon(Icons.fingerprint),
                    value: value,
                    onChanged: (snapshot.data ?? false)
                        ? (value) => settings.biometricAuth.value = value
                        : null,
                  ),
                ),
              ),
              const Divider(),
              SectionHeader(
                indent: SectionHeader.listTileIndent,
                title: AppLocalizations.of(context)!.development,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: settings.showDev,
                builder: (context, value, child) {
                  if (!value) return const SizedBox();
                  return SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.developerMode),
                    subtitle: Text(
                      value
                          ? AppLocalizations.of(context)!.developerModeTrue
                          : AppLocalizations.of(context)!.developerModeFalse,
                    ),
                    secondary: const Icon(Icons.bug_report),
                    value: value,
                    onChanged: (value) => settings.showDev.value = value,
                  );
                },
              ),
              if (context.watch<Logs?>() != null) ...[
                Consumer<LogErrors>(
                  builder: (context, errors, child) => ListTile(
                    leading: const Icon(Icons.format_list_numbered),
                    title: Text(AppLocalizations.of(context)!.logs),
                    subtitle: errors.isEmpty
                        ? null
                        : Text(
                            AppLocalizations.of(
                              context,
                            )!.logsSubtitle(errors.length),
                          ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LogsPage()),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: Text(AppLocalizations.of(context)!.database),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DatabaseManagementPage(),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
