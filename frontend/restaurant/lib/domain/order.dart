import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int id;
  final String phone;
  final double totalPrice;
  final Map<String, int> meals;
  final String location;
  final bool completed;

  Order({
    required this.id,
    required this.phone,
    required this.totalPrice,
    required this.meals,
    required this.location,
    required this.completed,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
