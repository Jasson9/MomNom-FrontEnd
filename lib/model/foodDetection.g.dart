// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foodDetection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodDetectionRequest _$FoodDetectionRequestFromJson(
  Map<String, dynamic> json,
) => FoodDetectionRequest(json['imageBase64'] as String);

Map<String, dynamic> _$FoodDetectionRequestToJson(
  FoodDetectionRequest instance,
) => <String, dynamic>{'imageBase64': instance.imageBase64};

FoodDetectionResponse _$FoodDetectionResponseFromJson(
  Map<String, dynamic> json,
) => FoodDetectionResponse(
  foodNameList:
      (json['foodNameList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$FoodDetectionResponseToJson(
  FoodDetectionResponse instance,
) => <String, dynamic>{'foodNameList': instance.foodNameList};
