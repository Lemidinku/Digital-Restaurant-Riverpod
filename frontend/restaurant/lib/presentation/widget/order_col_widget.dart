import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/meal.dart';
import '../../application/meal/meal_provider.dart';
import 'package:restaurant/presentation/detail.dart';
import 'package:restaurant/presentation/widget/plus_minus_input.dart';
import 'package:restaurant/presentation/widget/rating_stars.dart';
import 'package:restaurant/application/cart/cart_provider.dart';

class OrderTail extends ConsumerStatefulWidget {
  final Meal orders;

  const OrderTail({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  _OrderTailState createState() => _OrderTailState();
}

class _OrderTailState extends ConsumerState<OrderTail> {
  int _quantity = 0;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color.fromARGB(255, 234, 228, 228),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: SizedBox(
              height: 80,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                        bottom: Radius.circular(15),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoodDetailPage(
                              imagePath: 'assets/Pizza.jpg',
                              price: widget.orders.price.toString(),
                              origin: widget.orders.origin,
                              rating: '3',
                              type: widget.orders.types[0],
                              title: widget.orders.name,
                              kind: widget.orders.allergy,
                            ),
                          ));
                        },
                        child: Image.asset(
                          'assets/Pizza.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.orders.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.orders.price.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const RatingStars(
                  rating: 3,
                  size: 15.0,
                ),
                PlusMinusInput(
                  quantity: _quantity,
                  increment: _increment,
                  decrement: _decrement,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      final mealNotifier =
                          ref.read(mealNotifierProvider.notifier);
                      mealNotifier.orderSelectedButtonEvent(
                        OrderSelectedButtonEvent(
                            clickedMeals: widget.orders, quantity: _quantity),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97350),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(221, 37),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text('Select Order'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
