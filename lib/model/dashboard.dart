import 'dart:convert';
import 'package:MomNom/model/base.dart';
import 'package:MomNom/model/plan.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dashboard.g.dart';


@JsonSerializable()
class DashboardResponse{
    DashboardResponse({this.Username, this.plans});
    String? Username;
  List<Plan>? plans;
    factory DashboardResponse.fromJson(Map<String, dynamic> json) => _$DashboardResponseFromJson(json);
    Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}
