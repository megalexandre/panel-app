import 'package:acal/features/auth/data/auth_service.dart';
import 'package:acal/features/auth/data/auth_storage.dart';
import 'package:acal/features/auth/domain/login_attempt.dart';
import 'package:acal/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key, AuthService? authService})
      : _authService = authService;

  final AuthService? _authService;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final AuthStorage _storage = AuthStorage();
  late final AuthService _authService =
      widget._authService ?? AuthService(_storage);

  bool? _authenticated;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final isAuthenticated = await _authService.isAuthenticated();
    if (!mounted) return;

    setState(() {
      _authenticated = isAuthenticated;
    });
  }

  Future<void> _handleLogin({
    required String email,
    required String password,
  }) async {
    final attempt = LoginAttempt(email: email, password: password);
    final result = await _authService.login(attempt);
    if (!mounted) return;

    if (!result.isSuccess) {
      throw Exception(result.failure?.message ?? 'Falha no login.');
    }

    setState(() {
      _authenticated = true;
    });
  }

  Future<void> _handleLogout() async {
    await _authService.logout();
    if (!mounted) return;

    setState(() {
      _authenticated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_authenticated == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_authenticated!) {
      return _AuthenticatedHome(onLogout: _handleLogout);
    }

    return LoginPage(onLogin: _handleLogin);
  }
}

class _AuthenticatedHome extends StatelessWidget {
  const _AuthenticatedHome({required this.onLogout});

  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Area autenticada')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login realizado com sucesso.',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sua sessao foi restaurada pelo token salvo no dispositivo.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 46,
                    child: OutlinedButton.icon(
                      onPressed: onLogout,
                      icon: const Icon(Icons.logout),
                      label: const Text('Sair'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}