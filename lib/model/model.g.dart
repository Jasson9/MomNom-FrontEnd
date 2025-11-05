// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightCainCalc _$WeightCainCalcFromJson(Map<String, dynamic> json) =>
    WeightCainCalc(
      monthYear: json['monthYear'] as String,
      monthlyGain: (json['monthlyGain'] as num).toDouble(),
      totalGain: (json['totalGain'] as num).toDouble(),
      recGain: (json['recGain'] as num).toDouble(),
      percentage: json['percentage'] as String,
    );

Map<String, dynamic> _$WeightCainCalcToJson(WeightCainCalc instance) =>
    <String, dynamic>{
      'monthYear': instance.monthYear,
      'monthlyGain': instance.monthlyGain,
      'totalGain': instance.totalGain,
      'recGain': instance.recGain,
      'percentage': instance.percentage,
    };

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

RemainingNutrient _$RemainingNutrientFromJson(Map<String, dynamic> json) =>
    RemainingNutrient(
      nutrientName: json['nutrientName'] as String,
      remainingNutrient: (json['remainingNutrient'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$RemainingNutrientToJson(RemainingNutrient instance) =>
    <String, dynamic>{
      'nutrientName': instance.nutrientName,
      'remainingNutrient': instance.remainingNutrient,
      'unit': instance.unit,
    };
