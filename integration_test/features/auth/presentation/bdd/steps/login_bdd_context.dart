import 'dart:convert';

import 'package:acal/features/auth/data/auth_service.dart';
import 'package:acal/features/auth/data/auth_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginBddContext {
  static const String wiremockBaseUrl = 'http://localhost:8080';

  late AuthService authService = AuthService(
    AuthStorage(),
    baseUrl: wiremockBaseUrl,
  );

  Future<void> reset() async {
    SharedPreferences.setMockInitialValues({});
    await _resetWireMockRequests();
    authService = AuthService(
      AuthStorage(),
      baseUrl: wiremockBaseUrl,
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
}

final loginBddContext = LoginBddContext();
