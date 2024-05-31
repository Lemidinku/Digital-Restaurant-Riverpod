import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/storage.dart';
import 'package:restaurant/domain/meal.dart';
import 'package:restaurant/Infrastructure/repositories/meal_repository.dart';

import 'meal_repository_test.mocks.dart';

// Generate the mock classes
@GenerateMocks([http.Client, SecureStorage])
void main() {
  late MockClient mockHttpClient;
  late MockSecureStorage mockSecureStorage;
  late MealRepository mealRepository;
  String baseUrl = 'http://10.0.2.2:9000';

  setUp(() {
    mockHttpClient = MockClient();
    mockSecureStorage = MockSecureStorage();
    mealRepository = MealRepository(baseUrl: baseUrl);
  });

  group('MealRepository', () {
    test('fetchMeals successfully', () async {
      final responsePayload = [
        {
          'name': 'Meal 1',
          'description': 'Delicious meal 1',
          'price': 10.0,
          'imageUrl': 'http://example.com/meal1.png',
          'types': ['type1'],
          'allergy': 'None',
          'fasting': false,
          'origin': 'Origin 1'
        }
      ];
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.get(
        Uri.parse('$baseUrl/meals'),
        headers: anyNamed('headers'),
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 200));

      // expect(
      //   () async => await mealRepository.fetchMeals(),
      //   returnsNormally,
      // );
    });

    test('fetchMeals failure', () async {
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.get(
        Uri.parse('$baseUrl/meals'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      // expect(
      //   () async => await mealRepository.fetchMeals(),
      //   throwsException,
      // );
    });

    test('addMeal successfully', () async {
      final meal = Meal(
          id: 1,
          name: 'Meal 1',
          description: 'Delicious meal 1',
          price: 10.0,
          imageUrl: 'http://example.com/meal1.png',
          types: ['type1'],
          allergy: 'None',
          fasting: false,
          origin: 'Origin 1');
      final responsePayload = {
        'name': 'Meal 1',
        'description': 'Delicious meal 1',
        'price': 10.0,
        'imageUrl': 'http://example.com/meal1.png',
        'types': ['type1'],
        'allergy': 'None',
        'fasting': false,
        'origin': 'Origin 1'
      };
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.post(
        Uri.parse('$baseUrl/meals'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 200));

      // expect(
      //   () async => await mealRepository.addMeal(meal),
      //   returnsNormally,
      // );
    });

    test('addMeal failure', () async {
      final meal = Meal(
          name: 'Meal 1',
          description: 'Delicious meal 1',
          price: 10.0,
          imageUrl: 'http://example.com/meal1.png',
          types: ['type1'],
          allergy: 'None',
          fasting: false,
          origin: 'Origin 1',
          id: 1);
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.post(
        Uri.parse('$baseUrl/meals'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Failed to add meal', 400));

      // expect(
      //   () async => await mealRepository.addMeal(meal),
      //   throwsException,
      // );
    });

    test('updateMeal successfully', () async {
      final updates = {
        'name': 'Updated Meal',
        'description': 'Updated description',
        'price': '15.0',
        'imageUrl': 'http://example.com/updated_meal.png',
      };
      final responsePayload = {
        'name': 'Updated Meal',
        'description': 'Updated description',
        'price': 15.0,
        'imageUrl': 'http://example.com/updated_meal.png',
        'types': ['type1'],
        'allergy': 'None',
        'fasting': false,
        'origin': 'Origin 1'
      };
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.put(
        Uri.parse('$baseUrl/meals/1'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 200));

      // expect(
      //   () async => await mealRepository.updateMeal('1', updates),
      //   returnsNormally,
      // );
    });

    test('updateMeal failure', () async {
      final updates = {
        'name': 'Updated Meal',
        'description': 'Updated description',
        'price': '15.0',
        'imageUrl': 'http://example.com/updated_meal.png',
      };
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.put(
        Uri.parse('$baseUrl/meals/1'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Failed to update meal', 400));

      // expect(
      //   () async => await mealRepository.updateMeal('1', updates),
      //   throwsException,
      // );
    });

    test('deleteMeal successfully', () async {
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.delete(
        Uri.parse('$baseUrl/meals/1'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('', 200));

      // expect(
      //   () async => await mealRepository.deleteMeal('1'),
      //   returnsNormally,
      // );
    });

    test('deleteMeal failure', () async {
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.delete(
        Uri.parse('$baseUrl/meals/1'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Failed to delete meal', 400));

      // expect(
      //   () async => await mealRepository.deleteMeal('1'),
      //   throwsException,
      // );
    });
  });
}
