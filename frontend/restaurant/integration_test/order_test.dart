import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/main.dart' as app;
import 'package:restaurant/Infrastructure/repositories/order_repository.dart';
import 'package:restaurant/domain/order.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('OrderRepository Integration Test', () {
    late OrderRepository orderRepository;
    final baseUrl = 'http://10.0.2.2:5000';

    setUp(() {
      orderRepository = OrderRepository(baseUrl: baseUrl);
    });

    testWidgets('Adding Order', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Create a sample order
      final order = Order(
        id: 0,
        phone: '1234567890',
        totalPrice: 50.0,
        meals: {'Pizza': 2},
        location: '123 Main St',
        completed: false,
      );

      // Add the order
      final addedOrder = await orderRepository.addOrder(order);

      // Verify that the order was added successfully
      expect(addedOrder.id, isNotNull);
      expect(addedOrder.phone, order.phone);
      expect(addedOrder.totalPrice, order.totalPrice);
      expect(addedOrder.meals, order.meals);
      expect(addedOrder.location, order.location);
      expect(addedOrder.completed, order.completed);
    });

    testWidgets('Updating Order', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Create a sample order
      final order = Order(
        id: 1, // Assuming there is an existing order with ID 1
        phone: '1234567890',
        totalPrice: 50.0,
        meals: {'Pizza': 2},
        location: '123 Main St',
        completed: false,
      );

      // Update the order
      final updatedOrder = await orderRepository.updateOrder(
        id: order.id,
        completed: true,
      );

      // Verify that the order was updated successfully
      expect(updatedOrder.id, order.id);
      expect(updatedOrder.completed, true);
    });
  });
}
