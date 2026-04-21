import 'dart:convert';

import 'package:acal/features/auth/data/auth_storage.dart';
import 'package:acal/features/auth/domain/auth_tokens.dart';

class AuthService {
  final AuthStorage _storage;

  AuthService(this._storage);

  Future<bool> isAuthenticated() async {
    final token = await _storage.readAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    // Stub de autenticacao: substitua pela chamada HTTP real.
    final tokens = AuthTokens.fromResponse({
      'token': _mockSpringBootJwt(email),
      'type': 'Bearer',
    });

    await _storage.saveTokens(
      tokens.accessToken,
    );

    return true;
  }

  Future<void> logout() async {
    await _storage.clear();
  }

  String _mockSpringBootJwt(String email) {
    final header = base64Url.encode(utf8.encode('{"alg":"HS256","typ":"JWT"}'));
    final issuedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expiresAt = issuedAt + 3600;
    final payload = base64Url.encode(
      utf8.encode(
        '{"sub":"$email","iat":$issuedAt,"exp":$expiresAt}',
      ),
    );

    return '${base64Url.normalize(header)}.${base64Url.normalize(payload)}.signature';
  }
}