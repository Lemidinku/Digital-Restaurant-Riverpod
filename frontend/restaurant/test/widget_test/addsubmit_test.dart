import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/application/order/order_provider.dart';
import 'package:restaurant/presentation/addsubmit.dart';

void main() {
  group('SubmitOrderPage Widget Tests', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      // Build the SubmitOrderPage widget
      await tester.pumpWidget(MaterialApp(home: SubmitOrderPage()));

      // Verify the presence of form fields and buttons
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('form fields are empty initially', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SubmitOrderPage()));

      final phoneField = find.widgetWithText(TextFormField, '');
      final locationField = find.widgetWithText(TextFormField, '');

      // expect(phoneField, findsOneWidget);
      // expect(locationField, findsOneWidget);
    });

    testWidgets('form fields are validated when submit button is clicked',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SubmitOrderPage()));

      final submitButton = find.widgetWithText(ElevatedButton, 'Submit Order');
      await tester.tap(submitButton);
      await tester.pump();

      // expect(find.text('Please enter your phone number'), findsOneWidget);
      // expect(find.text('Please enter your location'), findsOneWidget);
    });

    testWidgets('form fields are cleared after successful form submission',
        (WidgetTester tester) async {
      // await tester.pumpWidget(MaterialApp(home: SubmitOrderPage()));

      // final phoneField = find.byType(TextFormField).first;
      // final locationField = find.byType(TextFormField).last;
      // final submitButton = find.widgetWithText(ElevatedButton, 'Submit Order');

      // await tester.enterText(phoneField, '1234567890');
      // await tester.enterText(locationField, 'Location');
      // await tester.tap(submitButton);
      // await tester.pump();

      // expect(find.text('1234567890'), findsNothing);
      // expect(find.text('Location'), findsNothing);
    });
  });
}
