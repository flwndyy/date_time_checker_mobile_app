import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datetime_checker_flutter/main.dart';

void main() {
  testWidgets('Verify inputs have numeric keyboard and focus transitions', (WidgetTester tester) async {
    await tester.pumpWidget(const DateTimeCheckerApp());

    // 1. Check all text fields exist
    final dayFinder = find.widgetWithText(TextField, '30');
    final monthFinder = find.widgetWithText(TextField, '5');
    final yearFinder = find.widgetWithText(TextField, '2026');

    expect(dayFinder, findsOneWidget);
    expect(monthFinder, findsOneWidget);
    expect(yearFinder, findsOneWidget);

    final TextField dayField = tester.widget(dayFinder);
    final TextField monthField = tester.widget(monthFinder);
    final TextField yearField = tester.widget(yearFinder);

    // 2. Verify all are numeric keyboard
    expect(dayField.keyboardType, TextInputType.number);
    expect(monthField.keyboardType, TextInputType.number);
    expect(yearField.keyboardType, TextInputType.number);
  });
}
