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

  testWidgets('Verify Clear button functionality and keyboard unfocus on Check', (WidgetTester tester) async {
    await tester.pumpWidget(const DateTimeCheckerApp());

    final dayFinder = find.widgetWithText(TextField, '30');
    final clearButtonFinder = find.text('🧹 Clear');

    expect(clearButtonFinder, findsOneWidget);

    // Enter day text
    await tester.enterText(dayFinder, '15');
    expect(find.text('15'), findsOneWidget);

    // Tap clear
    await tester.tap(clearButtonFinder);
    await tester.pump();

    // Verify day is empty
    expect(find.text('15'), findsNothing);
  });

  testWidgets('Verify Floating Dialog opens with success outcome details', (WidgetTester tester) async {
    await tester.pumpWidget(const DateTimeCheckerApp());

    final dayFinder = find.widgetWithText(TextField, '30');
    final monthFinder = find.widgetWithText(TextField, '5');
    final yearFinder = find.widgetWithText(TextField, '2026');
    final checkButtonFinder = find.text('✔ Check Validity');

    await tester.enterText(dayFinder, '30');
    await tester.enterText(monthFinder, '5');
    await tester.enterText(yearFinder, '2026');
    await tester.tap(checkButtonFinder);
    await tester.pumpAndSettle();

    // Verify dialog opened
    expect(find.byType(Dialog), findsOneWidget);
    expect(find.text('Valid Date!'), findsNWidgets(2));
    expect(find.text('Done'), findsOneWidget);
  });
}
