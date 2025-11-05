import 'dart:convert';
import 'package:MomNom/model/base.dart';
import 'package:MomNom/model/model.dart';
import 'package:MomNom/model/plan.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dailyDiaryReport.dart';
part 'dashboard.g.dart';


@JsonSerializable()
class DashboardResponse{
    DashboardResponse({this.username, this.plans, this.remainingNutritions, this.dailyLogs});
    // DashboardResponse({this.username, this.plans});
    // DashboardResponse({this.username, this.plans});
    String? username;
    List<Plan>? plans;
    List<RemainingNutrient>? remainingNutritions;
    List<DailyDiaryFood>? dailyLogs;
    WeightCainCalc? currWeightGain;

    factory DashboardResponse.fromJson(Map<String, dynamic> json) => _$DashboardResponseFromJson(json);
    Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}
