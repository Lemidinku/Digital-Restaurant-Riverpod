import 'dart:convert';
import 'dart:ffi';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
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

  Future<bool> signup(String username, String password, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'username': username, 'password': password, 'phone': phone}),
    );

    Map<String, dynamic> returned = json.decode(response.body);
    if (returned['success'] == true) {
      return true;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete('token');
  }

  Future<User?> authCheck() async {
    print('in the repository authCheck');
    final token = await _secureStorage.read('token');
    if (token != null) {
      final decodedToken = JWT.decode(token);

      final payload = decodedToken.payload;
      print(payload);
      return User(
          id: payload['id'],
          username: payload['username'],
          phone: payload['phone'],
          role: payload['roles'][0]);
    } else {
      return null;
    }
  }
}
