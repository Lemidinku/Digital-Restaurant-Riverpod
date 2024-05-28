import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/user.dart';
import '../../storage.dart';

class AuthRepository {
  final String baseUrl;
  final SecureStorage _secureStorage = SecureStorage.instance;

  AuthRepository({required this.baseUrl});

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    Map<String, dynamic> returned = json.decode(response.body);
    if (returned['success'] == true) {
      await _secureStorage.write('token', returned['token']);
      return User.fromJson(returned['user']);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<User> signup(String username, String password, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'username': username, 'password': password, 'phone': phone}),
    );

    Map<String, dynamic> returned = json.decode(response.body);
    if (returned['success'] == true) {
      return User.fromJson(returned['user']);
    } else {
      throw Exception('Failed to register');
    }
  }
}
