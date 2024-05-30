part of 'order_provider.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;

  OrderLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrderError extends OrderState {
  final String message;

  OrderError({required this.message});

  @override
  List<Object> get props => [message];
}
