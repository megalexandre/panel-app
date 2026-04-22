// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../steps/the_login_app_is_running.dart';
import '../steps/i_tap_text.dart';
import '../steps/the_authentication_api_should_be_called_time.dart';
import '../steps/i_see_text.dart';
import '../steps/i_enter_text_into_text_field.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('''Login Failed And Validation''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theLoginAppIsRunning(tester);
    }

    testWidgets('''Submit with empty fields should fail''', (tester) async {
      await bddSetUp(tester);
      await iTapText(tester, 'Login');
      await theAuthenticationApiShouldBeCalledTime(tester, 0);
      await iSeeText(tester, 'Informe seu e-mail');
      await iSeeText(tester, 'Informe sua senha');
      await iSeeText(tester, 'Preencha os campos para continuar.');
    });
    testWidgets('''Outline: Invalid email format should fail (alex)''',
        (tester) async {
      await bddSetUp(tester);
      await iEnterTextIntoTextField(tester, 'alex', 0);
      await iEnterTextIntoTextField(tester, '12345678', 1);
      await iTapText(tester, 'Login');
      await theAuthenticationApiShouldBeCalledTime(tester, 0);
      await iSeeText(tester, 'Informe um e-mail valido');
    });
    testWidgets('''Outline: Invalid email format should fail (alex@)''',
        (tester) async {
      await bddSetUp(tester);
      await iEnterTextIntoTextField(tester, 'alex@', 0);
      await iEnterTextIntoTextField(tester, '12345678', 1);
      await iTapText(tester, 'Login');
      await theAuthenticationApiShouldBeCalledTime(tester, 0);
      await iSeeText(tester, 'Informe um e-mail valido');
    });
    testWidgets('''Outline: Invalid email format should fail (alex@site)''',
        (tester) async {
      await bddSetUp(tester);
      await iEnterTextIntoTextField(tester, 'alex@site', 0);
      await iEnterTextIntoTextField(tester, '12345678', 1);
      await iTapText(tester, 'Login');
      await theAuthenticationApiShouldBeCalledTime(tester, 0);
      await iSeeText(tester, 'Informe um e-mail valido');
    });
    testWidgets('''Outline: Invalid email format should fail (@mail.com)''',
        (tester) async {
      await bddSetUp(tester);
      await iEnterTextIntoTextField(tester, '@mail.com', 0);
      await iEnterTextIntoTextField(tester, '12345678', 1);
      await iTapText(tester, 'Login');
      await theAuthenticationApiShouldBeCalledTime(tester, 0);
      await iSeeText(tester, 'Informe um e-mail valido');
    });
  });
}
