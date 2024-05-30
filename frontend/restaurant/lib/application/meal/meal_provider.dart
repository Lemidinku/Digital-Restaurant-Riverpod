// Define a provider for the AuthRepository
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/meal.dart';
import '../../Infrastructure/repositories/meal_repository.dart';
import '../../Infrastructure/repositories/orderedItems.dart';
part 'meal_event.dart';
part 'meal_state.dart';
part 'meal_notifier.dart';

final mealRepositoryProvider = Provider<MealRepository>((ref) {
  return MealRepository(baseUrl: 'http://10.0.2.2:5000');
});

// Define a provider for the AuthNotifier
final mealNotifierProvider =
    StateNotifierProvider<MealNotifier, MealState>((ref) {
  final mealRepository = ref.watch(mealRepositoryProvider);
  return MealNotifier(mealRepository: mealRepository);
});







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
