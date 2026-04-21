import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter {'123456'} text into {1} text field
Future<void> iEnterTextIntoTextField(
  WidgetTester tester,
  String text,
  num fieldIndex,
) async {
  await tester.enterText(
    find.byType(TextFormField).at(fieldIndex.toInt()),
    text,
  );
  await tester.pump();
}
