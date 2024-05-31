import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/presentation/widget/rating_stars.dart';
import 'package:restaurant/presentation/widget/built_item_card.dart';

void main() {
  group('FlashOfferCard Widget Test', () {
    testWidgets('FlashOfferCard should render correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlashOfferCard(
            title: 'Test Title',
            description: 'Test Description',
            imagePath: 'assets/img1.jpg',
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('Order >'), findsOneWidget);
    });

    // Additional test cases can be added to test behavior like tapping on the button
  });

  group('FoodItemCard Widget Test', () {
    testWidgets('FoodItemCard should render correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FoodItemCard(
            title: 'Test Title',
            imagePath: 'assets/img1.jpg',
            rating: '3',
            kind: 'Test Kind',
            type: 'Test Type',
            origin: 'Test Origin',
            price: '\$10',
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('\$10'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    // Additional test cases can be added to test behavior like tapping on the button
  });
}
