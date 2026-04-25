import 'package:acal/features/auth/data/auth_service.dart';
import 'package:acal/features/auth/domain/login_attempt.dart';
import 'package:flutter/foundation.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._service);

  final AuthService _service;

  bool? _authenticated;
  String? _userEmail;

  bool? get authenticated => _authenticated;
  String? get userEmail => _userEmail;

  Future<void> initialize() async {
    final isAuth = await _service.isAuthenticated();
    final email = isAuth ? await _service.currentUserEmail() : null;
    _authenticated = isAuth;
    _userEmail = email;
    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    final attempt = LoginAttempt(email: email, password: password);
    final result = await _service.login(attempt);
    if (!result.isSuccess) {
      throw Exception(result.failure?.message ?? 'Falha no login.');
    }
    _userEmail = await _service.currentUserEmail();
    _authenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await _service.logout();
    _authenticated = false;
    _userEmail = null;
    notifyListeners();
  }
}
