import 'package:MomNom/pages/adddiaryPage.dart';
import 'package:MomNom/components/navbar.dart';
import 'package:MomNom/components/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../components/card.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DailyDiaryPage extends StatefulWidget {
  const DailyDiaryPage({super.key});

  static final String routeName = "/dailyDiary";

  @override
  State<DailyDiaryPage> createState() => _DailyDiaryPageState();
}

class DailyDiaryArguments {
  DateTime date;

  DailyDiaryArguments(this.date);
}

class DayDate {
  int date;
  String day;

  DayDate(this.date, this.day);
}

class _DailyDiaryPageState extends State<DailyDiaryPage> {
  // _DailyDiaryPageState({DailyDiaryArguments? args});
  int? selectedDate;
  late DailyDiaryArguments args;
  List<DayDate> listDays = [];
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  void setDate(DateTime val) {
    Navigator.pushReplacementNamed(context, DailyDiaryPage.routeName,arguments: DailyDiaryArguments(val));
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;
    args = ModalRoute.of(context)!.settings.arguments as DailyDiaryArguments;
    // print("Selected date " + selectedDate.toString());

    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          openCloseDial: isDialOpen,
          renderOverlay: false,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.edit),
              backgroundColor: CustomColor.primary,
              foregroundColor: CustomColor.black,
              label: 'Manual Input',
              onTap: () {
                isDialOpen.value = false;
                Navigator.pushNamed(context, AddDiaryPage.routeName,arguments: AddDiaryArguments(args.date, 1));
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.photo_camera),
              backgroundColor: CustomColor.primary,
              foregroundColor: CustomColor.black,
              label: 'Scan Food',
              onTap: () {
                isDialOpen.value = false;
                Navigator.pushNamed(context, AddDiaryPage.routeName,arguments: AddDiaryArguments(args.date, 2));
              },
            ),
          ],
        ),
        backgroundColor: CustomColor.white,
        bottomNavigationBar: CustomNavBar.navbar(context, 1),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: deviceWidth,
                  height: 40,
                  color: CustomColor.secondary,
                ),
                Container(
                  width: deviceWidth,
                  // color: CustomColor.gray,
                  child: Column(
                    spacing: 10,
                    children: [
                      DayWeekPicker.type1(
                        paramDate: args.date,
                        setDate: setDate,
                        devicedWidth: deviceWidth
                      ),
                      CustomCard.dailyFoodDiary3x2(deviceWidth: deviceWidth),
                      CustomCard.dailyFoodDiary3x2(deviceWidth: deviceWidth),
                      CustomCard.dailyFoodDiary3x2(deviceWidth: deviceWidth),
                      CustomCard.dailyFoodDiary3x2(deviceWidth: deviceWidth),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
