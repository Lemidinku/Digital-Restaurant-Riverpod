import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/presentation/detail.dart';
import 'package:restaurant/presentation/widget/rating_stars.dart';
import 'package:restaurant/presentation/selectedorder.dart';
import 'package:restaurant/presentation/widget/order_col_widget.dart';
import 'widget/plus_minus_input.dart';
import 'package:restaurant/application/meal/meal_provider.dart';

class OrderNowPage extends ConsumerStatefulWidget {
  const OrderNowPage({Key? key}) : super(key: key);

  @override
  _OrderNowPage createState() => _OrderNowPage();
}

class _OrderNowPage extends ConsumerState<OrderNowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mealNotifierProvider.notifier).loadMeals();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<MealState>(mealNotifierProvider, (previous, next) {
      if (next is MealError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    final state = ref.watch(mealNotifierProvider);

    Widget body;
    if (state is MealInitial) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state is MealLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state is MealLoaded) {
      body = Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35,
              color: const Color(0xFFF97350),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Starter",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Breakfast",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Lunch",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Dinner",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Desserts",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SelectedOrderPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 3,
                      minimumSize: const Size(150, 37),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Selected Order',
                      style: TextStyle(color: Color(0xFFF97350)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: state.meals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                  crossAxisSpacing: 8.0, // Spacing between columns
                  childAspectRatio: 0.7, // Aspect ratio of each item
                ),
                itemBuilder: (context, index) {
                  return OrderTail(
                    orders: state.meals[index],
                  );
                },
              ),
            )
          ],
        ),
      );
    } else if (state is MealError) {
      body = Center(child: Text('Error: ${state.message}'));
    } else {
      body = const Center(child: Text('Unknown state'));
    }

    return body;
  }
}
