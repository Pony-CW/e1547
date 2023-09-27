import 'package:e1547/client/client.dart';
import 'package:e1547/identity/identity.dart';
import 'package:e1547/interface/interface.dart';
import 'package:e1547/traits/traits.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ClientType {
  e621,
}

class ClientConfig {
  ClientConfig({
    required this.identity,
    required this.traits,
    required this.userAgent,
    this.cache,
  });

  final Identity identity;
  final ValueNotifier<Traits> traits;
  final String userAgent;
  final CacheStore? cache;
}

class ClientFactory {
  Client create(ClientConfig config) {
    switch (config.identity.type) {
      case ClientType.e621:
        return Client(
          identity: config.identity,
          traits: config.traits,
          userAgent: config.userAgent,
          cache: config.cache,
        );
    }
  }

  IdentityRequest createDefaultIdentity() {
    return const IdentityRequest(
      host: 'https://e926.net/',
      type: ClientType.e621,
      username: null,
      headers: null,
    );
  }

  TraitsRequest createDefaultTraits(Identity identity) {
    return switch (identity.type) {
      ClientType.e621 => TraitsRequest(
          identity: identity.id,
          denylist: ['young -rating:s', 'gore', 'scat', 'watersports'],
          homeTags: 'score:>=20',
        ),
    };
  }

  ClientType? typeFromUrl(String url) {
    return switch (normalizeHostUrl(url)) {
      'https://e621.net' => ClientType.e621,
      'https://e926.net' => ClientType.e621,
      _ => null,
    };
  }
}
