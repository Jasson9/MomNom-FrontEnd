// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      Username: json['Username'] as String?,
      plans:
          (json['plans'] as List<dynamic>?)
              ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{'Username': instance.Username, 'plans': instance.plans};
