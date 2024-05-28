// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num).toInt(),
      phone: json['phone'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      meals: Map<String, int>.from(json['meals'] as Map),
      location: json['location'] as String,
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'totalPrice': instance.totalPrice,
      'meals': instance.meals,
      'location': instance.location,
      'completed': instance.completed,
    };
