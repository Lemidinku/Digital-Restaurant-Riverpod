import 'package:flutter/material.dart';
import 'package:restaurant/presentation/bottom_nav.dart';
import 'package:restaurant/presentation/welcome-screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'application/auth/auth_bloc.dart';
import 'application/meal/meal_bloc.dart';
import './Infrastructure/repositories/auth_repository.dart';
import './Infrastructure/repositories/meal_repository.dart';

void main() {
  final AuthRepository authRepository =
      AuthRepository(baseUrl: 'http://10.0.2.2:5000');
  final MealRepository mealRepository =
      MealRepository(baseUrl: 'http://10.0.2.2:5000');

  runApp(MyApp(
    authRepository: authRepository,
    mealRepository: mealRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final MealRepository mealRepository;

  MyApp({required this.authRepository, required this.mealRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: authRepository,
          ),
        ),
        BlocProvider(
          create: (context) =>
              MealBloc(mealRepository: mealRepository)..add(LoadMeals()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(239, 108, 0, 1)),
          useMaterial3: true,
        ),
        home: BottomNav(),
        routes: {'/entry': (context) => BottomNav()},
      ),
    );
  }
}
