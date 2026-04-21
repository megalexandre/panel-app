import 'package:flutter_test/flutter_test.dart';

import 'login_bdd_context.dart';

Future<void> theAuthenticationApiShouldNotBeCalled(WidgetTester tester) async {
  expect(loginBddContext.apiSpy.calls, 0);
}