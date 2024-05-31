import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/order.dart';
import '../../Infrastructure/repositories/order_repository.dart';
import '../../core.dart';

part 'order_state.dart';
part 'order_event.dart';
part 'order_notifier.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(baseUrl: BASE_URL);
});

final orderNotifierProvider = StateNotifierProvider<OrderNotifier, OrderState>(
  (ref) => OrderNotifier(orderRepository: ref.watch(orderRepositoryProvider)),
);
