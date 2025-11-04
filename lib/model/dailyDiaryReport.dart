
import 'package:json_annotation/json_annotation.dart';

import 'base.dart';
import 'model.dart';
part 'dailyDiaryReport.g.dart';

@JsonSerializable()
class DailyDiaryFood{
    String? foodName;
    double? amount;
    double? totalCalories;
    // String? nutrientsList;
    List<Nutrient> nutrientsListDetail;

    DailyDiaryFood({required this.foodName, required this.amount, required this.totalCalories,
          required this.nutrientsListDetail});

    factory DailyDiaryFood.fromJson(Map<String, dynamic> json) => _$DailyDiaryFoodFromJson(json);
    Map<String, dynamic> toJson() => _$DailyDiaryFoodToJson(this);
}

@JsonSerializable()
class DailyDiaryRequest implements BaseRequest{
    String date;
    DailyDiaryRequest(this.date);

    factory DailyDiaryRequest.fromJson(Map<String, dynamic> json) => _$DailyDiaryRequestFromJson(json);
    Map<String, dynamic> toJson() => _$DailyDiaryRequestToJson(this);
}

@JsonSerializable()
class DailyDiaryResponse{

    List<DailyDiaryFood>? dailyLogs;

    DailyDiaryResponse({this.dailyLogs});
    factory DailyDiaryResponse.fromJson(Map<String, dynamic> json) => _$DailyDiaryResponseFromJson(json);
    Map<String, dynamic> toJson() => _$DailyDiaryResponseToJson(this);
}