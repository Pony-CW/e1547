// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$ClientConfig {
  ClientConfig get _self => this as ClientConfig;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientConfig &&
          runtimeType == other.runtimeType &&
          _self.host == other.host &&
          _self.userAgent == other.userAgent &&
          _self.cache == other.cache &&
          _self.credentials == other.credentials &&
          $listEquality.equals(_self.cookies, other.cookies);
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.host.hashCode);
    hashCode = $hashCombine(hashCode, _self.userAgent.hashCode);
    hashCode = $hashCombine(hashCode, _self.cache.hashCode);
    hashCode = $hashCombine(hashCode, _self.credentials.hashCode);
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.cookies));
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('ClientConfig')
        ..add('host', _self.host)
        ..add('userAgent', _self.userAgent)
        ..add('cache', _self.cache)
        ..add('credentials', _self.credentials)
        ..add('cookies', _self.cookies))
      .toString();
  ClientConfig copyWith({
    String? host,
    String? userAgent,
    CacheStore? cache,
    Credentials? credentials,
    List<Cookie>? cookies,
  }) {
    return ClientConfig(
      host: host ?? _self.host,
      userAgent: userAgent ?? _self.userAgent,
      cache: cache ?? _self.cache,
      credentials: credentials ?? _self.credentials,
      cookies: cookies ?? _self.cookies,
    );
  }

  ClientConfig change(void Function(_ClientConfigChanges c) updates) =>
      (_ClientConfigChanges._(_self)..update(updates)).build();
  _ClientConfigChanges toChanges() => _ClientConfigChanges._(_self);
}

class _ClientConfigChanges {
  _ClientConfigChanges._(ClientConfig dc)
      : host = dc.host,
        userAgent = dc.userAgent,
        cache = dc.cache,
        credentials = dc.credentials,
        cookies = dc.cookies;

  String host;

  String userAgent;

  CacheStore? cache;

  Credentials? credentials;

  List<Cookie>? cookies;

  void update(void Function(_ClientConfigChanges c) updates) => updates(this);
  ClientConfig build() => ClientConfig(
        host: host,
        userAgent: userAgent,
        cache: cache,
        credentials: credentials,
        cookies: cookies,
      );
}
