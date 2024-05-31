import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/presentation/admin/addfood.dart';

void main() {
  group('AddFoodPage Widget Tests', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      // Build the AddFoodPage widget
      await tester.pumpWidget(MaterialApp(home: AddFoodPage()));

      // Verify the presence of form fields and buttons
      expect(find.byType(TextFormField), findsNWidgets(5));
      // expect(find.byType(Radio), findsOneWidget);
      // expect(find.byType(ElevatedButton), findsAtLeast(1));
    });
  });
}
