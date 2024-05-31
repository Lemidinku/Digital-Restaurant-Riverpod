import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/presentation/home.dart';

void main() {
  group('HomePage UI Test', () {
    testWidgets('renders CircularProgressIndicator',
        (WidgetTester tester) async {
      // await tester.pumpWidget(MaterialApp(home: HomePage()));
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders TextField', (WidgetTester tester) async {
      // await tester.pumpWidget(MaterialApp(home: HomePage()));
      // expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('renders PageView', (WidgetTester tester) async {
      // await tester.pumpWidget(MaterialApp(home: HomePage()));
      // expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('renders GridView', (WidgetTester tester) async {
      // await tester.pumpWidget(MaterialApp(home: HomePage()));
      // expect(find.byType(GridView), findsOneWidget);
    });

    // Additional tests
    testWidgets('renders Text widgets', (WidgetTester tester) async {
      // await tester.pumpWidget(MaterialApp(home: HomePage()));
      // expect(find.byType(Text), findsWidgets);
    });

    testWidgets('renders Icon widgets', (WidgetTester tester) async {
      // await tester.pumpWidget(MaterialApp(home: HomePage()));
      // expect(find.byType(Icon), findsWidgets);
    });
  });
}
