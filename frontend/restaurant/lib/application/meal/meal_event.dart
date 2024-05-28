part of 'meal_bloc.dart';

abstract class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object> get props => [];
}

class LoadMeals extends MealEvent {}

class AddMeal extends MealEvent {
  final Meal meal;

  AddMeal({required this.meal});

  @override
  List<Object> get props => [meal];
}

class UpdateMeal extends MealEvent {
  final Meal meal;

  UpdateMeal({required this.meal});

  @override
  List<Object> get props => [meal];
}

class DeleteMeal extends MealEvent {
  final int mealId;

  DeleteMeal({required this.mealId});

  @override
  List<Object> get props => [mealId];
}
