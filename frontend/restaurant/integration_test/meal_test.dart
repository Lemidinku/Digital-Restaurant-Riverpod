import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Meal Tests', () {
    testWidgets('Add Meal Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the add meal page or any relevant screen
      final addMealButton = find.byKey(Key('navigate_to_add_meal_button'));
      await tester.tap(addMealButton);
      await tester.pumpAndSettle();

      // Find meal input fields
      final nameField = find.byKey(Key('meal_name_field'));
      final descriptionField = find.byKey(Key('meal_description_field'));
      final priceField = find.byKey(Key('meal_price_field'));
      final addButton = find.byKey(Key('add_meal_button'));

      // Enter meal details
      await tester.enterText(nameField, 'New Meal');
      await tester.enterText(descriptionField, 'Description of the new meal');
      await tester.enterText(priceField, '15.0');

      // Tap the add button
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Verify successful addition by checking for a widget that appears on the home page
      expect(find.text('New Meal'), findsOneWidget);
    });

    testWidgets('Delete Meal Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find the meal to delete, for example, by scrolling through a list
      final mealToDelete = find.text('Meal to Delete');
      await tester.ensureVisible(mealToDelete);

      // Find and tap the delete button for the meal
      final deleteButton = find.byKey(Key('delete_meal_button'));
      await tester.tap(deleteButton);
      await tester.pumpAndSettle();

      // Verify successful deletion by checking if the meal is no longer present
      expect(find.text('Meal to Delete'), findsNothing);
    });

    // Add more tests for other meal functionalities as needed
  });
}
