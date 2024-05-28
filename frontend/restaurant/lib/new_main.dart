import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'application/auth/auth_bloc.dart';
import 'application/meal/meal_bloc.dart';
import './Infrastructure/repositories/auth_repository.dart';
import './Infrastructure/repositories/meal_repository.dart';
import './login_screen.dart';
import '/meals_screen.dart';

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
        title: 'Meal Ordering App',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/home': (context) => MealsScreen(),
        },
      ),
    );
  }
}
