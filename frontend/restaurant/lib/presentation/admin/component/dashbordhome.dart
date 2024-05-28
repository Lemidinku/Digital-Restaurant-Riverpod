import 'package:flutter/material.dart';

class AddedFoodsPage extends StatelessWidget {
  // Sample list of added food items
  final List<AddedFoodItem> addedFoods = [
    AddedFoodItem(
      foodName: 'Pizza',
      foodKind: 'Non-Fasting',
      foodType: 'Dinner',
      foodPrice: '\$10',
      foodOrigin: 'Italy',
      foodImage: 'assets/Pizza.jpg',
    ),
    AddedFoodItem(
      foodName: 'Salad',
      foodKind: 'Non-Fasting',
      foodType: 'Starter',
      foodPrice: '\$8',
      foodOrigin: 'Italy',
      foodImage: 'assets/Pizza.jpg',
    ),
    AddedFoodItem(
      foodName: 'Salad',
      foodKind: 'Non-Fasting',
      foodType: 'Starter',
      foodPrice: '\$8',
      foodOrigin: 'Italy',
      foodImage: 'assets/Pizza.jpg',
    ),
    AddedFoodItem(
      foodName: 'Salad',
      foodKind: 'Non-Fasting',
      foodType: 'Starter',
      foodPrice: '\$8',
      foodOrigin: 'Italy',
      foodImage: 'assets/Pizza.jpg',
    ),
    AddedFoodItem(
      foodName: 'Salad',
      foodKind: 'Non-Fasting',
      foodType: 'Starter',
      foodPrice: '\$8',
      foodOrigin: 'Italy',
      foodImage: 'assets/Pizza.jpg',
    ),
    AddedFoodItem(
      foodName: 'Salad',
      foodKind: 'Non-Fasting',
      foodType: 'Starter',
      foodPrice: '\$8',
      foodOrigin: 'Italy',
      foodImage: 'assets/Pizza.jpg',
    ),
    AddedFoodItem(
      foodName: 'Salad',
      foodKind: 'Non-Fasting',
      foodType: 'Starter',
      foodPrice: '\$8',
      foodOrigin: 'Italy',
      foodImage: 'assets/Pizza.jpg',
    ),
    // Add more sample food items here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Added Foods',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: addedFoods.map((food) {
          return AddedFoodCard(
            addedFood: food,
          );
        }).toList(),
      ),
    );
  }
}

class AddedFoodItem {
  final String foodName;
  final String foodKind;
  final String foodType;
  final String foodPrice;
  final String foodOrigin;
  final String foodImage;

  AddedFoodItem({
    required this.foodName,
    required this.foodKind,
    required this.foodType,
    required this.foodPrice,
    required this.foodOrigin,
    required this.foodImage,
  });
}

class AddedFoodCard extends StatelessWidget {
  final AddedFoodItem addedFood;

  const AddedFoodCard({Key? key, required this.addedFood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.0,
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: FractionallySizedBox(
                heightFactor: 2.5,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: Image.asset(
                    '${addedFood.foodImage}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addedFood.foodName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Kind: ${addedFood.foodKind}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Type: ${addedFood.foodType}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Price: ${addedFood.foodPrice}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Origin: ${addedFood.foodOrigin}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
