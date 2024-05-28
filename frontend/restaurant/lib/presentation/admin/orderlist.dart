import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project ',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Orders(),
    );
  }
}

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample list of orders
    List<Order> orders = [
      Order(
          orderNumber: '1',
          foods: ['Pizza'],
          amounts: [3],
          price: '\$30',
          date: '2022-01-01'),
      Order(
          orderNumber: '2',
          foods: ['Burger', 'Fries'],
          amounts: [2, 1],
          price: '\$15',
          date: '2022-01-02'),
      Order(
          orderNumber: '3',
          foods: ['Salad'],
          amounts: [1],
          price: '\$6',
          date: '2022-01-03'),
      Order(
          orderNumber: '4',
          foods: ['Salad'],
          amounts: [1],
          price: '\$6',
          date: '2022-01-03'),
      Order(
          orderNumber: '5',
          foods: ['Salad'],
          amounts: [1],
          price: '\$6',
          date: '2022-01-03'),
      Order(
          orderNumber: '7',
          foods: ['Salad'],
          amounts: [1],
          price: '\$6',
          date: '2022-01-03'),
      Order(
          orderNumber: '8',
          foods: ['Salad'],
          amounts: [1],
          price: '\$6',
          date: '2022-01-03'),
      Order(
          orderNumber: '9',
          foods: ['Salad'],
          amounts: [1],
          price: '\$6',
          date: '2022-01-03'),
      Order(
          orderNumber: '10',
          foods: ['Salad'],
          amounts: [1],
          price: '\$6',
          date: '2022-01-03'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(order: orders[index]);
        },
      ),
    );
  }
}

class Order {
  final String orderNumber;
  final List<String> foods;
  final List<int> amounts;
  final String price;
  final String date;
  bool isCompleted;

  Order({
    required this.orderNumber,
    required this.foods,
    required this.amounts,
    required this.price,
    required this.date,
    this.isCompleted = false,
  });
}

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),

      elevation: 5, // Add elevation for box shadow
      shadowColor: Colors.grey,
      child: ListTile(
        title: Text(
          'Order: ${widget.order.orderNumber}',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Food: '),
                for (var i = 0; i < widget.order.foods.length; i++)
                  Text(
                    '${widget.order.foods[i]} ${widget.order.amounts[i]}${i == widget.order.foods.length - 1 ? '' : ', '}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            Text('Price: ${widget.order.price}'),
            Text('Date: ${widget.order.date}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            widget.order.isCompleted ? Icons.check : Icons.pending,
            color:
                widget.order.isCompleted ? Colors.lightBlue : Colors.deepOrange,
            size: 40.0,
          ),
          onPressed: () {
            setState(() {
              widget.order.isCompleted = !widget.order.isCompleted;
            });
          },
        ),
      ),
    );
  }
}
