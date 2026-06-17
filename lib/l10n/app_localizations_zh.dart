// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get home => '主页';

  @override
  String get hot => '热门';

  @override
  String get search => '搜索';

  @override
  String get favorites => '喜爱';

  @override
  String get favoritesError => 'Favorites are unavailable for anonymous users';

  @override
  String get timeline => '时间线';

  @override
  String get timelineEmpty => '没有帖子';

  @override
  String get timelineError => '加载帖子失败';

  @override
  String get subscriptions => '订阅';

  @override
  String get subscriptionsEmpty => '没有订阅';

  @override
  String get subscriptionsError => '加载订阅失败';

  @override
  String get bookmarks => '书签';

  @override
  String get bookmarksEmpty => '没有书签';

  @override
  String get bookmarksError => '加载书签失败';

  @override
  String get pools => '图池';

  @override
  String get forum => '论坛';

  @override
  String get topics => '话题';

  @override
  String get topicsHide => '隐藏标签编辑';

  @override
  String get topicsHideOn => 'hide tag alias and implications';

  @override
  String get topicsHideOff => 'show tag alias and implications';

  @override
  String get share => '分享';

  @override
  String get download => '下载';

  @override
  String get browse => '浏览器';

  @override
  String get edit => '编辑';

  @override
  String get comment => '评论';

  @override
  String get report => '举报';

  @override
  String get flag => '标记';

  @override
  String get editError => '你需要登录才能编辑帖子！';

  @override
  String get commentError => '你需要登录才能评论！';

  @override
  String get reportError => '你需要登录才能举报帖子！';

  @override
  String get flagError => '你需要登录才能标记帖子';

  @override
  String get chooseIdentity => '选择身份';

  @override
  String get commentsLC => '评论';

  @override
  String commentsNumUC(int count) {
    return '评论 ($count)';
  }

  @override
  String commentsPostIdLC(int postId) {
    return '#$postId 评论';
  }

  @override
  String get file => '文件';

  @override
  String get sources => '来源';

  @override
  String get version => '版本';

  @override
  String get webSite => '主页';

  @override
  String get email => '邮箱';

  @override
  String get playstore => '谷歌商店';

  @override
  String get donors => '捐赠者';

  @override
  String get donorsSubtitle => '感谢你帮助我保持开发！';

  @override
  String get donorsLite => '没在名单里？联系我们！';

  @override
  String get settings => '设置';

  @override
  String get identity => '身份';

  @override
  String get host => '服务器';

  @override
  String get hostNullWarn => '您需要填写服务器地址';

  @override
  String get hostUrlWarn => '无效的服务器地址';

  @override
  String get authentication => '认证';

  @override
  String get login => '登录';

  @override
  String get anonymous => '匿名';

  @override
  String get username => '用户名';

  @override
  String get userWarn => '您需要填写用户名';

  @override
  String get apiKey => 'API 密钥';

  @override
  String apiKeyHelper(String example) {
    return '例如 $example';
  }

  @override
  String apiKeyWran(String example) {
    return '你需要填写 API 密钥 \n例如 $example';
  }

  @override
  String get user => '用户';

  @override
  String get unblock => '解除阻止';

  @override
  String get block => '阻止';

  @override
  String get blacklist => '黑名单';

  @override
  String get follows => '关注';

  @override
  String get uploads => '上传';

  @override
  String get about => '关于';

  @override
  String get aboutLC => '关于';

  @override
  String get comission => 'Comission';

  @override
  String get info => '信息';

  @override
  String get infoLC => '信息';

  @override
  String get idLC => 'id';

  @override
  String get joinedLC => 'joined';

  @override
  String get rankLC => 'rank';

  @override
  String get postsLC => '帖子';

  @override
  String get editsLC => '编辑';

  @override
  String get favoritesLC => '喜爱';

  @override
  String get comissionLC => '评论';

  @override
  String get forumLC => '论坛';

  @override
  String get history => '历史';

  @override
  String historySubtitle(int num) {
    return '$num 页已访问';
  }

  @override
  String get historyClear => '清除历史';

  @override
  String get historyClearSub => '删除所有条目';

  @override
  String get historyClearWarn => '清除历史？';

  @override
  String get historyClearWarnInfo => '所有历史记录条目都将被永久删除。此操作无法撤销。';

  @override
  String get historyLimit => '限制历史';

  @override
  String historyLimitSub(int days, String num) {
    return '限制于 $days 个月内或 \n少于 $num 条目';
  }

  @override
  String get historyLimitWarnTitle => '历史限制';

  @override
  String historyLimitWarn(String num, int days) {
    return '启用历史限制意味着超过 $num 条\n或超过 $days 个月的所有条目都将被自动删除';
  }

  @override
  String get historyInfinite => '历史是无限制的';

  @override
  String historyPosts(String tag) {
    return '帖子 - $tag';
  }

  @override
  String historyPools(String name_matches) {
    return '图池 - $name_matches';
  }

  @override
  String historyUsers(String name_matches) {
    return '用户 - $name_matches';
  }

  @override
  String historyWikis(String title) {
    return '维基 - $title';
  }

  @override
  String historyTopics(String title_matches) {
    return '话题 - $title_matches';
  }

  @override
  String historyReplies(String topic_title_matches) {
    return '回复 - $topic_title_matches';
  }

  @override
  String get hotPosts => '热门帖子';

  @override
  String get entries => '条目';

  @override
  String get type => '类型';

  @override
  String get posts => '帖子';

  @override
  String get users => '用户';

  @override
  String get wikis => '维基';

  @override
  String get replies => '回复';

  @override
  String get tags => '标签';

  @override
  String get tasks => '任务';

  @override
  String get appearance => '外观';

  @override
  String get language => '语言';

  @override
  String get theme => '主题';

  @override
  String get tileSize => '瓷贴大小';

  @override
  String get postInfo => '帖子信息';

  @override
  String get postInfoTrue => '信息在瓷贴上';

  @override
  String get postInfoFalse => '仅图像';

  @override
  String get interactions => '交互';

  @override
  String get downloadLocation => '下载路径';

  @override
  String get upvoteFavorites => '顶和喜爱选项';

  @override
  String get upvoteFavoritesTrue => '顶和喜爱';

  @override
  String get upvoteFavoritesFalse => '仅喜爱';

  @override
  String get videoVolume => '视频声音';

  @override
  String get videoVolumeTrue => '静音';

  @override
  String get videoVolumeFalse => '有声';

  @override
  String get videoResolution => '视频分辨率';

  @override
  String get videoResolutionStandard => '标准 (480p)';

  @override
  String get videoResolutionHigh => '高清 (720p)';

  @override
  String get videoResolutionFull => '全高清 (1080p)';

  @override
  String get videoResolutionUltra => '超高清 (4K)';

  @override
  String get videoResolutionSource => '原始分辨率';

  @override
  String get security => '安全';

  @override
  String get secureDisplay => '安全显示';

  @override
  String get secureDisplayTrue => '屏幕保护';

  @override
  String get secureDisplayFalse => '屏幕可见';

  @override
  String get incognitoKeyboard => '隐身键盘';

  @override
  String get pinLock => 'PIN 锁';

  @override
  String get pinLockTrue => 'PIN 已启用';

  @override
  String get pinLockFalse => 'PIN 已禁用';

  @override
  String get biometricLock => '指纹锁';

  @override
  String get biometricLockTrue => '指纹已启用';

  @override
  String get biometricLockFalse => '指纹已禁用';

  @override
  String get development => '开发者选项';

  @override
  String get developerMode => '开发者模式';

  @override
  String get developerModeTrue => '显示设置';

  @override
  String get developerModeFalse => '隐藏设置';

  @override
  String get logs => '日志';

  @override
  String get logsUC => '日志';

  @override
  String logsSubtitle(int num) {
    return '$num 条错误日志';
  }

  @override
  String get logsError => 'A critical error has occured!';

  @override
  String get database => '数据库';

  @override
  String get databaseExport => '保存并备份您的数据库';

  @override
  String get databaseExportPush => '正在导出数据库...';

  @override
  String get databaseImport => '导入并替换当前数据库';

  @override
  String get databaseImportPush => '导入数据库';

  @override
  String get databaseImportPushWarn => '这将替换您当前的数据库 \n所有数据将会丢失。此操作无法撤销！';

  @override
  String get okUC => '好的';

  @override
  String get clear => '清除';

  @override
  String get export => '导出';

  @override
  String get import => '导入';

  @override
  String get cancel => '取消';

  @override
  String get importUC => '导入';

  @override
  String get cancelUC => '取消';

  @override
  String get restart => '需要重启';

  @override
  String get restartWarn => 'App 需要重启以完成更改';

  @override
  String get restartNow => '现在重启';

  @override
  String get noArtist => '无作者';

  @override
  String get enabled => '启用';

  @override
  String get enabledLC => '启用';

  @override
  String get disabledLC => '禁用';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get home => '主页';

  @override
  String get hot => '热门';

  @override
  String get search => '搜索';

  @override
  String get favorites => '喜爱';

  @override
  String get favoritesError => 'Favorites are unavailable for anonymous users';

  @override
  String get timeline => '时间线';

  @override
  String get timelineEmpty => '没有帖子';

  @override
  String get timelineError => '加载帖子失败';

  @override
  String get subscriptions => '订阅';

  @override
  String get subscriptionsEmpty => '没有订阅';

  @override
  String get subscriptionsError => '加载订阅失败';

  @override
  String get bookmarks => '书签';

  @override
  String get bookmarksEmpty => '没有书签';

  @override
  String get bookmarksError => '加载书签失败';

  @override
  String get pools => '图池';

  @override
  String get forum => '论坛';

  @override
  String get topics => '话题';

  @override
  String get topicsHide => '隐藏标签编辑';

  @override
  String get topicsHideOn => 'hide tag alias and implications';

  @override
  String get topicsHideOff => 'show tag alias and implications';

  @override
  String get share => '分享';

  @override
  String get download => '下载';

  @override
  String get browse => '浏览器';

  @override
  String get edit => '编辑';

  @override
  String get comment => '评论';

  @override
  String get report => '举报';

  @override
  String get flag => '标记';

  @override
  String get editError => '你需要登录才能编辑帖子！';

  @override
  String get commentError => '你需要登录才能评论！';

  @override
  String get reportError => '你需要登录才能举报帖子！';

  @override
  String get flagError => '你需要登录才能标记帖子';

  @override
  String get chooseIdentity => '选择身份';

  @override
  String get commentsLC => '评论';

  @override
  String commentsNumUC(int count) {
    return '评论 ($count)';
  }

  @override
  String commentsPostIdLC(int postId) {
    return '#$postId 评论';
  }

  @override
  String get file => '文件';

  @override
  String get sources => '来源';

  @override
  String get version => '版本';

  @override
  String get webSite => '主页';

  @override
  String get email => '邮箱';

  @override
  String get playstore => '谷歌商店';

  @override
  String get donors => '捐赠者';

  @override
  String get donorsSubtitle => '感谢你帮助我保持开发！';

  @override
  String get donorsLite => '没在名单里？联系我们！';

  @override
  String get settings => '设置';

  @override
  String get identity => '身份';

  @override
  String get host => '服务器';

  @override
  String get hostNullWarn => '您需要填写服务器地址';

  @override
  String get hostUrlWarn => '无效的服务器地址';

  @override
  String get authentication => '认证';

  @override
  String get login => '登录';

  @override
  String get anonymous => '匿名';

  @override
  String get username => '用户名';

  @override
  String get userWarn => '您需要填写用户名';

  @override
  String get apiKey => 'API 密钥';

  @override
  String apiKeyHelper(String example) {
    return '例如 $example';
  }

  @override
  String apiKeyWran(String example) {
    return '你需要填写 API 密钥 \n例如 $example';
  }

  @override
  String get user => '用户';

  @override
  String get unblock => '解除阻止';

  @override
  String get block => '阻止';

  @override
  String get blacklist => '黑名单';

  @override
  String get follows => '关注';

  @override
  String get uploads => '上传';

  @override
  String get about => '关于';

  @override
  String get aboutLC => '关于';

  @override
  String get comission => 'Comission';

  @override
  String get info => '信息';

  @override
  String get infoLC => '信息';

  @override
  String get idLC => 'id';

  @override
  String get joinedLC => 'joined';

  @override
  String get rankLC => 'rank';

  @override
  String get postsLC => '帖子';

  @override
  String get editsLC => '编辑';

  @override
  String get favoritesLC => '喜爱';

  @override
  String get comissionLC => '评论';

  @override
  String get forumLC => '论坛';

  @override
  String get history => '历史';

  @override
  String historySubtitle(int num) {
    return '$num 页已访问';
  }

  @override
  String get historyClear => '清除历史';

  @override
  String get historyClearSub => '删除所有条目';

  @override
  String get historyClearWarn => '清除历史？';

  @override
  String get historyClearWarnInfo => '所有历史记录条目都将被永久删除。此操作无法撤销。';

  @override
  String get historyLimit => '限制历史';

  @override
  String historyLimitSub(int days, String num) {
    return '限制于 $days 个月内或 \n少于 $num 条目';
  }

  @override
  String get historyLimitWarnTitle => '历史限制';

  @override
  String historyLimitWarn(String num, int days) {
    return '启用历史限制意味着超过 $num 条\n或超过 $days 个月的所有条目都将被自动删除';
  }

  @override
  String get historyInfinite => '历史是无限制的';

  @override
  String historyPosts(String tag) {
    return '帖子 - $tag';
  }

  @override
  String historyPools(String name_matches) {
    return '图池 - $name_matches';
  }

  @override
  String historyUsers(String name_matches) {
    return '用户 - $name_matches';
  }

  @override
  String historyWikis(String title) {
    return '维基 - $title';
  }

  @override
  String historyTopics(String title_matches) {
    return '话题 - $title_matches';
  }

  @override
  String historyReplies(String topic_title_matches) {
    return '回复 - $topic_title_matches';
  }

  @override
  String get hotPosts => '热门帖子';

  @override
  String get entries => '条目';

  @override
  String get type => '类型';

  @override
  String get posts => '帖子';

  @override
  String get users => '用户';

  @override
  String get wikis => '维基';

  @override
  String get replies => '回复';

  @override
  String get tags => '标签';

  @override
  String get tasks => '任务';

  @override
  String get appearance => '外观';

  @override
  String get language => '语言';

  @override
  String get theme => '主题';

  @override
  String get tileSize => '瓷贴大小';

  @override
  String get postInfo => '帖子信息';

  @override
  String get postInfoTrue => '信息在瓷贴上';

  @override
  String get postInfoFalse => '仅图像';

  @override
  String get interactions => '交互';

  @override
  String get downloadLocation => '下载路径';

  @override
  String get upvoteFavorites => '顶和喜爱选项';

  @override
  String get upvoteFavoritesTrue => '顶和喜爱';

  @override
  String get upvoteFavoritesFalse => '仅喜爱';

  @override
  String get videoVolume => '视频声音';

  @override
  String get videoVolumeTrue => '静音';

  @override
  String get videoVolumeFalse => '有声';

  @override
  String get videoResolution => '视频分辨率';

  @override
  String get videoResolutionStandard => '标准 (480p)';

  @override
  String get videoResolutionHigh => '高清 (720p)';

  @override
  String get videoResolutionFull => '全高清 (1080p)';

  @override
  String get videoResolutionUltra => '超高清 (4K)';

  @override
  String get videoResolutionSource => '原始分辨率';

  @override
  String get security => '安全';

  @override
  String get secureDisplay => '安全显示';

  @override
  String get secureDisplayTrue => '屏幕保护';

  @override
  String get secureDisplayFalse => '屏幕可见';

  @override
  String get incognitoKeyboard => '隐身键盘';

  @override
  String get pinLock => 'PIN 锁';

  @override
  String get pinLockTrue => 'PIN 已启用';

  @override
  String get pinLockFalse => 'PIN 已禁用';

  @override
  String get biometricLock => '指纹锁';

  @override
  String get biometricLockTrue => '指纹已启用';

  @override
  String get biometricLockFalse => '指纹已禁用';

  @override
  String get development => '开发者选项';

  @override
  String get developerMode => '开发者模式';

  @override
  String get developerModeTrue => '显示设置';

  @override
  String get developerModeFalse => '隐藏设置';

  @override
  String get logs => '日志';

  @override
  String get logsUC => '日志';

  @override
  String logsSubtitle(int num) {
    return '$num 条错误日志';
  }

  @override
  String get logsError => 'A critical error has occured!';

  @override
  String get database => '数据库';

  @override
  String get databaseExport => '保存并备份您的数据库';

  @override
  String get databaseExportPush => '正在导出数据库...';

  @override
  String get databaseImport => '导入并替换当前数据库';

  @override
  String get databaseImportPush => '导入数据库';

  @override
  String get databaseImportPushWarn => '这将替换您当前的数据库 \n所有数据将会丢失。此操作无法撤销！';

  @override
  String get okUC => '好的';

  @override
  String get clear => '清除';

  @override
  String get export => '导出';

  @override
  String get import => '导入';

  @override
  String get cancel => '取消';

  @override
  String get importUC => '导入';

  @override
  String get cancelUC => '取消';

  @override
  String get restart => '需要重启';

  @override
  String get restartWarn => 'App 需要重启以完成更改';

  @override
  String get restartNow => '现在重启';

  @override
  String get noArtist => '无作者';

  @override
  String get enabled => '启用';

  @override
  String get enabledLC => '启用';

  @override
  String get disabledLC => '禁用';
}
