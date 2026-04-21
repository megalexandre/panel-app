import 'package:acal/screen/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AcalApp());
}

class AcalApp extends StatelessWidget {
  const AcalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}
