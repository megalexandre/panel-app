import 'package:acal/features/auth/data/auth_service.dart';
import 'package:acal/features/auth/data/auth_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiSpy {
  int calls = 0;

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    calls++;

    if (email == 'alexandre@mail.com' && password == '12345678') {
      return {
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbGV4YW5kcmVAbWFpbC5jb20iLCJpYXQiOjE3MDAwMDAwMDAsImV4cCI6NDEwMDAwMDAwMH0.signature',
        'type': 'Bearer',
      };
    }

    return null;
  }
}

class LoginBddContext {
  AuthApiSpy apiSpy = AuthApiSpy();
  late AuthService authService = AuthService(
    AuthStorage(),
    loginApiCall: apiSpy.login,
  );

  Future<void> reset() async {
    SharedPreferences.setMockInitialValues({});
    apiSpy = AuthApiSpy();
    authService = AuthService(
      AuthStorage(),
      loginApiCall: apiSpy.login,
    );
  }
}

final loginBddContext = LoginBddContext();
