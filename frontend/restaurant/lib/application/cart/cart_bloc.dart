import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/Infrastructure/repositories/orderedItems.dart';
import 'package:restaurant/application/meal/meal_bloc.dart';
import 'package:restaurant/domain/meal.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitalEvent>(cartInitalEvent);
    on<CartRemoveEvent>(cartRemoveEvent);
  }

  FutureOr<void> cartInitalEvent(
      CartInitalEvent event, Emitter<CartState> emit) async {
    emit(CartLoaddingState());
    await Future.delayed(Duration(seconds: 1));
    emit(CartSuccessState(orders: orderedItems));
  }

  FutureOr<void> cartRemoveEvent(
      CartRemoveEvent event, Emitter<CartState> emit) {
    orderedItems.remove(event.removedMeals);
    emit(CartSuccessState(orders: orderedItems));
  }
}
