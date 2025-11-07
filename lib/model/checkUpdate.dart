import 'dart:convert';
import 'package:MomNom/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'checkUpdate.g.dart';

@JsonSerializable()
class CheckUpdateRequest implements BaseRequest{
  
    String? version;
    factory CheckUpdateRequest.fromJson(Map<String, dynamic> json) => _$CheckUpdateRequestFromJson(json);
    Map<String, dynamic> toJson() => _$CheckUpdateRequestToJson(this);
    CheckUpdateRequest({this.version});
}

@JsonSerializable()
class CheckUpdateResponse{
    String? changelogs;
    String? versionString;
    String? downloadLink;
    bool? isUpToDate;

    CheckUpdateResponse({this.changelogs, this.versionString, this.downloadLink,
        this.isUpToDate});

    factory CheckUpdateResponse.fromJson(Map<String, dynamic> json) => _$CheckUpdateResponseFromJson(json);
    Map<String, dynamic> toJson() => _$CheckUpdateResponseToJson(this);
}
