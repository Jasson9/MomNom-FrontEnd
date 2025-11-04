import 'package:MomNom/model/model.dart';
import 'package:MomNom/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../etc/errorHandler.dart';
import '../etc/requestHandler.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import '../components/dropdown.dart';
import '../components/card.dart';
import 'dart:math';
import '../etc/urlEndpoint.dart';
import '../etc/utils.dart';
import '../model/base.dart';
import '../model/diaryReport.dart';
import 'adddiaryPage.dart';

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
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  late Future<BaseResponse<WeeklyDiaryResponse>> requestedData;
  Key _refreshKey = UniqueKey();

  Future<BaseResponse<WeeklyDiaryResponse>> requestData() async {
    try {
      await isAuthExistAsync(context);
      BaseResponse<WeeklyDiaryResponse> response = BaseResponse.fromJson(
        await RequestHandler.sendRequest(
          url: URLEndpoint.weeklyLogReport,
          useAuth: true,
        ),
        (json) => (WeeklyDiaryResponse.fromJson(json as Map<String, dynamic>)),
      );
      // print(response.data);

      return response;
    } catch (ex) {
      throw customErrorHandler(ex, context);
    }
  }

  @override
  void initState() {
    super.initState();
    requestedData = requestData();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.white,
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            backgroundColor: CustomColor.primary,
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
                  Navigator.pushNamed(
                    context,
                    AddDiaryPage.routeName,
                    arguments: AddDiaryArguments(DateTime.now(), 1),
                  );
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.photo_camera),
                backgroundColor: CustomColor.primary,
                foregroundColor: CustomColor.black,
                label: 'Scan Food',
                onTap: () {
                  isDialOpen.value = false;
                  Navigator.pushNamed(
                    context,
                    AddDiaryPage.routeName,
                    arguments: AddDiaryArguments(DateTime.now(), 2),
                  );
                },
              ),
            ],
          ),
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
                child: FutureBuilder<BaseResponse<WeeklyDiaryResponse>>(
                  future: requestedData,
                  key: _refreshKey,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return errorWidget(snapshot, () {
                        requestedData = requestData();
                        setState(() {});
                      });
                    }

                    if (snapshot.hasData) {
                      return Column(
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
                                    print(
                                      "isempty " +
                                          (snapshot.data?.data
                                                  ?.filter(
                                                    int.parse(selectedYear),
                                                    selectedMonth,
                                                  )
                                                  ?.isEmpty
                                                  .toString() ??
                                              "err"),
                                    );
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
                                    snapshot.data?.data
                                                ?.filter(
                                                  int.parse(selectedYear),
                                                  selectedMonth,
                                                )
                                                ?.isEmpty ==
                                            false
                                        ? snapshot.data!.data!
                                            .filter(
                                              int.parse(selectedYear),
                                              selectedMonth,
                                            )!
                                            .map(
                                              (e) => CustomCard.weeklyFoodDiary(
                                                deviceWidth: deviceWidth,
                                                diaryWeek: e.toWeekCardModel(
                                                  int.parse(selectedYear),
                                                  selectedMonth,
                                                ),
                                                context: context,
                                              ),
                                            )
                                            .toList()
                                        : [
                                          Center(
                                            child: Text(
                                              "No data in this month, how about choose another month?",
                                              textAlign: TextAlign.center,
                                              style: CustomText.textMd1(
                                                bold: true,
                                                color: CustomColor.black,
                                              ),
                                            ),
                                          ),
                                        ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return Center(child: const CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
