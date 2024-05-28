import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> types;
  final String allergy;
  final bool fasting;
  final String origin;

  Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.types,
    required this.allergy,
    required this.fasting,
    required this.origin,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
  Map<String, dynamic> toJson() => _$MealToJson(this);
}
