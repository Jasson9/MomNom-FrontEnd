import 'package:MomNom/model/model.dart';
import 'package:MomNom/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import '../components/dropdown.dart';
import '../components/card.dart';
import 'dart:math';
import '../etc/utils.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  List<String> monthList = DateFormat().dateSymbols.MONTHS;
  String selectedMonth =
      DateFormat().dateSymbols.MONTHS[DateTime.now().month - 1];
  String selectedYear = DateTime.now().year.toString();
  List<String> yearList = [
    (DateTime.now().year - 1).toString(),
    DateTime.now().year.toString(),
    (DateTime.now().year + 1).toString(),
  ];
  Random random = Random();

  List<DiaryWeekCardModel> generateDummyData() {
    int idx = monthList.indexOf(selectedMonth);
    print("mont: " + selectedMonth + " " + idx.toString());
    int year = int.parse(selectedYear);
    print("year ");
    List<List<int>> weeksStartEnd = getWeeksInMonth(year, idx + 1);
    int i = 0;
    return weeksStartEnd.map((e) {
      i += 1;
      return DiaryWeekCardModel(
        year: year,
        dateEnd: e[1],
        dateStart: e[0],
        month: selectedMonth,
        weekNumber: i,
        nutrients: AllNutrients(
          calorie: Nutrient(
            name: "Calorie",
            value: random.nextInt(1000),
            metric: "kcal/day",
          ),
          protein: Nutrient(
            name: "Protein",
            value: random.nextInt(1000),
            metric: "gr/day",
          ),
          carbohydrate: Nutrient(
            name: "Carbohydrate",
            value: random.nextInt(1000),
            metric: "gr/day",
          ),
          fiber: Nutrient(
            name: "Fiber",
            value: random.nextInt(1000),
            metric: "gr/day",
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;
    List<DiaryWeekCardModel> weeklyDiary = generateDummyData();

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.white,
        bottomNavigationBar: CustomNavBar.navbar(context, 1),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Column(
            spacing: 20,
            children: [
              Container(
                width: deviceWidth,
                height: 160,
                decoration: BoxDecoration(color: CustomColor.secondary),
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                child: Column(
                  children: [
                    Text(
                      "Track your meal here!",
                      style: CustomText.subHeading1(
                        color: CustomColor.primaryDarker,
                      ),
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                      style: CustomText.textMd1(
                        color: CustomColor.primaryDarker,
                        bold: true,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: deviceWidth * 0.9,
                child: Column(
                  children: [
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: CustomDropdown.dropdown(
                            monthList,
                            selectedMonth,
                            (value) {
                              setState(() {
                                selectedMonth = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomDropdown.dropdown(
                            yearList,
                            selectedYear,
                            (value) {
                              setState(() {
                                selectedYear = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: deviceWidth * 0.85,
                          child: Text(
                            "$selectedMonth $selectedYear",
                            style: CustomText.subHeading1(
                              color: CustomColor.primaryDarker,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Column(
                          spacing: 8,
                          children:
                              weeklyDiary
                                  .map(
                                    (e) => CustomCard.weeklyFoodDiary(
                                      deviceWidth: deviceWidth,
                                      diaryWeek: e,
                                      context: context,
                                    ),
                                  )
                                  .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
