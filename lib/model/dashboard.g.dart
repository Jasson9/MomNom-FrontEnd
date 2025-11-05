// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
        username: json['username'] as String?,
        plans:
            (json['plans'] as List<dynamic>?)
                ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
                .toList(),
        remainingNutritions:
            (json['remainingNutritions'] as List<dynamic>?)
                ?.map(
                  (e) => RemainingNutrient.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
        dailyLogs:
            (json['dailyLogs'] as List<dynamic>?)
                ?.map((e) => DailyDiaryFood.fromJson(e as Map<String, dynamic>))
                .toList(),
      )
      ..currWeightGain =
          json['currWeightGain'] == null
              ? null
              : WeightCainCalc.fromJson(
                json['currWeightGain'] as Map<String, dynamic>,
              );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'plans': instance.plans,
      'remainingNutritions': instance.remainingNutritions,
      'dailyLogs': instance.dailyLogs,
      'currWeightGain': instance.currWeightGain,
    };
