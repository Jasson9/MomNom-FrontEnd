import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'button.dart';
import '../etc/styles.dart';
import 'package:intl/intl.dart';
import '../model/model.dart';
import '../pages/dailydiaryPage.dart';
import '../main.dart';
import '../etc/extensions.dart';
import '../etc/utils.dart';

mixin DayWeekPicker {
  static Widget type1({
    required DateTime paramDate,
    required Function(DateTime date) setDate,
    required double devicedWidth
  }) {
    late int startDate;
    late int endDate;
    int year = paramDate.year;
    int month = paramDate.month;
    int selectedDate = paramDate.day;
    List<DayDate> listDays = [];

    void generateListShortDays() {
      List<DayDate> tempListDays = [];
      List<String> listShortDays = List.from(
        DateFormat().dateSymbols.SHORTWEEKDAYS,
      );
      List<int> dates = getWeekDatesOfDate(paramDate);
      startDate = dates[0];
      endDate = dates[1];
      // print("test " + startDate.toString() + "  " + endDate.toString());
      for (int i = startDate ?? 0; i <= (endDate ?? 0); i++) {
        DateTime tempDate = DateTime(year ?? 0, month ?? 0, i);
        int d = tempDate.weekday + 1;
        if (d == 8) {
          d = 1;
        }
        tempListDays.add(DayDate(tempDate.day, listShortDays[d - 1]));
      }
      listDays = tempListDays;
    }

    generateListShortDays();

    void setDateHandler(int date){
      setDate(DateTime(year,month,date));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setDate(
                  DateTime(
                    year,
                    month,
                    startDate,
                  ).subtract(Duration(days: 1)),
                );
              },
              icon: Icon(Icons.navigate_before, size: 40),
            ),
            Text(
              "${DateFormat().dateSymbols.MONTHS[month - 1]} ${year}",
              style: CustomText.subHeading2(color: CustomColor.black),
            ),
            IconButton(
              onPressed: () {
                setDate(
                  DateTime(
                    year,
                    month,
                    endDate,
                  ).add(Duration(days: 1)),
                );
              },
              icon: Icon(Icons.navigate_next, size: 40),
            ),
          ],
        ),

        Container(
          height: 66,
          child: ListView(
              // spacing: 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.center,
              children:
              listDays.map((e) {
                return CustomButton.dateButton(
                  day: e.day,
                  date: e.date,
                  onPress: setDateHandler,
                  selected: selectedDate == e.date,
                );
              }).toList(),
            )
        ),
      ],
    );
  }
}
