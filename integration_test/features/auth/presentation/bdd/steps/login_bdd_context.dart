import 'dart:convert';

import 'package:acal/features/auth/data/auth_api_client.dart';
import 'package:acal/features/auth/data/auth_service.dart';
import 'package:acal/features/auth/data/auth_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginBddContext {
  static const String wiremockBaseUrl = 'http://localhost:8080';

  late AuthService authService = AuthService(
    AuthStorage(),
    apiClient: HttpAuthApiClient(baseUrl: wiremockBaseUrl),
  );

  Future<void> reset() async {
    SharedPreferences.setMockInitialValues({});
    await _resetWireMockRequests();
    authService = AuthService(
      AuthStorage(),
      apiClient: HttpAuthApiClient(baseUrl: wiremockBaseUrl),
    );
  }

  Future<void> _resetWireMockRequests() async {
    await http.delete(
      Uri.parse('$wiremockBaseUrl/__admin/requests'),
    );
  }

  Future<int> loginCallsCount() async {
    final response = await http.post(
      Uri.parse('$wiremockBaseUrl/__admin/requests/count'),
      headers: const {'Content-Type': 'application/json'},
      body: '{"method":"POST","url":"/login"}',
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Falha ao consultar WireMock admin: ${response.statusCode}.');
    }

    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>) {
      throw const FormatException('Resposta invalida do WireMock admin para count.');
    }

    final count = body['count'];
    if (count is! int) {
      throw const FormatException('Campo count ausente na resposta do WireMock admin.');
    }

    return count;
  }

  Future<String?> lastLoginCurl() async {
    final response = await http.post(
      Uri.parse('$wiremockBaseUrl/__admin/requests/find'),
      headers: const {'Content-Type': 'application/json'},
      body: '{"method":"POST","url":"/login"}',
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Falha ao consultar requests do WireMock: ${response.statusCode}.');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Resposta invalida do WireMock admin para find.');
    }

    final requests = decoded['requests'];
    if (requests is! List || requests.isEmpty) {
      return null;
    }

    final last = requests.last;
    if (last is! Map<String, dynamic>) {
      return null;
    }

    final request = last['request'];
    if (request is! Map<String, dynamic>) {
      return null;
    }

    final url = request['url'];
    if (url is! String) {
      return null;
    }

    String body = '';
    final rawBody = request['body'];
    if (rawBody is String) {
      body = rawBody;
    } else {
      final bodyAsBase64 = request['bodyAsBase64'];
      if (bodyAsBase64 is String && bodyAsBase64.isNotEmpty) {
        body = utf8.decode(base64Decode(bodyAsBase64));
      }
    }

    final escapedBody = body.replaceAll("'", "'\"'\"'");
    return "curl -i -X POST '$wiremockBaseUrl$url' -H 'Content-Type: application/json' -d '$escapedBody'";
  }
}

final loginBddContext = LoginBddContext();
