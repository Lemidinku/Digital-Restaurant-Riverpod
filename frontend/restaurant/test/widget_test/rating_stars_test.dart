import 'package:flutter/material.dart';
import 'package:restaurant/presentation/widget/rating_stars.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RatingStars Widget Test', () {
    testWidgets('RatingStars should render correctly with default values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RatingStars(),
        ),
      );

      // By default, it should render 5 star icons with a rating of 0
      expect(find.byIcon(Icons.star_border), findsNWidgets(5));
    });

    testWidgets('RatingStars should render correctly with a specific rating',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RatingStars(rating: 3),
        ),
      );

      // It should render 3 filled star icons and 2 border star icons for a rating of 3
      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_border), findsNWidgets(2));
    });

    testWidgets('RatingStars should render correctly with a specific color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RatingStars(color: Colors.red),
        ),
      );

      // It should render star icons with the specified color
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Icon && widget.color == Colors.red),
          findsNWidgets(5));
    });

    testWidgets('RatingStars should render correctly with a specific size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RatingStars(size: 20),
        ),
      );

      // It should render star icons with the specified size
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Icon && widget.size == 20),
          findsNWidgets(5));
    });
  });
}
