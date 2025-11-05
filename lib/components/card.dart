import 'package:MomNom/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'button.dart';
import '../etc/styles.dart';
import 'package:intl/intl.dart';
import '../model/model.dart';
import '../pages/dailydiaryPage.dart';
import '../main.dart';

class _Popup extends StatefulWidget {
  _Popup();

  @override
  State<_Popup> createState() => __PopupState();
}

class __PopupState extends State<_Popup> {
  __PopupState();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;
    return Container(
      width: deviceWidth * 0.6,
      height: 240,
      padding: EdgeInsets.all(8),
      color: CustomColor.tertiary,
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 10,
            children: [
              CustomTextField.dateTimeForm(context: context, outline: false),
              CustomTextField.grayMultiLines(placeholder: "Input Description"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CustomButton.secondary(
                text: "Save",
                colorFill: CustomColor.primary,
                colorText: CustomColor.black,
                onPress: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomButton.secondary(
                text: "Cancel",
                colorFill: CustomColor.primary,
                colorText: CustomColor.black,
                onPress: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final popupKey = GlobalKey<CustomPopupState>();

mixin CustomCard implements Card {
  static Widget exerciseExpandedCard() {
    CustomPopup popup = CustomPopup(
      showArrow: true,
      // key: popupKey,
      arrowColor: CustomColor.tertiary,
      backgroundColor: CustomColor.tertiary,
      content: _Popup(),
      child: Container(
        child: Text(
          textAlign: TextAlign.right,
          "Edit ->",
          style: CustomText.text1(
            color: CustomColor.black,
            decor: TextDecoration.underline,
          ),
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: CustomColor.secondary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ExpansionTile(
        title: Text(
          "2 August 2025 - Week 1",
          style: CustomText.text1(color: CustomColor.primaryDarker, bold: true),
        ),
        // ,backgroundColor: CustomColor.secondary,collapsedBackgroundColor: CustomColor.secondary,
        shape: Border(),
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "description asdh askj dhaskj hdsakj hdakdjs ads da sdas das das das d asda",
                ),
                popup,
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget exerciseExpandedCard2({
    required List<List<TextEditingController>> controllers,
    VoidCallback? onAddItem,
    ValueChanged<int>? onDeleteItem,
    required DateTime date,
    required BuildContext context,
    required ValueChanged<DateTime> onDateChange,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.secondary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ExpansionTile(
        title: CustomTextField.dateTimeForm(
          context: context,
          filled: true,
          value: date,
          onDateTimeChanged: onDateChange,
        ),
        // Text(
        //   "2 August 2025 - Week 1",
        //   style: CustomText.text1(color: CustomColor.primaryDarker, bold: true),
        // ),
        // ,backgroundColor: CustomColor.secondary,collapsedBackgroundColor: CustomColor.secondary,
        shape: Border(),
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  controllers.asMap().entries.map((e) {
                    return CustomTextField().multiFieldInput2(
                      onAdd: onAddItem,
                      onDelete: () => onDeleteItem!(e.key),
                      controller1: e.value[0],
                      controller2: e.value[1],
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  static Container dailyFoodDiary3x2({
    required double deviceWidth,
    required List<Nutrient> nutrients,
    required String foodName,
    required double amount,
  }) {
    Nutrient? calorie =
        nutrients.where((e) => e.nutrientName == "Calorie").firstOrNull;
    Nutrient? protein =
        nutrients.where((e) => e.nutrientName == "Protein").firstOrNull;
    Nutrient? iron =
        nutrients.where((e) => e.nutrientName == "Iron").firstOrNull;
    Nutrient? carbohydrate =
        nutrients.where((e) => e.nutrientName == "Carbohydrate").firstOrNull;
    Nutrient? fiber =
        nutrients.where((e) => e.nutrientName == "Fiber").firstOrNull;
    Nutrient? calcium =
        nutrients.where((e) => e.nutrientName == "Calcium").firstOrNull;

    return Container(
      width: deviceWidth * 0.9,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: CustomColor.primaryDarker,
      ),
      child: Column(
        spacing: 10,
        children: [
          SizedBox(
            width: deviceWidth * 0.8,
            child: Text(
              "$foodName - ${amount.round()}gr",
              textAlign: TextAlign.left,
              style: CustomText.subHeading3(color: CustomColor.tertiary),
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: CustomColor.white, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 90,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Column(
                        children: [
                          Text(
                            "Calorie",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${calorie?.amount ?? ""} ${calorie?.unit ?? ""}",
                            // "",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: CustomColor.white, width: 1),
                          left: BorderSide(color: CustomColor.white, width: 1),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Column(
                        children: [
                          Text(
                            "Protein",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${protein?.amount ?? ""} ${protein?.unit ?? ""}",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Column(
                        children: [
                          Text(
                            "Iron",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${iron?.amount ?? ""} ${iron?.unit ?? ""}",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 90,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Column(
                        children: [
                          Text(
                            "Carbohydrate",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${carbohydrate?.amount ?? ""} ${carbohydrate?.unit ?? ""}",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: CustomColor.white, width: 1),
                          left: BorderSide(color: CustomColor.white, width: 1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Fiber",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${fiber?.amount ?? ""} ${fiber?.unit ?? ""}",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Column(
                        children: [
                          Text(
                            "Calcium",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${calcium?.amount ?? ""} ${calcium?.unit ?? ""}",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget tipsCard(String text) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.tertiary,
        border: Border.all(color: CustomColor.primary),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      width: 300,
      height: 160,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                "“$text”",
                style: CustomText.text1(
                  color: CustomColor.primaryDarker,
                  bold: true,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget dailyFoodDiary2x2({
    required double deviceWidth,
    required List<Nutrient> nutrients,
    required String foodName,
    required double amount,
  }) {
    Nutrient? calorie =
        nutrients.where((e) => e.nutrientName == "Calorie").firstOrNull;
    Nutrient? protein =
        nutrients.where((e) => e.nutrientName == "Protein").firstOrNull;
    Nutrient? carbohydrate =
        nutrients.where((e) => e.nutrientName == "Carbohydrate").firstOrNull;
    Nutrient? fiber =
        nutrients.where((e) => e.nutrientName == "Fiber").firstOrNull;
    return Container(
      width: 240,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: CustomColor.primaryDarker,
      ),
      child: Column(
        spacing: 10,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              "$foodName - ${amount.round()}gr",
              textAlign: TextAlign.left,
              style: CustomText.subHeading3(color: CustomColor.tertiary),
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: CustomColor.white, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: CustomColor.white, width: 1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Calorie",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${calorie?.amount ?? ""} ${calorie?.unit ?? ""}",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Column(
                        children: [
                          Text(
                            "Protein",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${protein?.amount ?? ""} ${protein?.unit ?? ""}",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: CustomColor.white, width: 1),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Column(
                        children: [
                          Text(
                            "Carbohydrate",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${carbohydrate?.amount ?? ""} ${carbohydrate?.unit ?? ""}",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Column(
                        children: [
                          Text(
                            "Fiber",
                            style: CustomText.text1(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                          Text(
                            "${fiber?.amount ?? ""} ${fiber?.unit ?? ""}",
                            style: CustomText.text3(
                              color: CustomColor.white,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget weeklyFoodDiary({
    required double deviceWidth,
    required DiaryWeekCardModel diaryWeek,
    required context,
  }) {
    print("week num " + diaryWeek.weekNumber.toString());
    return InkWell(
      onTap:
          () => {
            Navigator.pushNamed(
              context,
              DailyDiaryPage.routeName,
              arguments: DailyDiaryArguments(
                DateTime(
                  diaryWeek.year,
                  DateFormat().dateSymbols.MONTHS.indexOf(diaryWeek.month) + 1,
                  diaryWeek.dateStart,
                ),
              ),
            ),
          },
      child: Card(
        borderOnForeground: true,
        child: Container(
          width: deviceWidth * 0.9,
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(
                "assets/images/FoodBg" +
                    diaryWeek.weekNumber.toString() +
                    ".png",
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                CustomColor.darkGray,
                BlendMode.multiply,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 20,
            children: [
              Container(
                width: 300,
                margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diaryWeek != null
                          ? "Week " + diaryWeek.weekNumber.toString()
                          : "",
                      style: CustomText.subHeading2(
                        color: CustomColor.tertiary,
                      ),
                    ),
                    Text(
                      diaryWeek != null
                          ? diaryWeek.dateStart.toString() +
                              " - " +
                              diaryWeek.dateEnd.toString() +
                              " " +
                              diaryWeek.month
                          : "",
                      style: CustomText.subHeading4(
                        color: CustomColor.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              diaryWeek != null
                  ? Expanded(
                    flex: 1,
                    child: Container(
                      // height: 100,
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: CustomColor.gray,
                        backgroundBlendMode: BlendMode.multiply,
                      ),
                      child: Column(
                        spacing: 20,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    diaryWeek.nutrients.calorie?.nutrientName ??
                                        "",
                                    style: CustomText.textMd1(
                                      color: CustomColor.white,
                                      bold: true,
                                    ),
                                  ),
                                  Text(
                                    (diaryWeek.nutrients.calorie?.amount
                                                .toString() ??
                                            "") +
                                        " ${diaryWeek.nutrients.calorie?.unit ?? ""}",
                                    style: CustomText.text1(
                                      color: CustomColor.white,
                                      bold: true,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    diaryWeek.nutrients.protein?.nutrientName ??
                                        "",
                                    style: CustomText.textMd1(
                                      color: CustomColor.white,
                                      bold: true,
                                    ),
                                  ),
                                  Text(
                                    (diaryWeek.nutrients.protein?.amount
                                                .toString() ??
                                            "") +
                                        " ${diaryWeek.nutrients.protein?.unit ?? ""}",
                                    style: CustomText.text1(
                                      color: CustomColor.white,
                                      bold: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    diaryWeek
                                            .nutrients
                                            .carbohydrate
                                            ?.nutrientName ??
                                        "",
                                    style: CustomText.textMd1(
                                      color: CustomColor.white,
                                      bold: true,
                                    ),
                                  ),
                                  Text(
                                    (diaryWeek.nutrients.carbohydrate?.amount
                                                .toString() ??
                                            "") +
                                        " ${diaryWeek.nutrients.carbohydrate?.unit ?? ""}",
                                    style: CustomText.text1(
                                      color: CustomColor.white,
                                      bold: true,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    diaryWeek.nutrients.fiber?.nutrientName ??
                                        "",
                                    style: CustomText.textMd1(
                                      color: CustomColor.white,
                                      bold: true,
                                    ),
                                  ),
                                  Text(
                                    (diaryWeek.nutrients.fiber?.amount
                                                .toString() ??
                                            "") +
                                        " ${diaryWeek.nutrients.fiber?.unit ?? ""}",
                                    style: CustomText.text1(
                                      color: CustomColor.white,
                                      bold: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  : SizedBox(),
            ],
          ), // child:
        ),
      ),
    );
  }
}
