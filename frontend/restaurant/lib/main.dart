import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/Infrastructure/repositories/order_repository.dart';
import 'package:restaurant/presentation/addsubmit.dart';
import 'package:restaurant/presentation/admin/addfood.dart';
import 'package:restaurant/presentation/admin/dashbord.dart';
import 'package:restaurant/presentation/admin/orderlist.dart';
import 'package:restaurant/presentation/bottom_nav.dart';
import 'package:restaurant/presentation/login_page.dart';
import 'package:restaurant/presentation/signup_page.dart';
import './Infrastructure/repositories/auth_repository.dart';
import './Infrastructure/repositories/meal_repository.dart';
import './presentation/selectedorder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _router = GoRouter(initialLocation: "/login", routes: [
  GoRoute(
    name: "signup",
    path: '/signup',
    builder: (context, state) => SignupPage(),
  ),
  GoRoute(
    name: "login",
    path: '/login',
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    name: "entry",
    path: '/entry',
    builder: (context, state) => BottomNav(),
  ),
  GoRoute(
      name: 'selected',
      path: '/selected',
      builder: (context, state) => SelectedOrderPage()),
  GoRoute(
      name: 'submitorder',
      path: '/submitorder',
      builder: (context, state) => SubmitOrderPage()),
  GoRoute(
    name: 'admin',
    path: '/admin',
    builder: (context, state) => AdminHome(title: 'Admin Page'),
  )
]);
void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(239, 108, 0, 1)),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
