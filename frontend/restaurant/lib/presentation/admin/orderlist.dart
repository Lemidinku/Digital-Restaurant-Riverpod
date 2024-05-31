import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/application/auth/auth_provider.dart';
import 'package:restaurant/domain/order.dart';
import 'package:restaurant/application/order/order_provider.dart';

class OrdersListPage extends ConsumerStatefulWidget {
  const OrdersListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersListPage> createState() => _OrdersListPageState();
}

class _OrdersListPageState extends ConsumerState<OrdersListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(orderNotifierProvider.notifier).loadOrders());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OrdersListPage',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
      ),
      body: state is OrderLoading
          ? const Center(child: CircularProgressIndicator())
          : state is OrderError
              ? Center(child: Text(state.message))
              : state is OrderLoaded
                  ? ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(order: state.orders[index]);
                      },
                    )
                  : const SizedBox(),
    );
  }
}

// class OrderCard extends StatefulWidget {
//   final Order order;

//   const OrderCard({Key? key, required this.order}) : super(key: key);

//   @override
//   _OrderCardState createState() => _OrderCardState();
// }

// class _OrderCardState extends State<OrderCard> {
//   late bool completed;

//   @override
//   void initState() {
//     super.initState();
//     completed = widget.order.completed;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       elevation: 5, // Add elevation for box shadow
//       shadowColor: Colors.grey,
//       child: ListTile(
//         title: Text(
//           'Order: ${widget.order.id}',
//           style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.deepOrange),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text('Food: '),
//                 ...widget.order.meals.entries.map(
//                   (entry) => Text(
//                     '${entry.key} ${entry.value}${entry == widget.order.meals.entries.last ? '' : ', '}',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//             Text('Price: ${widget.order.totalPrice}'),
//             Text('Date: 2025/5/2'),
//           ],
//         ),
//         trailing: IconButton(
//           icon: Icon(
//             completed ? Icons.check : Icons.pending,
//             color: completed ? Colors.lightBlue : Colors.deepOrange,
//             size: 40.0,
//           ),
//           onPressed: () {
//             setState(() {
//               completed = !completed;
//             });
//             final orderNotifier = ref.read(orderNotifierProvider.notifier);
//             orderNotifier.updateOrder(widget.order.id, completed);
//           },
//         ),
//       ),
//     );
//   }
// }

class OrderCard extends ConsumerStatefulWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 5, // Add elevation for box shadow
      shadowColor: Colors.grey,
      child: ListTile(
        title: Text(
          'Order: ${widget.order.id}',
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
                ...widget.order.meals.entries.map(
                  (entry) => Text(
                    '${entry.key} ${entry.value}${entry == widget.order.meals.entries.last ? '' : ', '}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Text('Price: ${widget.order.totalPrice}'),
            Text('Date: 2025/5/2'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            widget.order.completed ? Icons.check : Icons.pending,
            color:
                widget.order.completed ? Colors.lightBlue : Colors.deepOrange,
            size: 40.0,
          ),
          onPressed: () {
            final orderNotifier = ref.read(orderNotifierProvider.notifier);
            orderNotifier.updateOrder(
                id: widget.order.id, completed: !widget.order.completed);
          },
        ),
      ),
    );
  }
}
