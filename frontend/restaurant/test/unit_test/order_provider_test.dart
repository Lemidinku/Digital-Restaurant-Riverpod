import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/domain/order.dart';
import 'package:restaurant/Infrastructure/repositories/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:restaurant/domain/order.dart';
import 'package:restaurant/storage.dart';
import 'package:restaurant/application/order/order_provider.dart';
import 'package:restaurant/Infrastructure/repositories/order_repository.dart';

// Import generated mocks
import 'order_provider_test.mocks.dart';

// This is the annotation for generating mocks
@GenerateMocks([http.Client])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter binding

  group('Order Provider Tests', () {
    late MockClient mockClient;
    late OrderRepository orderRepository;

    setUp(() {
      mockClient = MockClient();
      orderRepository = OrderRepository(baseUrl: 'http://test-url.com');
    });

    test('fetchOrders Success Test', () async {
      // Arrange
    });

    test('fetchOrders Failure Test', () async {
      // Arrange
      when(mockClient.get(Uri.parse('http://test-url.com/orders'),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      // Act & Assert
      expect(() async => await orderRepository.fetchOrders(), throwsException);
    });

    // Similarly, you can write tests for other repository methods like addOrder, updateOrder, deleteOrder

    test('addOrder Success Test', () async {
      // Arrange
    });

    test('updateOrder Success Test', () async {
      // Test implementation
    });

    test('deleteOrder Success Test', () async {
      // Test implementation
    });
  });
}
