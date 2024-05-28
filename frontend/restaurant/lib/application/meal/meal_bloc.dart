import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
  }
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

