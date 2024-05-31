import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/meal.dart';
import '../../Infrastructure/repositories/meal_repository.dart';
import '../../Infrastructure/repositories/orderedItems.dart';
import '../../core.dart';
part 'meal_event.dart';
part 'meal_state.dart';
part 'meal_notifier.dart';

final mealRepositoryProvider = Provider<MealRepository>((ref) {
  return MealRepository(baseUrl: BASE_URL);
});

final mealNotifierProvider =
    StateNotifierProvider<MealNotifier, MealState>((ref) {
  final mealRepository = ref.watch(mealRepositoryProvider);
  return MealNotifier(mealRepository: mealRepository);
});
