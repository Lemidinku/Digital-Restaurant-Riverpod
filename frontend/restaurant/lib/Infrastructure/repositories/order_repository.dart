import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/order.dart';
import '../../storage.dart';

class OrderRepository {
  final String baseUrl;
  final SecureStorage _secureStorage = SecureStorage.instance;

  OrderRepository({required this.baseUrl});

  Future<List<Order>> fetchOrders() async {
    String? token = await _secureStorage.read('token');
    final response =
        await http.get(Uri.parse('$baseUrl/orders'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "authorization": "Bearer $token",
    });
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      print(body);
      return body.map((dynamic item) => Order.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Order> addOrder(order) async {
    String? token = await _secureStorage.read('token');
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{
        'phone': order.phone,
        'total_price': order.totalPrice,
        'meals': order.meals,
        'location': order.location,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add order');
    }
  }

  Future<Order> updateOrder({
    required int id,
    required bool completed,
  }) async {
    String? token = await _secureStorage.read('token');
    final response = await http.patch(
      Uri.parse('$baseUrl/orders/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "Bearer $token",
      },
      body: jsonEncode(<String, bool>{
        'completed': completed,
      }),
    );
    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update order');
    }
  }

  Future<void> deleteOrder({
    required int id,
  }) async {
    String? token = await _secureStorage.read('token');
    final response = await http.delete(
      Uri.parse('$baseUrl/orders/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "Bearer $token",
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }
}

// order repository test

void main() {
  String baseUrl = 'http://10.0.2.2:9000';
  OrderRepository orderRepository = OrderRepository(baseUrl: baseUrl);
  print(orderRepository.fetchOrders());
}
