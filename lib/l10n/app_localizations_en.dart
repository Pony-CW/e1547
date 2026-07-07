// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get hot => 'Hot';

  @override
  String get search => 'Search';

  @override
  String get favorites => 'Favorites';

  @override
  String get favoritesError => 'Favorites are unavailable for anonymous users';

  @override
  String get timeline => 'Timeline';

  @override
  String get timelineEmpty => 'No posts';

  @override
  String get timelineError => 'Failed to load posts';

  @override
  String get subscriptions => 'Subscriptions';

  @override
  String get subscriptionsEmpty => 'No subscriptions';

  @override
  String get subscriptionsError => 'Failed to load subscriptions';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get bookmarksEmpty => 'No bookmarks';

  @override
  String get bookmarksError => 'Failed to load bookmarks';

  @override
  String get pools => 'Pools';

  @override
  String get forum => 'Forum';

  @override
  String get topics => 'Topics';

  @override
  String get topicsHide => 'hide tags edits';

  @override
  String get topicsHideOn => 'hide tag alias and implications';

  @override
  String get topicsHideOff => 'show tag alias and implications';

  @override
  String get share => 'Share';

  @override
  String get download => 'Download';

  @override
  String get browse => 'Browse';

  @override
  String get edit => 'Edit';

  @override
  String get comment => 'Comment';

  @override
  String get report => 'Report';

  @override
  String get flag => 'Flag';

  @override
  String get editError => 'You must be logged in to edit posts!';

  @override
  String get commentError => 'You must be logged in to comment!';

  @override
  String get reportError => 'You must be logged in to report posts!';

  @override
  String get flagError => 'You must be logged in to flag posts!';

  @override
  String get chooseIdentity => 'Choose identity';

  @override
  String get commentsLC => 'comments';

  @override
  String commentsNumUC(int count) {
    return 'COMMENTS ($count)';
  }

  @override
  String commentsPostIdLC(int postId) {
    return '#$postId comments';
  }

  @override
  String get file => 'File';

  @override
  String get sources => 'Sources';

  @override
  String get version => 'Version';

  @override
  String get webSite => 'Website';

  @override
  String get email => 'Email';

  @override
  String get playstore => 'Playstore';

  @override
  String get donors => 'Donors';

  @override
  String get donorsSubtitle => 'Thanks for helping me keep up development!';

  @override
  String get donorsLite => 'Not on the list? contact us!';

  @override
  String get settings => 'Settings';

  @override
  String get identity => 'Identity';

  @override
  String get host => 'Host';

  @override
  String get hostNullWarn => 'You must provide a host URL.';

  @override
  String get hostUrlWarn => 'Invalid host URL';

  @override
  String get authentication => 'Authentication';

  @override
  String get login => 'Login';

  @override
  String get anonymous => 'Anonymous';

  @override
  String get username => 'Username';

  @override
  String get userWarn => 'You must provide a username.';

  @override
  String get apiKey => 'API key';

  @override
  String apiKeyHelper(String example) {
    return 'e.g. $example';
  }

  @override
  String apiKeyWran(String example) {
    return 'You must provide an API key.\ne.g. $example';
  }

  @override
  String get user => 'User';

  @override
  String get unblock => 'Unblock';

  @override
  String get block => 'Block';

  @override
  String get blacklist => 'Blacklist';

  @override
  String get follows => 'Follows';

  @override
  String get uploads => 'Uploads';

  @override
  String get about => 'About';

  @override
  String get aboutLC => 'about';

  @override
  String get comission => 'Comission';

  @override
  String get info => 'Info';

  @override
  String get infoLC => 'info';

  @override
  String get idLC => 'id';

  @override
  String get joinedLC => 'joined';

  @override
  String get rankLC => 'rank';

  @override
  String get postsLC => 'posts';

  @override
  String get editsLC => 'edits';

  @override
  String get favoritesLC => 'favorites';

  @override
  String get comissionLC => 'comission';

  @override
  String get forumLC => 'forum';

  @override
  String get history => 'History';

  @override
  String historySubtitle(int num) {
    return '$num pages visited';
  }

  @override
  String get historyClear => 'Clear history';

  @override
  String get historyClearSub => 'Delete all entries';

  @override
  String get historyClearWarn => 'Clear history?';

  @override
  String get historyClearWarnInfo =>
      'All history entries will be permanently deleted. This action cannot be undone.';

  @override
  String get historyLimit => 'Limit history';

  @override
  String historyLimitSub(int days, String num) {
    return 'Limited to newer than $days months or \nless than $num entries.';
  }

  @override
  String get historyLimitWarnTitle => 'History limit';

  @override
  String historyLimitWarn(String num, int days) {
    return 'Enabling history limit means all history entries beyond $num \nand all entries older than $days months are automatically deleted.';
  }

  @override
  String get historyInfinite => 'history is infinite';

  @override
  String historyPosts(String tag) {
    return 'Posts - $tag';
  }

  @override
  String historyPools(String name_matches) {
    return 'Pools - $name_matches';
  }

  @override
  String historyUsers(String name_matches) {
    return 'Users - $name_matches';
  }

  @override
  String historyWikis(String title) {
    return 'Wikis - $title';
  }

  @override
  String historyTopics(String title_matches) {
    return 'Topics - $title_matches';
  }

  @override
  String historyReplies(String topic_title_matches) {
    return 'Replies - $topic_title_matches';
  }

  @override
  String get hotPosts => 'Hot posts';

  @override
  String get entries => 'Entries';

  @override
  String get type => 'Type';

  @override
  String get posts => 'Posts';

  @override
  String get users => 'Users';

  @override
  String get wikis => 'Wikis';

  @override
  String get replies => 'Replies';

  @override
  String get tags => 'Tags';

  @override
  String get tasks => 'Tasks';

  @override
  String get tasksEmpty => 'No tasks';

  @override
  String get tasksError => 'Failed to load tasks';

  @override
  String get tasksClear => 'clear all';

  @override
  String get tasksDownload => 'download';

  @override
  String get tasksFavorite => 'favorite';

  @override
  String get tasksUnfavorite => 'unfavorite';

  @override
  String get tasksDownloading => 'downloading';

  @override
  String get tasksFavoriting => 'favoriting';

  @override
  String get tasksUnfavoriting => 'unfavoriting';

  @override
  String get tasksDownloaded => 'downloaded';

  @override
  String get tasksFavorited => 'favorited';

  @override
  String get tasksUnfavorited => 'unfavorited';

  @override
  String tasksLabel(String label) {
    String _temp0 = intl.Intl.selectLogic(label, {
      'active': 'active',
      'done': 'done',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String tasksPending(String present) {
    return 'queued to $present';
  }

  @override
  String tasksFailed(String present) {
    return 'failed to $present';
  }

  @override
  String tasksCanceled(String present) {
    return 'canceled $present';
  }

  @override
  String tasksTitle(String taskActionLabel, int postId) {
    return '$taskActionLabel post #$postId';
  }

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get tileSize => 'Tile size';

  @override
  String get postInfo => 'Post info';

  @override
  String get postInfoTrue => 'info on post tiles';

  @override
  String get postInfoFalse => 'image tiles only';

  @override
  String get interactions => 'Interactions';

  @override
  String get downloadLocation => 'Download location';

  @override
  String get upvoteFavorites => 'Upvote favorites';

  @override
  String get upvoteFavoritesTrue => 'upvote and favorite';

  @override
  String get upvoteFavoritesFalse => 'favorite only';

  @override
  String get videoVolume => 'Video volume';

  @override
  String get videoVolumeTrue => 'muted';

  @override
  String get videoVolumeFalse => 'with sound';

  @override
  String get videoResolution => 'Video resolution';

  @override
  String get videoResolutionStandard => 'Standard (480p)';

  @override
  String get videoResolutionHigh => 'High (720p)';

  @override
  String get videoResolutionFull => 'Full (1080p)';

  @override
  String get videoResolutionUltra => 'Ultra (4K)';

  @override
  String get videoResolutionSource => 'Source';

  @override
  String get security => 'Security';

  @override
  String get secureDisplay => 'Secure display';

  @override
  String get secureDisplayTrue => 'screen protected';

  @override
  String get secureDisplayFalse => 'screen visible';

  @override
  String get incognitoKeyboard => 'Incognito keyboard';

  @override
  String get pinLock => 'PIN lock';

  @override
  String get pinLockTrue => 'PIN enabled';

  @override
  String get pinLockFalse => 'PIN disabled';

  @override
  String get biometricLock => 'Biometric lock';

  @override
  String get biometricLockTrue => 'biometrics enabled';

  @override
  String get biometricLockFalse => 'biometrics disabled';

  @override
  String get development => 'Development';

  @override
  String get developerMode => 'Developer mode';

  @override
  String get developerModeTrue => 'options shown';

  @override
  String get developerModeFalse => 'options hidden';

  @override
  String get logs => 'Logs';

  @override
  String get logsUC => 'LOGS';

  @override
  String logsSubtitle(int num) {
    return '$num errors logged';
  }

  @override
  String get logsError => 'A critical error has occured!';

  @override
  String get database => 'Database';

  @override
  String get databaseExport => 'Save a backup copy of your database';

  @override
  String get databaseExportPush => 'Exporting database...';

  @override
  String get databaseImport => 'Replace current database with imported one';

  @override
  String get databaseImportPush => 'Import Database';

  @override
  String get databaseImportPushWarn =>
      'This will replace your current database. \nAll data will be lost. This cannot be undone!';

  @override
  String get okUC => 'OK';

  @override
  String get clear => 'Clear';

  @override
  String get export => 'Export';

  @override
  String get import => 'Import';

  @override
  String get cancel => 'Cancel';

  @override
  String get importUC => 'IMPORT';

  @override
  String get cancelUC => 'CANCEL';

  @override
  String get restart => 'Restart Required';

  @override
  String get restartWarn => 'The app needs to restart to apply changes.';

  @override
  String get restartNow => 'RESTART NOW';

  @override
  String get noArtist => 'no artist';

  @override
  String get enabled => 'Enabled';

  @override
  String get enabledLC => 'enabled';

  @override
  String get disabledLC => 'disabled';
}
