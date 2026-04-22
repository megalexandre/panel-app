// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './../steps/the_login_app_is_running.dart';
import './../steps/i_enter_text_into_text_field.dart';
import './../steps/i_tap_text.dart';
import './../steps/the_authentication_api_should_be_called_time.dart';
import './../steps/i_see_text.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('''Login''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theLoginAppIsRunning(tester);
    }

    testWidgets(
        '''Login with valid credentials should call API {1} time and redirect''',
        (tester) async {
      await bddSetUp(tester);
      await iEnterTextIntoTextField(tester, 'alexandre@mail.com', 0);
      await iEnterTextIntoTextField(tester, '12345678', 1);
      await iTapText(tester, 'Login');
      await theAuthenticationApiShouldBeCalledTime(tester, 1);
      await iSeeText(tester, 'Area autenticada');
    });
    testWidgets(
        '''Login with invalid credentials should call API {0} time and stay on login''',
        (tester) async {
      await bddSetUp(tester);
      await iEnterTextIntoTextField(tester, 'alex-site.com', 0);
      await iEnterTextIntoTextField(tester, '123456', 1);
      await iTapText(tester, 'Login');
      await theAuthenticationApiShouldBeCalledTime(tester, 0);
      await iSeeText(tester, 'Entrar');
    });
  });
}
