part of "order_provider.dart";

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepository orderRepository;

  OrderNotifier({required this.orderRepository}) : super(OrderInitial());

  Future<void> loadOrders() async {
    state = OrderLoading();
    try {
      final orders = await orderRepository.fetchOrders();
      state = OrderLoaded(orders: orders);
    } catch (e) {
      state = OrderError(message: e.toString());
    }
  }

  Future<void> addOrder(Order order) async {
    try {
      await orderRepository.addOrder(order);
      final orders = await orderRepository.fetchOrders();
      state = OrderLoaded(orders: orders);
    } catch (e) {
      state = OrderError(message: e.toString());
    }
  }

  Future<void> updateOrder(Order order) async {
    try {
      await orderRepository.updateOrder(
          id: order.id, completed: order.completed);
      final orders = await orderRepository.fetchOrders();
      state = OrderLoaded(orders: orders);
    } catch (e) {
      state = OrderError(message: e.toString());
    }
  }

  Future<void> deleteOrder(Order order) async {
    try {
      await orderRepository.deleteOrder(id: order.id);
      final orders = await orderRepository.fetchOrders();
      state = OrderLoaded(orders: orders);
    } catch (e) {
      state = OrderError(message: e.toString());
    }
  }
}
