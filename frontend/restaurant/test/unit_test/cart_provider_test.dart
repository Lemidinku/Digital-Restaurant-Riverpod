// cart_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/Infrastructure/repositories/orderedItems.dart';
import 'package:restaurant/application/cart/cart_provider.dart';
import 'package:restaurant/domain/meal.dart';
import 'package:restaurant/application/cart/cart_provider.dart';

// Import the mockito annotations
import 'package:mockito/annotations.dart';

// Import the file containing the MealRepository class
import 'package:restaurant/Infrastructure/repositories/meal_repository.dart';

import 'cart_provider_test.mocks.dart';

// Generate the mock for MealRepository
@GenerateMocks([MealRepository])
void main() {
  group('CartProvider Tests', () {
    late CartNotifier cartNotifier;
    late MockMealRepository mockMealRepository;

    setUp(() {
      mockMealRepository = MockMealRepository();
      cartNotifier = CartNotifier();
    });

    test('Initial Cart Event', () async {
      when(mockMealRepository.fetchMeals()).thenAnswer((_) => Future.value([
            Meal(
                id: 1,
                name: 'Mock Meal',
                description: '',
                price: 0.0,
                imageUrl: '',
                types: [],
                allergy: '',
                fasting: false,
                origin: '')
          ]));

      await cartNotifier.cartInitalEvent(CartInitalEvent());

      expect(cartNotifier.state, isA<CartSuccessState>());
      expect((cartNotifier.state as CartSuccessState).orders, isEmpty);
    });
  });
}
