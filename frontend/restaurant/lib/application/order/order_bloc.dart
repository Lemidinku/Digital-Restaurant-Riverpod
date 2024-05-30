import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/order.dart';
import '../../Infrastructure/repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<LoadOrders>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await orderRepository.fetchOrders();
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });

    on<AddOrder>((event, emit) async {
      try {
        await orderRepository.addOrder(event.order);
        final orders = await orderRepository.fetchOrders();
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });

    on<UpdateOrder>((event, emit) async {
      try {
        await orderRepository.updateOrder(
            id: event.order.id, completed: event.order.completed);
        final orders = await orderRepository.fetchOrders();
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });

    on<DeleteOrder>((event, emit) async {
      try {
        await orderRepository.deleteOrder(id: event.order.id);
        final orders = await orderRepository.fetchOrders();
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });
  }
}
