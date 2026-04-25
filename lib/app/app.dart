import 'package:acal/app/app_router.dart';
import 'package:acal/app/app_theme.dart';
import 'package:acal/features/auth/data/auth_service.dart';
import 'package:acal/features/auth/data/auth_storage.dart';
import 'package:acal/features/auth/presentation/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AcalApp extends StatefulWidget {
  const AcalApp({super.key});

  @override
  State<AcalApp> createState() => _AcalAppState();
}

class _AcalAppState extends State<AcalApp> {
  late final AuthNotifier _authNotifier;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authNotifier = AuthNotifier(AuthService(AuthStorage()));
    _router = buildRouter(_authNotifier);
    _authNotifier.initialize();
  }

  @override
  void dispose() {
    _authNotifier.dispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AcalTheme.light,
      themeMode: ThemeMode.light,
      routerConfig: _router,
    );
  }
}
