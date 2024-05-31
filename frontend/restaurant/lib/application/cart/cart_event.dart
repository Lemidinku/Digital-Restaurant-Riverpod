part of 'cart_provider.dart';

@immutable
sealed class CartEvent {}

class CartInitalEvent extends CartEvent {}

class CartRemoveEvent extends CartEvent {
  final Meal removedMeals;
  CartRemoveEvent({
    required this.removedMeals,
  });
}
