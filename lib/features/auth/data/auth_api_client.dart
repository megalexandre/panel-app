import 'dart:convert';

import 'package:acal/features/auth/domain/auth_failure.dart';
import 'package:acal/features/auth/domain/login_attempt.dart';
import 'package:acal/shared/network/api_routes.dart';
import 'package:http/http.dart' as http;

abstract class AuthApiClient {
  Future<Map<String, dynamic>> login(LoginAttempt attempt);
  Future<Map<String, dynamic>> refresh(String refreshToken);
  Future<Map<String, dynamic>> getMe(String accessToken);
}

class AuthApiClientException implements Exception {
  final AuthFailureType type;
  final String message;

  const AuthApiClientException({
    required this.type,
    required this.message,
  });
}

class HttpAuthApiClient implements AuthApiClient {
  final String _baseUrl;
  final http.Client _httpClient;

  HttpAuthApiClient({
    String? baseUrl,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl ?? ApiRoutes.defaultBaseUrl,
        _httpClient = httpClient ?? http.Client();

  @override
  Future<Map<String, dynamic>> login(LoginAttempt attempt) {
    return _postJson(
      Uri.parse('$_baseUrl/auth/login'),
      {'email': attempt.email, 'password': attempt.password},
      unauthorizedMessage: 'Credenciais invalidas.',
    );
  }

  @override
  Future<Map<String, dynamic>> refresh(String refreshToken) {
    return _postJson(
      Uri.parse('$_baseUrl/auth/refresh'),
      {'refresh_token': refreshToken},
      unauthorizedMessage: 'Sessao expirada. Faca login novamente.',
      unauthorizedType: AuthFailureType.sessionExpired,
    );
  }

  @override
  Future<Map<String, dynamic>> getMe(String accessToken) {
    return _getJson(
      Uri.parse('$_baseUrl/users/me'),
      accessToken: accessToken,
    );
  }

  Future<Map<String, dynamic>> _getJson(
    Uri uri, {
    required String accessToken,
  }) async {
    http.Response response;

    try {
      response = await _httpClient.get(
        uri,
        headers: {'Authorization': 'Bearer $accessToken'},
      );
    } catch (_) {
      throw const AuthApiClientException(
        type: AuthFailureType.network,
        message: 'Falha de rede ao conectar no servidor.',
      );
    }

    if (response.statusCode == 401) {
      throw const AuthApiClientException(
        type: AuthFailureType.sessionExpired,
        message: 'Sessao expirada. Faca login novamente.',
      );
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw const AuthApiClientException(
        type: AuthFailureType.server,
        message: 'Falha no servidor.',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const AuthApiClientException(
        type: AuthFailureType.invalidResponse,
        message: 'Resposta invalida da API.',
      );
    }

    return decoded;
  }

  Future<Map<String, dynamic>> _postJson(
    Uri uri,
    Map<String, dynamic> body, {
    required String unauthorizedMessage,
    AuthFailureType unauthorizedType = AuthFailureType.invalidCredentials,
  }) async {
    http.Response response;

    try {
      response = await _httpClient.post(
        uri,
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (_) {
      throw const AuthApiClientException(
        type: AuthFailureType.network,
        message: 'Falha de rede ao conectar no servidor.',
      );
    }

    if (response.statusCode == 401) {
      throw AuthApiClientException(
        type: unauthorizedType,
        message: unauthorizedMessage,
      );
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw const AuthApiClientException(
        type: AuthFailureType.server,
        message: 'Falha no servidor de autenticacao.',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const AuthApiClientException(
        type: AuthFailureType.invalidResponse,
        message: 'Resposta invalida da API de autenticacao.',
      );
    }

    return decoded;
  }
}
