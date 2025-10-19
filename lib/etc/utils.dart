import 'package:MomNom/etc/extensions.dart';
import 'package:MomNom/model/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PageRouteProperty implements Widget{
  final String routeName = "";
}

int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;

  // Adjust age if the birth month or day hasn't occurred yet in the current year
  if (currentDate.month < birthDate.month ||
      (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
    age--;
  }
  return age;
}

void isAuthExist(context){
  SharedPreferences.getInstance().then((e){
    if(e.containsKey("authToken") == false || e.getString("authToken") == ""){
      Navigator.pushReplacementNamed(context, "/login");
    }
  });
}
Future<void> isAuthExistAsync(context)async{
  var e = await SharedPreferences.getInstance();
  if(e.containsKey("authToken") == false || e.getString("authToken") == ""){
    Navigator.pushReplacementNamed(context, "/login");
    throw EmptyAuthException();
  }
}


double getConstrainedWidth(BuildContext context, double decimalWidth, {double? minWidth, double? maxWidth} ){
  double deviceWidth = MediaQuery.sizeOf(context).width;

  if(minWidth != null && maxWidth!=null && minWidth > maxWidth){
    throw Exception("MinWidth cannot be more than Max Width");
  }

  double widthRes = decimalWidth * deviceWidth;

  if( maxWidth!=null && widthRes > maxWidth){
    widthRes = maxWidth;
  }
  if(minWidth!=null && widthRes < minWidth){
    widthRes = minWidth;
  }
  return widthRes;
}

List<List<int>> getWeeksInMonth(int year, int month) {
  List<List<int>> weeks = [
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
  ];
  DateTime firstDayOfMonth = DateTime(year, month, 1);
  DateTime lastDayOfMonth = DateTime(
    year,
    month + 1,
    0,
  ); // Day 0 of next month gives last day of current month

  // Find the first day of the week containing the first day of the month
  DateTime currentDay = firstDayOfMonth.subtract(
    Duration(days: firstDayOfMonth.weekday - 1),
  );

  int k = 0;
  print(lastDayOfMonth.day);
  for (int i = 0; i <= lastDayOfMonth.day; i++) {
    if (currentDay.weekday == 7) {
      // Only add days belonging to the target month
      // week.add(currentDay.weekday);
      weeks[k][0] = currentDay.day;
    }
    if (currentDay.weekday == 6) {
      // week.add(currentDay.weekday);
      if (weeks[k][0] == 0) {
        weeks[k][0] = 1;
      }
      weeks[k][1] = currentDay.day;
      print(
        "date " +
            weeks[k][0].toString() +
            " " +
            weeks[k][1].toString() +
            " " +
            currentDay.toString(),
      );
      k += 1;
    }

    if (i == lastDayOfMonth.day) {
      weeks[k][1] = lastDayOfMonth.day;
      break;
    }

    currentDay = currentDay.add(Duration(days: 1));
  }
  return weeks;
}

List<int> getWeekDatesOfDate(DateTime currDate) {
  List<int> results = [];
  int year = currDate.year;
  int month = currDate.month;
  int date = currDate.day;
  int weekday = currDate.weekday.toIntWeekDays();
  // print("selected date " + selectedDate.toString());
  int startWeekdayDate = date - (weekday - 1);
  int coeff = 0;

  if (startWeekdayDate <= 0) {
    coeff = -(startWeekdayDate - 1);
    startWeekdayDate = 1;
  }
  int endWeekdayDate = startWeekdayDate + 6 - coeff;

  if (DateTime(year, month, endWeekdayDate).month > currDate.month) {
    endWeekdayDate = DateTime(year, month + 1, 0).day;
  }
  results.add(startWeekdayDate);
  results.add(endWeekdayDate);

  return results;
}