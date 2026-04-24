import 'package:acal/app/app_theme.dart';
import 'package:acal/features/auth/presentation/pages/auth_gate.dart';
import 'package:flutter/material.dart';

class AcalApp extends StatelessWidget {
  const AcalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AcalTheme.light,
      darkTheme: AcalTheme.dark,
      themeMode: ThemeMode.system,
      home: const AuthGate(),
    );
  }
}
