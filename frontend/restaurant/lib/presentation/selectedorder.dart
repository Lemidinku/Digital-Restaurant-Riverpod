import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/presentation/addsubmit.dart';
import '../application/cart/cart_provider.dart';

class SelectedOrderPage extends ConsumerStatefulWidget {
  @override
  _SelectedOrderPageState createState() => _SelectedOrderPageState();
}

class _SelectedOrderPageState extends ConsumerState<SelectedOrderPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(cartNotifierProvider.notifier)
        .cartInitalEvent(CartInitalEvent()));
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Orders'),
        backgroundColor: Colors.deepOrange,
      ),
      body: cartState is CartLoaddingState
          ? const Center(child: CircularProgressIndicator())
          : cartState is CartSuccessState
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartState.orders.length,
                        itemBuilder: (context, index) {
                          final meal = cartState.orders.keys.elementAt(index);
                          final quantity =
                              cartState.orders.values.elementAt(index);

                          return Card(
                            margin: const EdgeInsets.all(8.0),
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
                                  Text('Quantity: $quantity'),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  ref
                                      .read(cartNotifierProvider.notifier)
                                      .cartRemoveEvent(
                                          CartRemoveEvent(removedMeals: meal));
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
                    const SizedBox(
                      height: 30,
                    )
                  ],
                )
              : const Center(
                  child: Text('NO Items In the Cart'),
                ),
    );
  }
}
