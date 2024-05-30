import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/application/meal/meal_bloc.dart';
import 'package:restaurant/presentation/detail.dart';
import 'package:restaurant/presentation/widget/rating_stars.dart';
import 'package:restaurant/presentation/selectedorder.dart';
import 'package:restaurant/presentation/widget/order_col_widget.dart';
import 'widget/plus_minus_input.dart';

class OrderNowPage extends StatefulWidget {
  const OrderNowPage({super.key});

  @override
  State<OrderNowPage> createState() => _ResturantOrderPage();
}

class _ResturantOrderPage extends State<OrderNowPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealBloc, MealState>(
      listenWhen: (previous, current) => current is mealActionState,
      buildWhen: (previous, current) => current is! mealActionState,
      listener: (context, state) {
        if (state is MealSelectedButtonActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item selected')));
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case MealLoading:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case MealLoaded:
            final successState = state as MealLoaded;
            return Padding(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 0),
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
                      itemCount: successState.meals.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        mainAxisSpacing: 8.0, // Spacing between rows
                        crossAxisSpacing: 8.0, // Spacing between columns
                        childAspectRatio: 0.7, // Aspect ratio of each item
                      ),
                      itemBuilder: (context, index) {
                        return OrderTail(
                          orders: successState.meals[index],
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
