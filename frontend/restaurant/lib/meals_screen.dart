import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/meal/meal_bloc.dart';

class MealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meals')),
      body: BlocBuilder<MealBloc, MealState>(
        builder: (context, state) {
          if (state is MealLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MealLoaded) {
            return ListView.builder(
              itemCount: state.meals.length,
              itemBuilder: (context, index) {
                final meal = state.meals[index];
                return ListTile(
                  title: Text(meal.name),
                  subtitle: Text(meal.description),
                  trailing: Text('\$${meal.price.toStringAsFixed(2)}'),
                );
              },
            );
          } else if (state is MealError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No meals available'));
          }
        },
      ),
    );
  }
}
