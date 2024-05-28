import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant/presentation/detail.dart';
import 'package:restaurant/presentation/rating_stars.dart';
import 'package:restaurant/presentation/selectedorder.dart';
import 'plus_minus_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const OrderNowPage(),
    );
  }
}

class OrderNowPage extends StatefulWidget {
  const OrderNowPage({super.key});

  @override
  State<OrderNowPage> createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<OrderNowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Restaurant'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFF97350),
              ),
              child: Text(
                'Filters',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: const Text('Origin'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Fasting'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Allergies'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectedOrderPage()),
                        );
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
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.65,
                children: [
                  _buildFoodItemCard(
                      title: 'DORO WOT',
                      imagePath: 'assets/dorowot.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                  _buildFoodItemCard(
                      title: 'GENFO',
                      imagePath: 'assets/genfo.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                  _buildFoodItemCard(
                      title: 'DULET',
                      imagePath: 'assets/dulet.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                  _buildFoodItemCard(
                      title: 'KITFO',
                      imagePath: 'assets/kitfo.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                  _buildFoodItemCard(
                      title: 'TIRE SEGA',
                      imagePath: 'assets/tire.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                  _buildFoodItemCard(
                      title: 'SHIRO',
                      imagePath: 'assets/shiro.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                  _buildFoodItemCard(
                      title: 'TIBS',
                      imagePath: 'assets/tibs.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                  _buildFoodItemCard(
                      title: 'CHEESE BURGER',
                      imagePath: 'assets/cheeseburger.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                  _buildFoodItemCard(
                      title: 'PIZZA',
                      imagePath: 'assets/Pizza.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                  _buildFoodItemCard(
                      title: 'STEAK',
                      imagePath: 'assets/steak.jpg',
                      price: '300',
                      rating: '4',
                      kind: 'lunch',
                      type: 'nonfasting',
                      origin: 'ethiopia'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodItemCard(
      {required String title,
      required String imagePath,
      required String rating,
      required String kind,
      required String type,
      required String origin,
      required String price}) {
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
              height: 100,
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
                              imagePath: imagePath,
                              price: price,
                              origin: origin,
                              rating: rating,
                              type: type,
                              title: title,
                              kind: kind,
                            ),
                          ));
                        },
                        child: Image.asset(
                          imagePath,
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
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      price,
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
                const PlusMinusInput(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: ElevatedButton(
                    onPressed: () {},
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
