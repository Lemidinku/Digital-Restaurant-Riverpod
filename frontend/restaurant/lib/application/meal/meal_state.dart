part of 'meal_bloc.dart';

abstract class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

abstract class mealActionState extends MealState {}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> meals;

  MealLoaded({required this.meals});

  @override
  List<Object> get props => [meals];
}

class MealError extends MealState {
  final String message;

  MealError({required this.message});

  @override
  List<Object> get props => [message];
}

class MealSelectedButtonActionState extends mealActionState {}

class mealselectedOrderButtonActionState extends mealActionState {}

//
class MealAdded extends MealState {
  final Meal meal;

  MealAdded({required this.meal});

  @override
  List<Object> get props => [meal];
}
