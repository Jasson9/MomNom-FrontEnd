// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addDiary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddDiaryFoodItem _$AddDiaryFoodItemFromJson(Map<String, dynamic> json) =>
    AddDiaryFoodItem(
      foodName: json['foodName'] as String?,
      amountGr: (json['amountGr'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AddDiaryFoodItemToJson(AddDiaryFoodItem instance) =>
    <String, dynamic>{
      'foodName': instance.foodName,
      'amountGr': instance.amountGr,
    };

AddDiaryRequest _$AddDiaryRequestFromJson(Map<String, dynamic> json) =>
    AddDiaryRequest(
      DateTime.parse(json['date'] as String),
      (json['foodItems'] as List<dynamic>)
          .map((e) => AddDiaryFoodItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddDiaryRequestToJson(AddDiaryRequest instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'foodItems': instance.foodItems,
    };

AddDiaryResponse _$AddDiaryResponseFromJson(Map<String, dynamic> json) =>
    AddDiaryResponse(
      foodIds:
          (json['foodIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList(),
    );

Map<String, dynamic> _$AddDiaryResponseToJson(AddDiaryResponse instance) =>
    <String, dynamic>{'foodIds': instance.foodIds};
