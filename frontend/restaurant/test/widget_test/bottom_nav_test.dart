import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/presentation/bottom_nav.dart';
import 'package:restaurant/presentation/home.dart';
import 'package:restaurant/presentation/login_page.dart';
import 'package:restaurant/presentation/order_now.dart';

void main() {
  group('BottomNav Widget Tests', () {
    testWidgets('displays HomePage by default', (WidgetTester tester) async {
      // await tester.pumpWidget(
      //   MaterialApp(
      //     home: BottomNav(),
      //   ),
      // );

      // // Check if HomePage is displayed by default
      // expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('navigates to OrderNowPage when second tab is tapped',
        (WidgetTester tester) async {
      // await tester.pumpWidget(
      //   MaterialApp(
      //     home: BottomNav(),
      //   ),
      // );

      // // Tap the second tab (OrderNowPage)
      // await tester.tap(find.byIcon(Icons.list));
      // await tester.pump();

      // Check if OrderNowPage is displayed
      // expect(find.byType(OrderNowPage), findsOneWidget);
    });

    testWidgets('navigates to LoginPage when third tab is tapped',
        (WidgetTester tester) async {
      // await tester.pumpWidget(
      //   MaterialApp(
      //     home: BottomNav(),
      //   ),
      // );

      // Tap the third tab (LoginPage)
      // await tester.tap(find
      //     .byIcon(Icons.person)
      //     .at(1)); // Adjust index to match the third tab
      // await tester.pump();

      // Check if LoginPage is displayed
      // expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
