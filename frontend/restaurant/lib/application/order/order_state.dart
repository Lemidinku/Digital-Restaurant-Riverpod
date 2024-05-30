part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;

  const OrderLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderAdded extends OrderState {
  final Order order;

  const OrderAdded({required this.order});

  @override
  List<Object> get props => [order];
}
