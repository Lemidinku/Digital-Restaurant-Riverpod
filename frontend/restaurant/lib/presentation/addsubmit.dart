import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/Infrastructure/repositories/orderedItems.dart';
import 'package:restaurant/application/order/order_provider.dart';
import 'package:restaurant/domain/order.dart';

class SubmitOrderPage extends ConsumerStatefulWidget {
  @override
  _SubmitOrderPageState createState() => _SubmitOrderPageState();
}

class _SubmitOrderPageState extends ConsumerState<SubmitOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitOrder();
                    }
                  },
                  child: const Text('Submit Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitOrder() {
    final String phone = _phoneController.text;
    final String location = _locationController.text;
    double totalPrice = 0;
    Map<String, int> meals = {};

    orderedItems.forEach((meal, quantity) {
      meals[meal.name] = quantity;
      totalPrice += meal.price * quantity;
    });
    final orderNotifier = ref.read(orderNotifierProvider.notifier);
    orderNotifier.addOrder(Order(
      id: 0,
      phone: phone,
      totalPrice: totalPrice,
      meals: meals,
      location: location,
      completed: false,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Order submitted successfully! Phone: $phone, Location: $location'),
      ),
    );

    _formKey.currentState!.reset();
    _phoneController.clear();
    _locationController.clear();
  }
}
