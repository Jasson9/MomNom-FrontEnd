class Nutrient {
  Nutrient({required this.name, required this.value, required this.metric});

  final String name;
  final int value;
  final String metric;
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
    required this.year
  });

  int weekNumber;
  int dateStart;
  int dateEnd;
  int year;
  String month;
  AllNutrients nutrients;
}
