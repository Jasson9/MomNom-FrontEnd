// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addWeight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddWeightRequest _$AddWeightRequestFromJson(Map<String, dynamic> json) =>
    AddWeightRequest(
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$AddWeightRequestToJson(AddWeightRequest instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'weight': instance.weight,
    };
