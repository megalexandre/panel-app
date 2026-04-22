import 'dart:convert';

class AuthTokens {
  final String accessToken;
  final String? refreshToken;
  final String tokenType;
  final String? subject;
  final DateTime? issuedAt;
  final DateTime? expiresAt;

  const AuthTokens({
    required this.accessToken,
    this.refreshToken,
    this.tokenType = 'Bearer',
    this.subject,
    this.issuedAt,
    this.expiresAt,
  });

  String get authorizationHeader => '$tokenType $accessToken';

  bool get isExpired {
    if (expiresAt == null) {
      return false;
    }

    return DateTime.now().isAfter(expiresAt!);
  }

  factory AuthTokens.fromJwt(
    String jwt, {
    String? refreshToken,
    String tokenType = 'Bearer',
  }) {
    final payload = _parseJwtPayload(jwt);

    return AuthTokens(
      accessToken: jwt,
      refreshToken: refreshToken,
      tokenType: tokenType,
      subject: payload['sub'] as String?,
      issuedAt: _parseUnixTimestamp(payload['iat']),
      expiresAt: _parseUnixTimestamp(payload['exp']),
    );
  }

  factory AuthTokens.fromResponse(Map<String, dynamic> response) {
    final token = response['token'] ?? response['access_token'] ?? response['accessToken'] ?? response['jwt'];

    if (token is! String || token.isEmpty) {
      throw const FormatException('Resposta de autenticacao sem JWT valido.');
    }

    final refreshToken = response['refresh_token'] ?? response['refreshToken'];
    final tokenType = response['type'] ?? response['token_type'] ?? response['tokenType'];

    return AuthTokens.fromJwt(
      token,
      refreshToken: refreshToken is String && refreshToken.isNotEmpty ? refreshToken : null,
      tokenType: tokenType is String && tokenType.isNotEmpty ? tokenType : 'Bearer',
    );
  }

  static Map<String, dynamic> _parseJwtPayload(String jwt) {
    final parts = jwt.split('.');
    if (parts.length != 3) {
      throw const FormatException('JWT invalido.');
    }

    final normalized = base64Url.normalize(parts[1]);
    final decoded = utf8.decode(base64Url.decode(normalized));
    final payload = jsonDecode(decoded);

    if (payload is! Map<String, dynamic>) {
      throw const FormatException('Payload do JWT invalido.');
    }

    return payload;
  }

  static DateTime? _parseUnixTimestamp(Object? value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value * 1000, isUtc: true).toLocal();
    }

    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) {
        return DateTime.fromMillisecondsSinceEpoch(parsed * 1000, isUtc: true).toLocal();
      }
    }

    return null;
  }
}