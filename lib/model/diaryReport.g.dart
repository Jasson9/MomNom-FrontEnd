// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diaryReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyDiary _$WeeklyDiaryFromJson(Map<String, dynamic> json) => WeeklyDiary(
  weekId: (json['weekId'] as num).toInt(),
  weekStart: DateTime.parse(json['weekStart'] as String),
  weekEnd: DateTime.parse(json['weekEnd'] as String),
  totalCalories: (json['totalCalories'] as num).toDouble(),
  totalProtein: (json['totalProtein'] as num).toDouble(),
  totalCarbohydrates: (json['totalCarbohydrates'] as num).toDouble(),
  totalFiber: (json['totalFiber'] as num).toDouble(),
);

Map<String, dynamic> _$WeeklyDiaryToJson(WeeklyDiary instance) =>
    <String, dynamic>{
      'weekId': instance.weekId,
      'weekStart': instance.weekStart.toIso8601String(),
      'weekEnd': instance.weekEnd.toIso8601String(),
      'totalCalories': instance.totalCalories,
      'totalProtein': instance.totalProtein,
      'totalCarbohydrates': instance.totalCarbohydrates,
      'totalFiber': instance.totalFiber,
    };

WeeklyDiaryGroup _$WeeklyDiaryGroupFromJson(Map<String, dynamic> json) =>
    WeeklyDiaryGroup(
      year: (json['year'] as num?)?.toInt(),
      month: json['month'] as String?,
      weeklyLogDetail:
          (json['weeklyLogDetail'] as List<dynamic>?)
              ?.map((e) => WeeklyDiary.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$WeeklyDiaryGroupToJson(WeeklyDiaryGroup instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'weeklyLogDetail': instance.weeklyLogDetail,
    };

WeeklyDiaryResponse _$WeeklyDiaryResponseFromJson(Map<String, dynamic> json) =>
    WeeklyDiaryResponse(
      weeklyLogs:
          (json['weeklyLogs'] as List<dynamic>?)
              ?.map((e) => WeeklyDiaryGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$WeeklyDiaryResponseToJson(
  WeeklyDiaryResponse instance,
) => <String, dynamic>{'weeklyLogs': instance.weeklyLogs};
