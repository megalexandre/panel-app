import 'dart:async';

import 'package:acal/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpLoginPage(
    WidgetTester tester, {
    required Future<void> Function({
      required String email,
      required String password,
    }) onLogin,
  }) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(onLogin: onLogin),
      ),
    );
  }

  group('LoginPage', () {
    testWidgets('renderiza os campos principais do formulario', (
      tester,
    ) async {
      await pumpLoginPage(tester, onLogin: ({required email, required password}) async {});

      expect(find.text('Entrar'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'E-mail'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Senha'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    testWidgets('valida campos obrigatorios antes de enviar', (tester) async {
      var loginCalls = 0;

      await pumpLoginPage(
        tester,
        onLogin: ({required email, required password}) async {
          loginCalls++;
        },
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();

      expect(loginCalls, 0);
      expect(find.text('Informe seu e-mail'), findsOneWidget);
      expect(find.text('Informe sua senha'), findsOneWidget);
      expect(find.text('Preencha os campos para continuar.'), findsOneWidget);
    });

    testWidgets('envia email tratado e senha quando formulario e valido', (
      tester,
    ) async {
      String? submittedEmail;
      String? submittedPassword;

      await pumpLoginPage(
        tester,
        onLogin: ({required email, required password}) async {
          submittedEmail = email;
          submittedPassword = password;
        },
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'E-mail'),
        '  alex@site.com  ',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Senha'),
        '123456',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(submittedEmail, 'alex@site.com');
      expect(submittedPassword, '123456');
      expect(find.text('Login realizado com sucesso.'), findsOneWidget);
    });

    testWidgets('mostra loading durante o envio e falha quando login lanca erro', (
      tester,
    ) async {
      final completer = Completer<void>();

      await pumpLoginPage(
        tester,
        onLogin: ({required email, required password}) async {
          await completer.future;
        },
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'E-mail'),
        'alex@site.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Senha'),
        '123456',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      completer.completeError(Exception('falha'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Falha no login. Verifique os dados.'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
