import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale('zh', 'CN'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @hot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get hot;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No posts'**
  String get searchEmpty;

  /// No description provided for @searchError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load posts'**
  String get searchError;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @favoritesError.
  ///
  /// In en, this message translates to:
  /// **'Favorites are unavailable for anonymous users'**
  String get favoritesError;

  /// No description provided for @timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timeline;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptions;

  /// No description provided for @subscriptionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions'**
  String get subscriptionsEmpty;

  /// No description provided for @subscriptionsError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load subscriptions'**
  String get subscriptionsError;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @unfollow.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get unfollow;

  /// No description provided for @bookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmark;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @bookmarksEmpty.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks'**
  String get bookmarksEmpty;

  /// No description provided for @bookmarksError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load bookmarks'**
  String get bookmarksError;

  /// No description provided for @unbookmark.
  ///
  /// In en, this message translates to:
  /// **'Unbookmark'**
  String get unbookmark;

  /// No description provided for @pools.
  ///
  /// In en, this message translates to:
  /// **'Pools'**
  String get pools;

  /// No description provided for @forum.
  ///
  /// In en, this message translates to:
  /// **'Forum'**
  String get forum;

  /// No description provided for @topics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get topics;

  /// No description provided for @topicsHide.
  ///
  /// In en, this message translates to:
  /// **'hide tags edits'**
  String get topicsHide;

  /// No description provided for @topicsHideOn.
  ///
  /// In en, this message translates to:
  /// **'hide tag alias and implications'**
  String get topicsHideOn;

  /// No description provided for @topicsHideOff.
  ///
  /// In en, this message translates to:
  /// **'show tag alias and implications'**
  String get topicsHideOff;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @browse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @flag.
  ///
  /// In en, this message translates to:
  /// **'Flag'**
  String get flag;

  /// No description provided for @editError.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to edit posts!'**
  String get editError;

  /// No description provided for @commentError.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to comment!'**
  String get commentError;

  /// No description provided for @reportError.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to report posts!'**
  String get reportError;

  /// No description provided for @flagError.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to flag posts!'**
  String get flagError;

  /// No description provided for @chooseIdentity.
  ///
  /// In en, this message translates to:
  /// **'Choose identity'**
  String get chooseIdentity;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @commentsLC.
  ///
  /// In en, this message translates to:
  /// **'comments'**
  String get commentsLC;

  /// lib/post/widget/detail/widget/comments.dart - COMMENTS
  ///
  /// In en, this message translates to:
  /// **'COMMENTS ({count})'**
  String commentsNumUC(int count);

  /// lib/comment/widget/post.dart - comments
  ///
  /// In en, this message translates to:
  /// **'#{postId} comments'**
  String commentsPostIdLC(int postId);

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @sources.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get sources;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @versionMessage1.
  ///
  /// In en, this message translates to:
  /// **'Fetching updates...'**
  String get versionMessage1;

  /// No description provided for @versionMessage2.
  ///
  /// In en, this message translates to:
  /// **'Failed to check for updates'**
  String get versionMessage2;

  /// No description provided for @versionMessage3.
  ///
  /// In en, this message translates to:
  /// **'You have the newest version'**
  String get versionMessage3;

  /// lib/settings/widget/about.dart - First Version
  ///
  /// In en, this message translates to:
  /// **'A newer version is available: {version}'**
  String versionMessage4(String version);

  /// lib/settings/widget/about.dart - Forum Thread
  ///
  /// In en, this message translates to:
  /// **'e621 thread #{TopicId}'**
  String forumThread(int TopicId);

  /// No description provided for @webSite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get webSite;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @playstore.
  ///
  /// In en, this message translates to:
  /// **'Playstore'**
  String get playstore;

  /// No description provided for @donors.
  ///
  /// In en, this message translates to:
  /// **'Donors'**
  String get donors;

  /// No description provided for @donorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Thanks for helping me keep up development!'**
  String get donorsSubtitle;

  /// No description provided for @donorsLite.
  ///
  /// In en, this message translates to:
  /// **'Not on the list? contact us!'**
  String get donorsLite;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @accountsHelper.
  ///
  /// In en, this message translates to:
  /// **'Don\'\'t have an account? Sign up here'**
  String get accountsHelper;

  /// No description provided for @addAccount.
  ///
  /// In en, this message translates to:
  /// **'Add account'**
  String get addAccount;

  /// No description provided for @editAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get editAccount;

  /// No description provided for @site.
  ///
  /// In en, this message translates to:
  /// **'Site'**
  String get site;

  /// No description provided for @siteNullWarn.
  ///
  /// In en, this message translates to:
  /// **'You must provide a host URL.'**
  String get siteNullWarn;

  /// No description provided for @siteUrlWarn.
  ///
  /// In en, this message translates to:
  /// **'Invalid host URL'**
  String get siteUrlWarn;

  /// No description provided for @siteChangedWarn.
  ///
  /// In en, this message translates to:
  /// **'Site can\'\'t be changed. \nAdd a new account to use a different one.'**
  String get siteChangedWarn;

  /// No description provided for @siteInfo.
  ///
  /// In en, this message translates to:
  /// **'The site is where your posts and account live.'**
  String get siteInfo;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @removeWarn.
  ///
  /// In en, this message translates to:
  /// **'Remove account?'**
  String get removeWarn;

  /// No description provided for @removeWarnInfo.
  ///
  /// In en, this message translates to:
  /// **'All its data will be permanently removed, including history and follows.'**
  String get removeWarnInfo;

  /// No description provided for @anonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymous;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @userWarn.
  ///
  /// In en, this message translates to:
  /// **'You must provide a username.'**
  String get userWarn;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// No description provided for @apiKey.
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get apiKey;

  /// No description provided for @apiKeyHelper.
  ///
  /// In en, this message translates to:
  /// **'Where do I find my API key?'**
  String get apiKeyHelper;

  /// lib/identity/widget/input.dart - API Key Rule
  ///
  /// In en, this message translates to:
  /// **'API key is a 24 or 32-character sequence of \'{A..z}\' and \'{0..9}\' \ne.g. {example}'**
  String apiKeyRuleWarn(String example);

  /// lib/identity/widget/input.dart - API Key Null
  ///
  /// In en, this message translates to:
  /// **'You must provide an API key.\ne.g. {example}'**
  String apiKeyNullWran(String example);

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// lib/user/widget/loading.dart - User ID
  ///
  /// In en, this message translates to:
  /// **'User #{id}'**
  String userID(int id);

  /// lib/user/widget/loading.dart - User Name
  ///
  /// In en, this message translates to:
  /// **'User {name}'**
  String userName(String name);

  /// No description provided for @unblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @blacklist.
  ///
  /// In en, this message translates to:
  /// **'Blacklist'**
  String get blacklist;

  /// No description provided for @follows.
  ///
  /// In en, this message translates to:
  /// **'Follows'**
  String get follows;

  /// No description provided for @uploads.
  ///
  /// In en, this message translates to:
  /// **'Uploads'**
  String get uploads;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutLC.
  ///
  /// In en, this message translates to:
  /// **'about'**
  String get aboutLC;

  /// No description provided for @comission.
  ///
  /// In en, this message translates to:
  /// **'Comission'**
  String get comission;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @infoLC.
  ///
  /// In en, this message translates to:
  /// **'info'**
  String get infoLC;

  /// No description provided for @idLC.
  ///
  /// In en, this message translates to:
  /// **'id'**
  String get idLC;

  /// No description provided for @joinedLC.
  ///
  /// In en, this message translates to:
  /// **'joined'**
  String get joinedLC;

  /// No description provided for @rankLC.
  ///
  /// In en, this message translates to:
  /// **'rank'**
  String get rankLC;

  /// No description provided for @postsLC.
  ///
  /// In en, this message translates to:
  /// **'posts'**
  String get postsLC;

  /// No description provided for @editsLC.
  ///
  /// In en, this message translates to:
  /// **'edits'**
  String get editsLC;

  /// No description provided for @favoritesLC.
  ///
  /// In en, this message translates to:
  /// **'favorites'**
  String get favoritesLC;

  /// No description provided for @comissionLC.
  ///
  /// In en, this message translates to:
  /// **'comission'**
  String get comissionLC;

  /// No description provided for @forumLC.
  ///
  /// In en, this message translates to:
  /// **'forum'**
  String get forumLC;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// lib/settings/widget/settings.dart &
  /// lib/history/widget/drawer.dart - History subtitle
  ///
  /// In en, this message translates to:
  /// **'{num} pages visited'**
  String historySubtitle(int num);

  /// No description provided for @historyClear.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get historyClear;

  /// No description provided for @historyClearSub.
  ///
  /// In en, this message translates to:
  /// **'Delete all entries'**
  String get historyClearSub;

  /// No description provided for @historyClearWarn.
  ///
  /// In en, this message translates to:
  /// **'Clear history?'**
  String get historyClearWarn;

  /// No description provided for @historyClearWarnInfo.
  ///
  /// In en, this message translates to:
  /// **'All history entries will be permanently deleted. This action cannot be undone.'**
  String get historyClearWarnInfo;

  /// No description provided for @historyLimit.
  ///
  /// In en, this message translates to:
  /// **'Limit history'**
  String get historyLimit;

  /// lib/history/widget/drawer.dart - History Limit Subtitle
  ///
  /// In en, this message translates to:
  /// **'Limited to newer than {days} months or \nless than {num} entries.'**
  String historyLimitSub(int days, String num);

  /// No description provided for @historyLimitWarnTitle.
  ///
  /// In en, this message translates to:
  /// **'History limit'**
  String get historyLimitWarnTitle;

  /// lib/history/widget/drawer.dart - History Limit Warning
  ///
  /// In en, this message translates to:
  /// **'Enabling history limit means all history entries beyond {num} \nand all entries older than {days} months are automatically deleted.'**
  String historyLimitWarn(String num, int days);

  /// No description provided for @historyInfinite.
  ///
  /// In en, this message translates to:
  /// **'history is infinite'**
  String get historyInfinite;

  /// lib/history/data/actions.dart - Posts History
  ///
  /// In en, this message translates to:
  /// **'Posts - {tag}'**
  String historyPosts(String tag);

  /// lib/history/data/actions.dart - Pools History
  ///
  /// In en, this message translates to:
  /// **'Pools - {name_matches}'**
  String historyPools(String name_matches);

  /// lib/history/data/actions.dart - Users History
  ///
  /// In en, this message translates to:
  /// **'Users - {name_matches}'**
  String historyUsers(String name_matches);

  /// lib/history/data/actions.dart - Wikis History
  ///
  /// In en, this message translates to:
  /// **'Wikis - {title}'**
  String historyWikis(String title);

  /// lib/history/data/actions.dart - Topics History
  ///
  /// In en, this message translates to:
  /// **'Topics - {title_matches}'**
  String historyTopics(String title_matches);

  /// lib/history/data/actions.dart - Replies History
  ///
  /// In en, this message translates to:
  /// **'Replies - {topic_title_matches}'**
  String historyReplies(String topic_title_matches);

  /// No description provided for @hotPosts.
  ///
  /// In en, this message translates to:
  /// **'Hot posts'**
  String get hotPosts;

  /// No description provided for @entries.
  ///
  /// In en, this message translates to:
  /// **'Entries'**
  String get entries;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @posts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get posts;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @replies.
  ///
  /// In en, this message translates to:
  /// **'Replies'**
  String get replies;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @wiki.
  ///
  /// In en, this message translates to:
  /// **'Wiki'**
  String get wiki;

  /// No description provided for @wikis.
  ///
  /// In en, this message translates to:
  /// **'Wikis'**
  String get wikis;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @subtract.
  ///
  /// In en, this message translates to:
  /// **'Subtract'**
  String get subtract;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @tasksEmpty.
  ///
  /// In en, this message translates to:
  /// **'No tasks'**
  String get tasksEmpty;

  /// No description provided for @tasksError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load tasks'**
  String get tasksError;

  /// No description provided for @tasksCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel all'**
  String get tasksCancel;

  /// No description provided for @tasksCancelLC.
  ///
  /// In en, this message translates to:
  /// **'cancel all'**
  String get tasksCancelLC;

  /// No description provided for @tasksClear.
  ///
  /// In en, this message translates to:
  /// **'Clear done'**
  String get tasksClear;

  /// No description provided for @tasksClearLC.
  ///
  /// In en, this message translates to:
  /// **'clear done'**
  String get tasksClearLC;

  /// No description provided for @tasksDownload.
  ///
  /// In en, this message translates to:
  /// **'download'**
  String get tasksDownload;

  /// No description provided for @tasksFavorite.
  ///
  /// In en, this message translates to:
  /// **'favorite'**
  String get tasksFavorite;

  /// No description provided for @tasksUnfavorite.
  ///
  /// In en, this message translates to:
  /// **'unfavorite'**
  String get tasksUnfavorite;

  /// No description provided for @tasksDownloading.
  ///
  /// In en, this message translates to:
  /// **'downloading'**
  String get tasksDownloading;

  /// No description provided for @tasksFavoriting.
  ///
  /// In en, this message translates to:
  /// **'favoriting'**
  String get tasksFavoriting;

  /// No description provided for @tasksUnfavoriting.
  ///
  /// In en, this message translates to:
  /// **'unfavoriting'**
  String get tasksUnfavoriting;

  /// No description provided for @tasksDownloaded.
  ///
  /// In en, this message translates to:
  /// **'downloaded'**
  String get tasksDownloaded;

  /// No description provided for @tasksFavorited.
  ///
  /// In en, this message translates to:
  /// **'favorited'**
  String get tasksFavorited;

  /// No description provided for @tasksUnfavorited.
  ///
  /// In en, this message translates to:
  /// **'unfavorited'**
  String get tasksUnfavorited;

  /// lib/task/widget/prompt.dart - Selected Num
  ///
  /// In en, this message translates to:
  /// **'{num} selected'**
  String tasksSelected(int num);

  /// lib/task/widget/list_view.dart - Task label
  ///
  /// In en, this message translates to:
  /// **'{label, select, active{active} done{done} other{}}'**
  String tasksLabel(String label);

  /// lib/task/widget/tile.dart - TaskStatus pending
  ///
  /// In en, this message translates to:
  /// **'queued to {present}'**
  String tasksPending(String present);

  /// lib/task/widget/tile.dart - TaskStatus failed
  ///
  /// In en, this message translates to:
  /// **'failed to {present}'**
  String tasksFailed(String present);

  /// lib/task/widget/tile.dart - TaskStatus canceled
  ///
  /// In en, this message translates to:
  /// **'canceled {present}'**
  String tasksCanceled(String present);

  /// lib/task/widget/tile.dart - TaskS title
  ///
  /// In en, this message translates to:
  /// **'{taskActionLabel} post #{postId}'**
  String tasksTitle(String taskActionLabel, int postId);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @tileSize.
  ///
  /// In en, this message translates to:
  /// **'Tile size'**
  String get tileSize;

  /// No description provided for @postInfo.
  ///
  /// In en, this message translates to:
  /// **'Post info'**
  String get postInfo;

  /// No description provided for @postInfoTrue.
  ///
  /// In en, this message translates to:
  /// **'info on post tiles'**
  String get postInfoTrue;

  /// No description provided for @postInfoFalse.
  ///
  /// In en, this message translates to:
  /// **'image tiles only'**
  String get postInfoFalse;

  /// No description provided for @interactions.
  ///
  /// In en, this message translates to:
  /// **'Interactions'**
  String get interactions;

  /// No description provided for @downloadLocation.
  ///
  /// In en, this message translates to:
  /// **'Download location'**
  String get downloadLocation;

  /// No description provided for @upvoteFavorites.
  ///
  /// In en, this message translates to:
  /// **'Upvote favorites'**
  String get upvoteFavorites;

  /// No description provided for @upvoteFavoritesTrue.
  ///
  /// In en, this message translates to:
  /// **'upvote and favorite'**
  String get upvoteFavoritesTrue;

  /// No description provided for @upvoteFavoritesFalse.
  ///
  /// In en, this message translates to:
  /// **'favorite only'**
  String get upvoteFavoritesFalse;

  /// No description provided for @videoVolume.
  ///
  /// In en, this message translates to:
  /// **'Video volume'**
  String get videoVolume;

  /// No description provided for @videoVolumeTrue.
  ///
  /// In en, this message translates to:
  /// **'muted'**
  String get videoVolumeTrue;

  /// No description provided for @videoVolumeFalse.
  ///
  /// In en, this message translates to:
  /// **'with sound'**
  String get videoVolumeFalse;

  /// No description provided for @videoResolution.
  ///
  /// In en, this message translates to:
  /// **'Video resolution'**
  String get videoResolution;

  /// No description provided for @videoResolutionStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard (480p)'**
  String get videoResolutionStandard;

  /// No description provided for @videoResolutionHigh.
  ///
  /// In en, this message translates to:
  /// **'High (720p)'**
  String get videoResolutionHigh;

  /// No description provided for @videoResolutionFull.
  ///
  /// In en, this message translates to:
  /// **'Full (1080p)'**
  String get videoResolutionFull;

  /// No description provided for @videoResolutionUltra.
  ///
  /// In en, this message translates to:
  /// **'Ultra (4K)'**
  String get videoResolutionUltra;

  /// No description provided for @videoResolutionSource.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get videoResolutionSource;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @secureDisplay.
  ///
  /// In en, this message translates to:
  /// **'Secure display'**
  String get secureDisplay;

  /// No description provided for @secureDisplayTrue.
  ///
  /// In en, this message translates to:
  /// **'screen protected'**
  String get secureDisplayTrue;

  /// No description provided for @secureDisplayFalse.
  ///
  /// In en, this message translates to:
  /// **'screen visible'**
  String get secureDisplayFalse;

  /// No description provided for @incognitoKeyboard.
  ///
  /// In en, this message translates to:
  /// **'Incognito keyboard'**
  String get incognitoKeyboard;

  /// No description provided for @pinLock.
  ///
  /// In en, this message translates to:
  /// **'PIN lock'**
  String get pinLock;

  /// No description provided for @pinLockTrue.
  ///
  /// In en, this message translates to:
  /// **'PIN enabled'**
  String get pinLockTrue;

  /// No description provided for @pinLockFalse.
  ///
  /// In en, this message translates to:
  /// **'PIN disabled'**
  String get pinLockFalse;

  /// No description provided for @biometricLock.
  ///
  /// In en, this message translates to:
  /// **'Biometric lock'**
  String get biometricLock;

  /// No description provided for @biometricLockTrue.
  ///
  /// In en, this message translates to:
  /// **'biometrics enabled'**
  String get biometricLockTrue;

  /// No description provided for @biometricLockFalse.
  ///
  /// In en, this message translates to:
  /// **'biometrics disabled'**
  String get biometricLockFalse;

  /// No description provided for @development.
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get development;

  /// No description provided for @developerMode.
  ///
  /// In en, this message translates to:
  /// **'Developer mode'**
  String get developerMode;

  /// No description provided for @developerModeTrue.
  ///
  /// In en, this message translates to:
  /// **'options shown'**
  String get developerModeTrue;

  /// No description provided for @developerModeFalse.
  ///
  /// In en, this message translates to:
  /// **'options hidden'**
  String get developerModeFalse;

  /// No description provided for @logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;

  /// No description provided for @logsUC.
  ///
  /// In en, this message translates to:
  /// **'LOGS'**
  String get logsUC;

  /// lib/settings/widget/settings.dart - Logs subtitle
  ///
  /// In en, this message translates to:
  /// **'{num} errors logged'**
  String logsSubtitle(int num);

  /// No description provided for @logsError.
  ///
  /// In en, this message translates to:
  /// **'A critical error has occured!'**
  String get logsError;

  /// No description provided for @database.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get database;

  /// No description provided for @databaseExport.
  ///
  /// In en, this message translates to:
  /// **'Save a backup copy of your database'**
  String get databaseExport;

  /// No description provided for @databaseExportPush.
  ///
  /// In en, this message translates to:
  /// **'Exporting database...'**
  String get databaseExportPush;

  /// No description provided for @databaseImport.
  ///
  /// In en, this message translates to:
  /// **'Replace current database with imported one'**
  String get databaseImport;

  /// No description provided for @databaseImportPush.
  ///
  /// In en, this message translates to:
  /// **'Import Database'**
  String get databaseImportPush;

  /// No description provided for @databaseImportPushWarn.
  ///
  /// In en, this message translates to:
  /// **'This will replace your current database. \nAll data will be lost. This cannot be undone!'**
  String get databaseImportPushWarn;

  /// No description provided for @okUC.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okUC;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @importUC.
  ///
  /// In en, this message translates to:
  /// **'IMPORT'**
  String get importUC;

  /// No description provided for @cancelUC.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancelUC;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @removeUC.
  ///
  /// In en, this message translates to:
  /// **'REMOVE'**
  String get removeUC;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart Required'**
  String get restart;

  /// No description provided for @restartWarn.
  ///
  /// In en, this message translates to:
  /// **'The app needs to restart to apply changes.'**
  String get restartWarn;

  /// No description provided for @restartNow.
  ///
  /// In en, this message translates to:
  /// **'RESTART NOW'**
  String get restartNow;

  /// No description provided for @noArtist.
  ///
  /// In en, this message translates to:
  /// **'no artist'**
  String get noArtist;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @enabledLC.
  ///
  /// In en, this message translates to:
  /// **'enabled'**
  String get enabledLC;

  /// No description provided for @disabledLC.
  ///
  /// In en, this message translates to:
  /// **'disabled'**
  String get disabledLC;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'dismiss'**
  String get dismiss;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
