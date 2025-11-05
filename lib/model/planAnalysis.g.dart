// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planAnalysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NutrientPlanProgress _$NutrientPlanProgressFromJson(
  Map<String, dynamic> json,
) => NutrientPlanProgress(
  json['nutrientName'] as String?,
  (json['nutrientAmount'] as num?)?.toDouble(),
  (json['goalAmount'] as num?)?.toDouble(),
  json['unit'] as String?,
);

Map<String, dynamic> _$NutrientPlanProgressToJson(
  NutrientPlanProgress instance,
) => <String, dynamic>{
  'nutrientName': instance.nutrientName,
  'nutrientAmount': instance.nutrientAmount,
  'goalAmount': instance.goalAmount,
  'unit': instance.unit,
};

NutrientPlanProgressResponse _$NutrientPlanProgressResponseFromJson(
  Map<String, dynamic> json,
) => NutrientPlanProgressResponse(
  (json['nutrientPlanProgresses'] as List<dynamic>)
      .map((e) => NutrientPlanProgress.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NutrientPlanProgressResponseToJson(
  NutrientPlanProgressResponse instance,
) => <String, dynamic>{
  'nutrientPlanProgresses': instance.nutrientPlanProgresses,
};

NutrientPlanProgressRequest _$NutrientPlanProgressRequestFromJson(
  Map<String, dynamic> json,
) => NutrientPlanProgressRequest(date: json['date'] as String?);

Map<String, dynamic> _$NutrientPlanProgressRequestToJson(
  NutrientPlanProgressRequest instance,
) => <String, dynamic>{'date': instance.date};

MonthlyWeightResponse _$MonthlyWeightResponseFromJson(
  Map<String, dynamic> json,
) => MonthlyWeightResponse(
  (json['weightGainProgress'] as List<dynamic>)
      .map((e) => WeightCainCalc.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MonthlyWeightResponseToJson(
  MonthlyWeightResponse instance,
) => <String, dynamic>{'weightGainProgress': instance.weightGainProgress};
