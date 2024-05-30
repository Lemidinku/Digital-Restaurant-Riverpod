import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant/Infrastructure/repositories/orderedItems.dart';
import "../../domain/meal.dart";
import '../../Infrastructure/repositories/meal_repository.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository mealRepository;

  MealBloc({required this.mealRepository}) : super(MealInitial()) {
    on<LoadMeals>((event, emit) async {
      emit(MealLoading());
      try {
        final meals = await mealRepository.fetchMeals();
        print(meals);
        emit(MealLoaded(meals: meals));
      } catch (e) {
        print("in the meal_bloc");
        print(e.toString());
        emit(MealError(message: e.toString()));
      }
    });
    on<AddMeal>((event, emit) async {
      emit(MealLoading());
      try {
        final meal = await mealRepository.addMeal(event.meal);
        emit(MealAdded(meal: meal));
      } catch (e) {
        emit(MealError(message: e.toString()));
      }
    });
    on<OrderSelectedButtonEvent>(orderSelectedButtonEvent);
    on<OrderSelectedOrderButtonEvent>(orderSelectedOrderButtonEvent);
  }

  FutureOr<void> orderSelectedButtonEvent(
      OrderSelectedButtonEvent event, Emitter<MealState> emit) {
    print('item selected');
    orderedItems[event.clickedMeals] = event.quantity;

    emit(MealSelectedButtonActionState());
  }

  FutureOr<void> orderSelectedOrderButtonEvent(
      OrderSelectedOrderButtonEvent event, Emitter<MealState> emit) {}
}


 







  // MealBloc({required this.mealRepository}) : super(MealInitial());

  // @override
  // Stream<MealState> mapEventToState(MealEvent event) async* {
  //   if (event is LoadMeals) {
  //     yield MealLoading();
  //     try {
  //       final meals = await mealRepository.fetchMeals();
  //       yield MealLoaded(meals: meals);
  //     } catch (e) {
  //       yield MealError(message: e.toString());
  //     }
  //   } else if (event is AddMeal) {
  //     // Handle AddMeal event
  //   } else if (event is UpdateMeal) {
  //     // Handle UpdateMeal event
  //   } else if (event is DeleteMeal) {
  //     // Handle DeleteMeal event
  //   }
  // }
