import 'package:e1547/client/client.dart';
import 'package:e1547/client/e621.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'host.g.dart';

@DataClass()
class ClientConfig with _$ClientConfig {
  ClientConfig({
    required this.host,
    required this.userAgent,
    this.cache,
    this.memoryCache,
    this.credentials,
    this.cookies,
  });

  final String host;
  final String userAgent;
  final CacheStore? cache;
  final CacheStore? memoryCache;
  final Credentials? credentials;
  final List<Cookie>? cookies;
}

enum ApiType { e621 }

extension ApiClientCreation on ApiType {
  Client createClient(ClientConfig config) {
    switch (this) {
      case ApiType.e621:
        return e621Client(
          host: config.host,
          userAgent: config.userAgent,
          cache: config.cache,
          credentials: config.credentials,
          cookies: config.cookies,
        );
    }
  }

  Client createClientFromService(ClientService service) {
    return createClient(
      ClientConfig(
        host: service.host,
        credentials: service.credentials,
        userAgent: service.userAgent,
        cache: service.cache,
        cookies: service.cookies,
      ),
    );
  }
}

ApiType? getApiTypeForHost(String host) {
  Uri url = Uri.parse(host);
  if (['e621.net', 'e926.net'].contains(url.host)) {
    return ApiType.e621;
  }
  return null;
}
