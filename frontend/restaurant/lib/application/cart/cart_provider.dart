import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/Infrastructure/repositories/orderedItems.dart';
import 'package:restaurant/domain/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_notifier.dart';

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
