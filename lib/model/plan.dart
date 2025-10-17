import 'package:json_annotation/json_annotation.dart';
part 'plan.g.dart';
@JsonSerializable()
class Plan{
    int? PlanId;
    int? StartWeek;
    double? Weight;
    double? Height;
    int? Age;
    double? PrePregnancyWeight;
    String? BmiCategory;
    double? CalFirstTrimester;
    double? CalSecondThirdTrimester;

    Plan({this.PlanId, this.StartWeek, this.Weight, this.Height, this.Age,
        this.PrePregnancyWeight, this.BmiCategory, this.CalFirstTrimester,
        this.CalSecondThirdTrimester});

    factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
    Map<String, dynamic> toJson() => _$PlanToJson(this);
}

@JsonSerializable()
class CreatePlanRequest{
    String? DOBstring;
    int? age;
    double? height;
    int? weekPregnancy;
    double? currentWeight;
    double? prePregnancyWeight;

    CreatePlanRequest(
        {this.DOBstring, this.age, this.height, this.weekPregnancy,
            this.currentWeight, this.prePregnancyWeight});

    factory CreatePlanRequest.fromJson(Map<String, dynamic> json) => _$CreatePlanRequestFromJson(json);
    Map<String, dynamic> toJson() => _$CreatePlanRequestToJson(this);
}

@JsonSerializable()
class CreatePlanResponse{
    int? planId;

    CreatePlanResponse({this.planId});
    factory CreatePlanResponse.fromJson(Map<String, dynamic> json) => _$CreatePlanResponseFromJson(json);
    Map<String, dynamic> toJson() => _$CreatePlanResponseToJson(this);
}