import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/application/meal/meal_provider.dart'; // Import your meal provider file here
import 'package:restaurant/Infrastructure/repositories/meal_repository.dart';
import 'package:restaurant/domain/meal.dart';
import 'meal_provider_test.mocks.dart'; // Import your meal provider file here

// Use the @GenerateMocks annotation to generate a mock class for MealRepository
@GenerateMocks([MealRepository])
void main() {
  group('Meal Notifier Test', () {
    late MockMealRepository mockRepository;
    late MealNotifier mealNotifier;

    setUp(() {
      mockRepository = MockMealRepository();
      mealNotifier = MealNotifier(mealRepository: mockRepository);
    });

    test('Test loading meals success', () async {
      // Define the response you want from the mock repository
      final mockMeal = Meal(
        id: 1,
        name: 'Test Meal',
        description: 'Test Description',
        price: 10.99,
        imageUrl: 'https://example.com/image.jpg',
        types: ['Test Type'],
        allergy: 'Test Allergy',
        fasting: false,
        origin: 'Test Origin',
      );
      when(mockRepository.fetchMeals()).thenAnswer((_) async => [mockMeal]);

      // Trigger the loadMeals method in the meal notifier
      await mealNotifier.loadMeals();

      // Expect that the state is changed to MealLoaded
      expect(mealNotifier.state, isA<MealLoaded>());
    });

    test('Test loading meals failure', () async {
      // Define the response you want from the mock repository
      when(mockRepository.fetchMeals())
          .thenThrow(Exception('Failed to load meals'));

      // Trigger the loadMeals method in the meal notifier
      await mealNotifier.loadMeals();

      // Expect that the state is changed to MealError
      expect(mealNotifier.state, isA<MealError>());
    });

    test('Test adding meal success', () async {
      final mockMeal = Meal(
        id: 1,
        name: 'Test Meal',
        description: 'Test Description',
        price: 10.99,
        imageUrl: 'https://example.com/image.jpg',
        types: ['Test Type'],
        allergy: 'Test Allergy',
        fasting: false,
        origin: 'Test Origin',
      );
      when(mockRepository.addMeal(any)).thenAnswer((_) async => mockMeal);

      await mealNotifier.addMeal(mockMeal);

      expect(mealNotifier.state, isA<MealAdded>());
    });

    test('Test adding meal failure', () async {
      final mockMeal = Meal(
        id: 1,
        name: 'Test Meal',
        description: 'Test Description',
        price: 10.99,
        imageUrl: 'https://example.com/image.jpg',
        types: ['Test Type'],
        allergy: 'Test Allergy',
        fasting: false,
        origin: 'Test Origin',
      );
      when(mockRepository.addMeal(any))
          .thenThrow(Exception('Failed to add meal'));

      await mealNotifier.addMeal(mockMeal);

      expect(mealNotifier.state, isA<MealError>());
    });

    // Add more test cases as needed
  });

  // Write tests for the MealRepository if needed
}
