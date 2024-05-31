part of 'cart_provider.dart';

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartInitial());

  Future<void> cartInitalEvent(CartInitalEvent event) async {
    state = CartLoaddingState();
    await Future.delayed(Duration(seconds: 1));
    state = CartSuccessState(orders: orderedItems);
  }

  void cartRemoveEvent(CartRemoveEvent event) {
    orderedItems.remove(event.removedMeals);
    state = CartSuccessState(orders: orderedItems);
  }
}
