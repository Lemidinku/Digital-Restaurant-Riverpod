import 'package:flutter/material.dart';
import 'package:restaurant/Infrastructure/repositories/order_repository.dart';
import 'package:restaurant/presentation/bottom_nav.dart';
import 'package:restaurant/presentation/login_page.dart';
import 'package:restaurant/presentation/signup_page.dart';
import './Infrastructure/repositories/auth_repository.dart';
import './Infrastructure/repositories/meal_repository.dart';
import './presentation/selectedorder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(239, 108, 0, 1)),
        useMaterial3: true,
      ),
      home: LoginPage(),
      routes: {
        // '/entry': (context) => BottomNav(),
        // '/selected': (context) => SelectedOrderPage(),
        '/login': (context) => LoginPage(),
        // '/signup': (context) => SignupPage()
      },
    );
  }
}
