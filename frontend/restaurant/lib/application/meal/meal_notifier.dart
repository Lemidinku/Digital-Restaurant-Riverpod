part of "meal_provider.dart";

class MealNotifier extends StateNotifier<MealState> {
  final MealRepository mealRepository;

  MealNotifier({required this.mealRepository}) : super(MealInitial());

  Future<void> loadMeals() async {
    state = MealLoading();
    try {
      final meals = await mealRepository.fetchMeals();
      print(meals);
      state = MealLoaded(meals: meals);
    } catch (e) {
      print("in the meal_notifier");
      print(e.toString());
      state = MealError(message: e.toString());
    }
  }

  Future<void> addMeal(Meal meal) async {
    state = MealLoading();
    try {
      final addedMeal = await mealRepository.addMeal(meal);
      state = MealAdded(meal: addedMeal);
    } catch (e) {
      state = MealError(message: e.toString());
    }
  }

  Future<void> orderSelectedButtonEvent(OrderSelectedButtonEvent event) async {
    orderedItems[event.clickedMeals] = event.quantity;
  }

  Future<void> orderSelectedOrderButtonEvent(
      OrderSelectedOrderButtonEvent event) async {}

  Future<void> deleteMeal(String id) async {
    state = MealLoading();
    try {
      await mealRepository.deleteMeal(id);
      final meals = await mealRepository.fetchMeals();
      state = MealLoaded(meals: meals);
    } catch (e) {
      state = MealError(message: e.toString());
    }
  }

  Future<void> updateMeal(
      {required String id, required Map<String, dynamic> updates}) async {
    state = MealLoading();
    try {
      await mealRepository.updateMeal(id, updates);
      final meals = await mealRepository.fetchMeals();
      state = MealLoaded(meals: meals);
    } catch (e) {
      state = MealError(message: e.toString());
    }
  }
}
