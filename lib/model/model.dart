import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class WeightCainCalc {
  String monthYear;
  double monthlyGain;
  double totalGain;
  double recGain;
  String percentage;

  factory WeightCainCalc.fromJson(Map<String, dynamic> json) =>
      _$WeightCainCalcFromJson(json);

  Map<String, dynamic> toJson() => _$WeightCainCalcToJson(this);

  WeightCainCalc({
    required this.monthYear,
    required this.monthlyGain,
    required this.totalGain,
    required this.recGain,
    required this.percentage,
  });
}

@JsonSerializable()
class Nutrient {
  Nutrient({
    required this.nutrientName,
    required this.amount,
    required this.unit,
  });

  final String nutrientName;
  final double amount;
  final String unit;

  factory Nutrient.fromJson(Map<String, dynamic> json) =>
      _$NutrientFromJson(json);

  Map<String, dynamic> toJson() => _$NutrientToJson(this);
}

@JsonSerializable()
class RemainingNutrient {
  RemainingNutrient({
    required this.nutrientName,
    required this.remainingNutrient,
    required this.unit,
  });

  final String nutrientName;
  final double remainingNutrient;
  final String unit;

  factory RemainingNutrient.fromJson(Map<String, dynamic> json) =>
      _$RemainingNutrientFromJson(json);

  Map<String, dynamic> toJson() => _$RemainingNutrientToJson(this);
}

class AllNutrients {
  AllNutrients({
    this.calorie,
    this.protein,
    this.carbohydrate,
    this.fiber,
    this.vitaminA,
    this.vitaminC,
    this.vitaminD,
    this.calcium,
    Nutrient? iron,
    this.zinc,
  }) {}

  Nutrient? calorie;
  Nutrient? protein;
  Nutrient? carbohydrate;
  Nutrient? fiber;
  Nutrient? vitaminA;
  Nutrient? vitaminC;
  Nutrient? vitaminD;
  Nutrient? calcium;
  Nutrient? iron;
  Nutrient? zinc;
}

class DiaryWeekCardModel {
  DiaryWeekCardModel({
    required this.nutrients,
    required this.dateStart,
    required this.dateEnd,
    required this.weekNumber,
    required this.month,
    required this.year,
  });

  int weekNumber;
  int dateStart;
  int dateEnd;
  int year;
  String month;
  AllNutrients nutrients;
}
