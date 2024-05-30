import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/Infrastructure/repositories/orderedItems.dart';
import 'package:restaurant/application/cart/cart_bloc.dart';
import 'package:restaurant/application/meal/meal_bloc.dart';
import 'package:restaurant/domain/meal.dart';
import 'package:restaurant/presentation/addsubmit.dart';

class SelectedOrderPage extends StatefulWidget {
  @override
  _SelectedOrderPageState createState() => _SelectedOrderPageState();
}

class _SelectedOrderPageState extends State<SelectedOrderPage> {
  @override
  void initState() {
    context.read<CartBloc>().add(CartInitalEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Orders'),
        backgroundColor: Colors.deepOrange,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoaddingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: successState.orders.length,
                      itemBuilder: (context, index) {
                        final meal = state.orders.keys.elementAt(index);
                        final quantity = state.orders.values.elementAt(index);

                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.asset(
                              'assets/Pizza.jpg',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            title: Text(meal.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Price: \$${meal.price.toStringAsFixed(2)}'),
                                Text('Quantity: ${quantity}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                context
                                    .read<CartBloc>()
                                    .add(CartRemoveEvent(removedMeals: meal));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SubmitOrderPage();
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
                      'Submit Order',
                      style: TextStyle(color: Color(0xFFF97350)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              );
            default:
              return Container(
                child: Center(
                  child: Text('NO Items In the Cart'),
                ),
              );
          }
        },
      ),
    );
  }
}
