import 'package:flutter/material.dart';

// Define a model class for selected food items
class SelectedFoodItem {
  final String name;
  final String image;
  final double price;
  int quantity;

  SelectedFoodItem({
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}

class SelectedOrderPage extends StatefulWidget {
  @override
  _SelectedOrderPageState createState() => _SelectedOrderPageState();
}

class _SelectedOrderPageState extends State<SelectedOrderPage> {
  // List of selected food items
  List<SelectedFoodItem> selectedFoods = [
    SelectedFoodItem(
      name: 'Pizza',
      image: 'assets/Pizza.jpg',
      price: 10.0,
      quantity: 2,
    ),
    SelectedFoodItem(
      name: 'shiro',
      image: 'assets/shiro.jpg',
      price: 8.0,
      quantity: 1,
    ),
    SelectedFoodItem(
      name: 'genfo',
      image: 'assets/genfo.jpg',
      price: 8.0,
      quantity: 1,
    ),
    SelectedFoodItem(
      name: 'kitfo',
      image: 'assets/kitfo.jpg',
      price: 8.0,
      quantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Orders'),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: selectedFoods.length,
        itemBuilder: (context, index) {
          final foodItem = selectedFoods[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(
                foodItem.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(foodItem.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: \$${foodItem.price.toStringAsFixed(2)}'),
                  Text('Quantity: ${foodItem.quantity}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    selectedFoods.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SelectedOrderPage(),
  ));
}
