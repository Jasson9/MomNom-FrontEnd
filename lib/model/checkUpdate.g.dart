// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUpdateRequest _$CheckUpdateRequestFromJson(Map<String, dynamic> json) =>
    CheckUpdateRequest(version: json['version'] as String?);

Map<String, dynamic> _$CheckUpdateRequestToJson(CheckUpdateRequest instance) =>
    <String, dynamic>{'version': instance.version};

CheckUpdateResponse _$CheckUpdateResponseFromJson(Map<String, dynamic> json) =>
    CheckUpdateResponse(
      changelogs: json['changelogs'] as String?,
      versionString: json['versionString'] as String?,
      downloadLink: json['downloadLink'] as String?,
      isUpToDate: json['isUpToDate'] as bool?,
    );

Map<String, dynamic> _$CheckUpdateResponseToJson(
  CheckUpdateResponse instance,
) => <String, dynamic>{
  'changelogs': instance.changelogs,
  'versionString': instance.versionString,
  'downloadLink': instance.downloadLink,
  'isUpToDate': instance.isUpToDate,
};
