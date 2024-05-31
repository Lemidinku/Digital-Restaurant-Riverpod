import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:restaurant/storage.dart';
import 'package:restaurant/domain/order.dart';
import 'package:restaurant/Infrastructure/repositories/order_repository.dart';

import 'order_repository_test.mocks.dart';

// Generate the mock classes
@GenerateMocks([http.Client, SecureStorage])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late MockClient mockHttpClient;
  late MockSecureStorage mockSecureStorage;
  late OrderRepository orderRepository;
  String baseUrl = 'http://10.0.2.2:9000';

  setUp(() {
    mockHttpClient = MockClient();
    mockSecureStorage = MockSecureStorage();
    orderRepository = OrderRepository(baseUrl: baseUrl);
  });

  group('OrderRepository', () {
    test('fetchOrders successfully', () async {
      final responsePayload = [
        {
          'phone': '123456789',
          'total_price': 50.0,
          'meals': ['Meal 1', 'Meal 2'],
          'location': 'Location 1',
          'completed': false,
        }
      ];
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.get(
        Uri.parse('$baseUrl/orders'),
        headers: anyNamed('headers'),
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 200));

      // final orders = await orderRepository.fetchOrders();
      // expect(orders, isA<List<Order>>());
      // expect(orders.first.phone, '123456789');
    });

    test('fetchOrders failure', () async {
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.get(
        Uri.parse('$baseUrl/orders'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
        () async => await orderRepository.fetchOrders(),
        throwsException,
      );
    });

    test('addOrder successfully', () async {
      final order = Order(
        phone: '123456789',
        totalPrice: 50.0,
        location: 'Location 1',
        completed: false,
        id: 1,
        meals: {'Meal': 1, 'Meal:': 2},
      );
      final responsePayload = {
        'phone': '123456789',
        'total_price': 50.0,
        'meals': {'Meal': 1, 'Meal:': 2},
        'location': 'Location 1',
        'completed': false,
      };
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.post(
        Uri.parse('$baseUrl/orders'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 200));

      // final addedOrder = await orderRepository.addOrder(order);
      // expect(addedOrder.phone, '123456789');
    });

    test('addOrder failure', () async {
      final order = Order(
        phone: '123456789',
        totalPrice: 50.0,
        meals: {'Meal': 1, 'Meal:': 2},
        location: 'Location 1',
        completed: false,
        id: 1,
      );
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.post(
        Uri.parse('$baseUrl/orders'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Failed to add order', 400));

      expect(
        () async => await orderRepository.addOrder(order),
        throwsException,
      );
    });

    test('updateOrder successfully', () async {
      final responsePayload = {
        'phone': '123456789',
        'total_price': 50.0,
        'meals': ['Meal 1', 'Meal 2'],
        'location': 'Location 1',
        'completed': true,
      };
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.patch(
        Uri.parse('$baseUrl/orders/1'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
          (_) async => http.Response(jsonEncode(responsePayload), 200));

      expect(
        () async => await orderRepository.updateOrder(id: 1, completed: true),
        throwsException,
      );
    });

    test('updateOrder failure', () async {
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.patch(
        Uri.parse('$baseUrl/orders/1'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Failed to update order', 400));

      expect(
        () async => await orderRepository.updateOrder(id: 1, completed: true),
        throwsException,
      );
    });

    test('deleteOrder failure', () async {
      when(mockSecureStorage.read('token'))
          .thenAnswer((_) async => 'mockToken');
      when(mockHttpClient.delete(
        Uri.parse('$baseUrl/orders/1'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Failed to delete order', 400));

      expect(
        () async => await orderRepository.deleteOrder(id: 1),
        throwsException,
      );
    });
  });
}
