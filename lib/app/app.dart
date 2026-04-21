import 'package:acal/features/auth/presentation/pages/auth_gate.dart';
import 'package:flutter/material.dart';

class AcalApp extends StatelessWidget {
  const AcalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),
    );
  }
}
