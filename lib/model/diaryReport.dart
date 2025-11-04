
import 'package:json_annotation/json_annotation.dart';

import 'base.dart';
import 'model.dart';
part 'diaryReport.g.dart';
@JsonSerializable()
class WeeklyDiary{
    int weekId;
    DateTime weekStart;
    DateTime weekEnd;
    double totalCalories;
    double totalProtein;
    double totalCarbohydrates;
    double totalFiber;


    WeeklyDiary({required this.weekId, required this.weekStart, required this.weekEnd, required this.totalCalories,
        required this.totalProtein, required this.totalCarbohydrates, required this.totalFiber});

    factory WeeklyDiary.fromJson(Map<String, dynamic> json) => _$WeeklyDiaryFromJson(json);
    Map<String, dynamic> toJson() => _$WeeklyDiaryToJson(this);

    DiaryWeekCardModel toWeekCardModel(int year, String month){
        print("Selected year "+year.toString());
        print("Selected month "+month);
        var res = DiaryWeekCardModel(year: year, month: month, weekNumber: weekId ?? 0,
        dateStart: weekStart.day, dateEnd: weekEnd.day, nutrients: AllNutrients(
                calorie: Nutrient(nutrientName: "Calorie", amount: totalCalories, unit: "kcal/day"),
                protein: Nutrient(nutrientName: "Protein", amount: totalProtein, unit: "gr/day"),
                carbohydrate: Nutrient(nutrientName: "Carbohydrate", amount: totalCarbohydrates, unit: "gr/day"),
                fiber: Nutrient(nutrientName: "Fiber", amount: totalFiber, unit: "gr/day"),
            ));
        print(totalCalories);
        return res;
    }
}

@JsonSerializable()
class WeeklyDiaryGroup{
    int? year;
    String? month;
    List<WeeklyDiary>? weeklyLogDetail;


    WeeklyDiaryGroup({this.year, this.month, this.weeklyLogDetail});
    factory WeeklyDiaryGroup.fromJson(Map<String, dynamic> json) => _$WeeklyDiaryGroupFromJson(json);
    Map<String, dynamic> toJson() => _$WeeklyDiaryGroupToJson(this);
}

@JsonSerializable()
class WeeklyDiaryResponse{

    List<WeeklyDiaryGroup>? weeklyLogs;

    WeeklyDiaryResponse({this.weeklyLogs});
    factory WeeklyDiaryResponse.fromJson(Map<String, dynamic> json) => _$WeeklyDiaryResponseFromJson(json);
    Map<String, dynamic> toJson() => _$WeeklyDiaryResponseToJson(this);

    List<WeeklyDiary>? filter(int year, String month){
        var arr = weeklyLogs?.where((e){
            if(e.year == year && e.month == month){
                return true;
            }
            return false;
        }).toList();
        if(arr == null || arr.isEmpty){
            return [];
        }
        var res = arr.first;
        print("length "+(res?.weeklyLogDetail?.length.toString()??""));
        return res?.weeklyLogDetail ?? [];
    }

}