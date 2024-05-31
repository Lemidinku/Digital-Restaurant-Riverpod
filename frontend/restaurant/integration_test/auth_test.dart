import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Tests', () {
    testWidgets('Login Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find login form fields
      final emailField = find.byKey(Key('login_email_field'));
      final passwordField = find.byKey(Key('login_password_field'));
      final loginButton = find.byKey(Key('login_button'));

      // Enter login credentials
      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');

      // Tap the login button
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify successful login by checking for a widget that appears on the home page
      expect(find.text('Welcome'), findsOneWidget);
    });

    testWidgets('Signup Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the signup page
      final signupButton = find.byKey(Key('navigate_to_signup_button'));
      await tester.tap(signupButton);
      await tester.pumpAndSettle();

      // Find signup form fields
      final emailField = find.byKey(Key('signup_email_field'));
      final passwordField = find.byKey(Key('signup_password_field'));
      final signupButtonConfirm = find.byKey(Key('signup_button'));

      // Enter signup details
      await tester.enterText(emailField, 'newuser@example.com');
      await tester.enterText(passwordField, 'password123');

      // Tap the signup button
      await tester.tap(signupButtonConfirm);
      await tester.pumpAndSettle();

      // Verify successful signup by checking for a widget that appears on the home page
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
