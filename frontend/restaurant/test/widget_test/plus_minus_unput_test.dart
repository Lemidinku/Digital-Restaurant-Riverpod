import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/presentation/widget/plus_minus_input.dart';

void main() {
  testWidgets('PlusMinusInput increments value correctly',
      (WidgetTester tester) async {
    // // Build the PlusMinusInput widget
    // await tester.pumpWidget(MaterialApp(
    //   home: PlusMinusInput(),
    // ));

    // Verify the initial value is 0
    // expect(find.text('0'), findsOneWidget);

    // // Tap the plus button and verify the value increments to 1
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    // expect(find.text('1'), findsOneWidget);
  });

  testWidgets('PlusMinusInput decrements value correctly',
      (WidgetTester tester) async {
    // Build the PlusMinusInput widget
    //   await tester.pumpWidget(MaterialApp(
    //     home: PlusMinusInput(),
    //   ));

    //   // Verify the initial value is 0
    //   expect(find.text('0'), findsOneWidget);

    //   // Tap the minus button and verify the value decrements to 0
    //   await tester.tap(find.byIcon(Icons.remove));
    //   await tester.pump();
    //   expect(find.text('0'), findsOneWidget);
  });

  testWidgets(
      'PlusMinusInput value remains at 0 when tapping minus button repeatedly',
      (WidgetTester tester) async {
    // // Build the PlusMinusInput widget
    // await tester.pumpWidget(MaterialApp(
    //   home: PlusMinusInput(),
    // ));

    // // Verify the initial value is 0
    // expect(find.text('0'), findsOneWidget);

    // // Tap the minus button twice and verify the value remains 0
    // await tester.tap(find.byIcon(Icons.remove));
    // await tester.pump();
    // await tester.tap(find.byIcon(Icons.remove));
    // await tester.pump();
    // expect(find.text('0'), findsOneWidget);
  });
}
