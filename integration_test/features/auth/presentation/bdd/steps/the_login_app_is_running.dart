import 'package:acal/features/auth/presentation/pages/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'login_bdd_context.dart';

Future<void> theLoginAppIsRunning(WidgetTester tester) async {
  await loginBddContext.reset();

  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    MaterialApp(
      home: AuthGate(authService: loginBddContext.authService),
    ),
  );

  await tester.pumpAndSettle();
}
