
import 'package:MomNom/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base.dart';
part 'planAnalysis.g.dart';
@JsonSerializable()
class NutrientPlanProgress{
    String? nutrientName;
    double? nutrientAmount;
    double? goalAmount;
    String? unit;

    NutrientPlanProgress(this.nutrientName, this.nutrientAmount,
        this.goalAmount, this.unit);

    factory NutrientPlanProgress.fromJson(Map<String, dynamic> json) => _$NutrientPlanProgressFromJson(json);
    Map<String, dynamic> toJson() => _$NutrientPlanProgressToJson(this);
}

@JsonSerializable()
class NutrientPlanProgressResponse {
    List<NutrientPlanProgress> nutrientPlanProgresses;

    NutrientPlanProgressResponse(this.nutrientPlanProgresses);

    factory NutrientPlanProgressResponse.fromJson(Map<String, dynamic> json) => _$NutrientPlanProgressResponseFromJson(json);
    Map<String, dynamic> toJson() => _$NutrientPlanProgressResponseToJson(this);
}

@JsonSerializable()
class NutrientPlanProgressRequest implements BaseRequest{
    String? date;

    NutrientPlanProgressRequest({this.date});
    factory NutrientPlanProgressRequest.fromJson(Map<String, dynamic> json) => _$NutrientPlanProgressRequestFromJson(json);
    Map<String, dynamic> toJson() => _$NutrientPlanProgressRequestToJson(this);
}

@JsonSerializable()
class MonthlyWeightResponse {
    List<WeightCainCalc> weightGainProgress;

    MonthlyWeightResponse(this.weightGainProgress);

    factory MonthlyWeightResponse.fromJson(Map<String, dynamic> json) => _$MonthlyWeightResponseFromJson(json);
    Map<String, dynamic> toJson() => _$MonthlyWeightResponseToJson(this);
}