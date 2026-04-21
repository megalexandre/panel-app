import 'package:flutter_test/flutter_test.dart';

import 'login_bdd_context.dart';

Future<void> theAuthenticationApiShouldBeCalledTime(
  WidgetTester tester,
  num expectedCalls,
) async {
  expect(loginBddContext.apiSpy.calls, expectedCalls.toInt());
}
