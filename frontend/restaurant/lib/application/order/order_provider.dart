import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/order.dart';
import '../../Infrastructure/repositories/order_repository.dart';

part 'order_state.dart';
part 'order_event.dart';
part 'order_notifier.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(baseUrl: 'http://10.0.2.2:5000');
});

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>(
  (ref) => OrderNotifier(orderRepository: ref.watch(orderRepositoryProvider)),
);
