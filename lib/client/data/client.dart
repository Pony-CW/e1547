import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e1547/client/client.dart';
import 'package:e1547/interface/interface.dart';

export 'dart:io' show Cookie;
export 'package:dio/dio.dart' show CancelToken;
export 'package:dio_cache_interceptor/dio_cache_interceptor.dart'
    show CacheStore;

abstract class Client {
  Client({
    required this.host,
    required this.userAgent,
    this.cache,
    this.memoryCache,
    this.credentials,
    this.cookies,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: Uri.https(host, '/').toString(),
            headers: {
              HttpHeaders.userAgentHeader: userAgent,
              HttpHeaders.cookieHeader: cookies
                  ?.map((cookie) => '${cookie.name}=${cookie.value}')
                  .join('; '),
              if (credentials != null)
                HttpHeaders.authorizationHeader: credentials.basicAuth,
            },
            sendTimeout: const Duration(seconds: 30),
            connectTimeout: const Duration(seconds: 30),
          ),
        ) {
    if (cache != null) {
      dio.interceptors.add(
        CacheInterceptor(
          options: CacheConfig(
            store: cache,
            maxAge: const Duration(minutes: 5),
            pageParam: 'page',
          ),
        ),
      );
    }
  }

  final String host;
  final String userAgent;
  final CacheStore? cache;
  final CacheStore? memoryCache;
  final Credentials? credentials;
  final List<Cookie>? cookies;
  final Dio dio;

  void close({bool force = false}) => dio.close(force: force);

  bool get hasLogin => credentials != null;

  void ensureLogin() {
    if (!hasLogin) {
      throw StateError('User is not logged in!');
    }
  }

  String withHost(String path) => Uri.parse(path)
      .replace(
        scheme: 'https',
        host: host,
      )
      .toString();
}
