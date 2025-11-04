// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nutrient _$NutrientFromJson(Map<String, dynamic> json) => Nutrient(
  nutrientName: json['nutrientName'] as String,
  amount: (json['amount'] as num).toDouble(),
  unit: json['unit'] as String,
);

Map<String, dynamic> _$NutrientToJson(Nutrient instance) => <String, dynamic>{
  'nutrientName': instance.nutrientName,
  'amount': instance.amount,
  'unit': instance.unit,
};
