// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
  PlanId: (json['PlanId'] as num?)?.toInt(),
  StartWeek: (json['StartWeek'] as num?)?.toInt(),
  Weight: (json['Weight'] as num?)?.toDouble(),
  Height: (json['Height'] as num?)?.toDouble(),
  Age: (json['Age'] as num?)?.toInt(),
  PrePregnancyWeight: (json['PrePregnancyWeight'] as num?)?.toDouble(),
  BmiCategory: json['BmiCategory'] as String?,
  CalFirstTrimester: (json['CalFirstTrimester'] as num?)?.toDouble(),
  CalSecondThirdTrimester:
      (json['CalSecondThirdTrimester'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
  'PlanId': instance.PlanId,
  'StartWeek': instance.StartWeek,
  'Weight': instance.Weight,
  'Height': instance.Height,
  'Age': instance.Age,
  'PrePregnancyWeight': instance.PrePregnancyWeight,
  'BmiCategory': instance.BmiCategory,
  'CalFirstTrimester': instance.CalFirstTrimester,
  'CalSecondThirdTrimester': instance.CalSecondThirdTrimester,
};

CreatePlanRequest _$CreatePlanRequestFromJson(Map<String, dynamic> json) =>
    CreatePlanRequest(
      DOBstring: json['DOBstring'] as String?,
      age: (json['age'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toDouble(),
      weekPregnancy: (json['weekPregnancy'] as num?)?.toInt(),
      currentWeight: (json['currentWeight'] as num?)?.toDouble(),
      prePregnancyWeight: (json['prePregnancyWeight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CreatePlanRequestToJson(CreatePlanRequest instance) =>
    <String, dynamic>{
      'DOBstring': instance.DOBstring,
      'age': instance.age,
      'height': instance.height,
      'weekPregnancy': instance.weekPregnancy,
      'currentWeight': instance.currentWeight,
      'prePregnancyWeight': instance.prePregnancyWeight,
    };

CreatePlanResponse _$CreatePlanResponseFromJson(Map<String, dynamic> json) =>
    CreatePlanResponse(planId: (json['planId'] as num?)?.toInt());

Map<String, dynamic> _$CreatePlanResponseToJson(CreatePlanResponse instance) =>
    <String, dynamic>{'planId': instance.planId};
