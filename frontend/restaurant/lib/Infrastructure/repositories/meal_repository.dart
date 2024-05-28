import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/meal.dart';
import "../../storage.dart";

class MealRepository {
  final String baseUrl;
  final SecureStorage _secureStorage = SecureStorage.instance;

  MealRepository({required this.baseUrl});

  Future<List<Meal>> fetchMeals() async {
    String? token = await _secureStorage.read('token');
    final response =
        await http.get(Uri.parse('$baseUrl/meals'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "authorization": "Bearer $token",
    });
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      print(body);
      return body.map((dynamic item) => Meal.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<Meal> addMeal(String name, String description, String price) async {
    String? token = await _secureStorage.read('token');
    final response = await http.post(
      Uri.parse('$baseUrl/meals'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "Bearer $token",
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'description': description,
        'price': price,
      }),
    );
    if (response.statusCode == 200) {
      return Meal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add meal');
    }
  }

  Future<Meal> updateMeal(
      String id, String name, String description, String price) async {
    String? token = await _secureStorage.read('token');
    final response = await http.put(
      Uri.parse('$baseUrl/meals/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "Bearer $token",
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'description': description,
        'price': price,
      }),
    );
    if (response.statusCode == 200) {
      return Meal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update meal');
    }
  }

  Future<void> deleteMeal(String id) async {
    String? token = await _secureStorage.read('token');
    final response = await http.delete(
      Uri.parse('$baseUrl/meals/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "Bearer $token",
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete meal');
    }
  }
}

// meal repository test

void main() {
  String baseUrl = 'http://10.0.2.2:9000';
  MealRepository mealRepository = MealRepository(baseUrl: baseUrl);
  print(mealRepository.fetchMeals());
}
