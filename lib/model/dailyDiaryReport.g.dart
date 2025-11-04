// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyDiaryReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyDiaryFood _$DailyDiaryFoodFromJson(Map<String, dynamic> json) =>
    DailyDiaryFood(
      foodName: json['foodName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      totalCalories: (json['totalCalories'] as num?)?.toDouble(),
      nutrientsListDetail:
          (json['nutrientsListDetail'] as List<dynamic>)
              .map((e) => Nutrient.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$DailyDiaryFoodToJson(DailyDiaryFood instance) =>
    <String, dynamic>{
      'foodName': instance.foodName,
      'amount': instance.amount,
      'totalCalories': instance.totalCalories,
      'nutrientsListDetail': instance.nutrientsListDetail,
    };

DailyDiaryRequest _$DailyDiaryRequestFromJson(Map<String, dynamic> json) =>
    DailyDiaryRequest(json['date'] as String);

Map<String, dynamic> _$DailyDiaryRequestToJson(DailyDiaryRequest instance) =>
    <String, dynamic>{'date': instance.date};

DailyDiaryResponse _$DailyDiaryResponseFromJson(Map<String, dynamic> json) =>
    DailyDiaryResponse(
      dailyLogs:
          (json['dailyLogs'] as List<dynamic>?)
              ?.map((e) => DailyDiaryFood.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$DailyDiaryResponseToJson(DailyDiaryResponse instance) =>
    <String, dynamic>{'dailyLogs': instance.dailyLogs};
