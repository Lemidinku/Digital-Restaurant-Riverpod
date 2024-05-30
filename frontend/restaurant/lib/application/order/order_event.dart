part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrderEvent {}

class AddOrder extends OrderEvent {
  final Order order;

  const AddOrder({required this.order});

  @override
  List<Object> get props => [order];
}

class UpdateOrder extends OrderEvent {
  final Order order;

  const UpdateOrder({required this.order});

  @override
  List<Object> get props => [order];
}

class DeleteOrder extends OrderEvent {
  final Order order;

  const DeleteOrder({required this.order});

  @override
  List<Object> get props => [order];
}
