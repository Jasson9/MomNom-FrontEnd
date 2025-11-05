import 'package:MomNom/components/dropdown.dart';
import 'package:MomNom/components/navbar.dart';
import 'package:MomNom/components/table.dart';
import 'package:MomNom/components/widget.dart';
import 'package:MomNom/model/addWeight.dart';
import 'package:MomNom/model/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:intl/intl.dart';
import '../etc/errorHandler.dart';
import '../etc/requestHandler.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import 'package:fl_chart/fl_chart.dart';

import '../etc/urlEndpoint.dart';
import '../etc/utils.dart';
import '../model/base.dart';
import '../model/planAnalysis.dart';

// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
// import 'package:fl_chart_app/util/extensions/color_extensions.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  static String routeName = "/plan";

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class PlanArguments {
  DateTime date;
  int tabOption;

  PlanArguments({required this.date, this.tabOption = 1});
}

class _Popup extends StatefulWidget {
  _Popup({
    required this.selectedMonth,
    required this.popupKey,
    required this.selectedYear,
    required this.weight
  });

  String selectedMonth =
  DateFormat().dateSymbols.MONTHS[DateTime
      .now()
      .month - 1];
  int selectedYear = DateTime
      .now()
      .year;
  GlobalKey<CustomPopupState> popupKey;
  double weight;

  @override
  State<_Popup> createState() =>
      __PopupState(
          selectedMonth: selectedMonth,
          popupKey: popupKey,
          selectedYear: selectedYear,
          weight: weight
      );
}

class __PopupState extends State<_Popup> {
  __PopupState({
    required this.selectedMonth,
    required this.popupKey,
    required this.selectedYear,
    required this.weight
  });

  String selectedMonth;
  int selectedYear;
  double weight;
  GlobalKey<CustomPopupState> popupKey;
  bool isLoading = false;

  Future<BaseResponse<MonthlyWeightResponse>>
  addMonthSave() async {
    try {
      if (selectedYear == 0) {
        throw ValidationException("Invalid year");
      }
      if (selectedMonth == "" ||
          !DateFormat().dateSymbols.MONTHS.contains(selectedMonth)) {
        throw ValidationException("Invalid Month");
      }
      if (weight == 0) {
        throw ValidationException("invalid Weight");
      }

      setState(() {
        isLoading = true;
      });

      await isAuthExistAsync(context);
      BaseResponse<MonthlyWeightResponse> response =
      BaseResponse.fromJson(
        await RequestHandler.sendRequest(
            url: URLEndpoint.addWeightPlanProgress,
            useAuth: true,
            item: AddWeightRequest(
                month: DateFormat().dateSymbols.MONTHS.indexOf(selectedMonth) +
                    1,
                year: selectedYear,
                weight: weight
            )
        ),
            (json) =>
        (MonthlyWeightResponse.fromJson(
          json as Map<String, dynamic>,
        )),
      );
      setState(() {
        isLoading = false;
      });
      return response;
    } catch (ex) {
      setState(() {
        isLoading = false;
      });
      throw customErrorHandler(ex, context);
    }

  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery
        .sizeOf(context)
        .width;
    double deviceHeight = MediaQuery
        .sizeOf(context)
        .height;
    return Container(
      width: deviceWidth * 0.6,
      height: 240,
      padding: EdgeInsets.all(8),
      color: CustomColor.tertiary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10,
        children: [
          Column(
            spacing: 10,
            children: [
              CustomDropdown.dropdown(
                DateFormat().dateSymbols.MONTHS,
                selectedMonth,
                    (val) {
                  setState(() {
                    selectedMonth = val!;
                  });
                },
              ),
              CustomDropdown.dropdown(
                [
                  (DateTime
                      .now()
                      .year - 1).toString(),
                  DateTime
                      .now()
                      .year
                      .toString(),
                  (DateTime
                      .now()
                      .year + 1).toString(),
                ],
                selectedYear.toString(),
                    (val) {
                  setState(() {
                    selectedYear = int.parse(val ?? "");
                  });
                },
              ),
              CustomTextField.inputWithMetrics(
                  placeholder: 40,
                  metricsText: "kg",
                  onChanged: (e) {
                    setState(() {
                      weight = e;
                    });
                  }
              ),
            ],
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                CustomButton.secondary(
                  text: "Save",
                  colorFill: CustomColor.primary,
                  colorText: CustomColor.black,
                  onPress: () async {
                    await addMonthSave();
                    Navigator.popAndPushNamed(
                      context,
                      PlanPage.routeName,
                      arguments: PlanArguments(date: DateTime.now(), tabOption: 2),
                    );
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
          ),
        ],
      ),
    );
  }
}

class _PlanPageState extends State<PlanPage> {
  late List<BarChartGroupData> showingBarGroups;
  late Future<BaseResponse<NutrientPlanProgressResponse>>
  requestedDataNutrients;
  late Future<BaseResponse<MonthlyWeightResponse>> requestedDataWeight;
  Key _refreshKeyNutrient = UniqueKey();
  Key _refreshKeyWeight = UniqueKey();
  late PlanArguments args;
  final double width = 24;
  // late int tabOption;
  String selectedMonth =
  DateFormat().dateSymbols.MONTHS[DateTime
      .now()
      .month - 1];
  int selectedYear = DateTime
      .now()
      .year;

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      showingTooltipIndicators: [0, 1],
      barsSpace: 8,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: CustomColor.primaryDark,
          width: width,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        BarChartRodData(
          toY: y2,
          color: CustomColor.secondary,
          width: width,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }

  List<LineChartBarData> createLineCharBarData(List<double> progressData,
      double startingWeight,
      double finaltargetWeight,) {
    int i1 = 1;
    int i2 = 1;

    LineChartBarData progressChartData = LineChartBarData(
      color: CustomColor.primary,
      // showingIndicators: [0],
      barWidth: 2,
      isStrokeCapRound: true,
      // showingIndicators: [0, 1, 2],
      dotData: FlDotData(
        show: true,
        getDotPainter: (p0, p1, p2, p3) {
          return FlDotCirclePainter(radius: 8, color: CustomColor.secondary);
        },
      ),
      spots:
      progressData.map((e) {
        FlSpot res = FlSpot((i1.toDouble()), e);
        i1++;
        return res;
      }).toList(),
    );
    LineChartBarData goalChartData = LineChartBarData(
      color: CustomColor.primaryDark,
      // showingIndicators: [0, 1],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (p0, p1, p2, p3) {
          return FlDotCirclePainter(radius: 8, color: CustomColor.primaryDark);
        },
      ),
      spots: [FlSpot((1), startingWeight), FlSpot((8), finaltargetWeight)],
    );

    return [progressChartData, goalChartData];
  }

  final popupKey = GlobalKey<CustomPopupState>();
  final anchorKey = GlobalKey<CustomPopupState>();

  Future<BaseResponse<NutrientPlanProgressResponse>>
  requestDataNutrient() async {
    try {
      await isAuthExistAsync(context);
      BaseResponse<NutrientPlanProgressResponse> response =
      BaseResponse.fromJson(
        await RequestHandler.sendRequest(
          url: URLEndpoint.nutrientPlanProgress,
          useAuth: true,
          item: NutrientPlanProgressRequest(
            date: DateFormat("yyyy-MM-dd").format(args.date),
          ),
        ),
            (json) =>
        (NutrientPlanProgressResponse.fromJson(
          json as Map<String, dynamic>,
        )),
      );

      return response;
    } catch (ex) {
      throw customErrorHandler(ex, context);
    }
  }

  Future<BaseResponse<MonthlyWeightResponse>> requestDataWeight() async {
    try {
      await isAuthExistAsync(context);
      BaseResponse<MonthlyWeightResponse> response = BaseResponse.fromJson(
        await RequestHandler.sendRequest(
          url: URLEndpoint.weightPlanProgress,
          useAuth: true,
        ),
            (json) =>
        (MonthlyWeightResponse.fromJson(json as Map<String, dynamic>)),
      );

      return response;
    } catch (ex) {
      throw customErrorHandler(ex, context);
    }
  }

  Widget monthlyWeight(BuildContext context, double deviceWidth) {
    CustomPopup popup = CustomPopup(
      showArrow: true,
      key: popupKey,
      anchorKey: anchorKey,
      arrowColor: CustomColor.tertiary,
      backgroundColor: CustomColor.tertiary,
      content: _Popup(
        selectedMonth: selectedMonth,
        popupKey: popupKey,
        selectedYear: selectedYear,
        weight: 0,
      ),
      child: Text(
        "+ Add new weight here!",
        style: CustomText.textMd1(
          color: CustomColor.primaryDarker,
          bold: true,
          decor: TextDecoration.underline,
        ),
      ),
    );

    // popupKey.currentState?.didUpdateWidget(popup);
    print("Draw " + selectedMonth);
    int i = 0;
    return FutureBuilder<BaseResponse<MonthlyWeightResponse>>(
      future: requestedDataWeight,
      key: _refreshKeyWeight,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorWidget(snapshot, () {
            requestedDataWeight = requestDataWeight();
            setState(() {});
          });
        }

        if (snapshot.hasData) {
          // List<double> progressData = [40, 42, 44, 45, 45, 46, 46, 47, 48];
          List<double>? progressData =
          snapshot?.data?.data?.weightGainProgress
              ?.map((e) => e.totalGain)
              .toList();
          List<LineChartBarData> chartData = createLineCharBarData(
            progressData ?? [],
            progressData?.first ?? 0,
            snapshot?.data?.data?.weightGainProgress[0].recGain ?? 0,
          );

          return Container(
            width: deviceWidth * 0.9,
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You can do it!",
                      style: CustomText.subHeading1(
                        color: CustomColor.primaryDark,
                      ),
                    ),
                    Text(
                      "Keep a steady weight for healthy pregnancy!",
                      style: CustomText.subHeading3(
                        color: CustomColor.secondary,
                      ),
                    ),
                  ],
                ),
                popup,
                Row(
                  spacing: 8,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      color: CustomColor.primaryDark,
                    ),
                    Text(
                      "Your Goal",
                      style: CustomText.text1(color: CustomColor.black),
                    ),
                    Container(
                      width: 16,
                      height: 16,
                      color: CustomColor.secondary,
                    ),
                    Text(
                      "Your Progress",
                      style: CustomText.text1(color: CustomColor.black),
                    ),
                  ],
                ),
                Container(
                  height: 360,
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(width: 2, color: CustomColor.gray),
                          left: BorderSide(width: 2, color: CustomColor.gray),
                        ),
                      ),
                      titlesData: FlTitlesData(
                        rightTitles: AxisTitles(),
                        topTitles: AxisTitles(),
                        leftTitles: AxisTitles(),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 24,
                            getTitlesWidget: (value, meta) {
                              var month =
                              snapshot
                                  ?.data
                                  ?.data
                                  ?.weightGainProgress[0]
                                  .monthYear
                                  .split(" ")[0];
                              var initMonth = DateFormat().dateSymbols.MONTHS
                                  .indexOf(month!);
                              // String label =
                              //     DateFormat()
                              //         .dateSymbols
                              //         .SHORTMONTHS[value.round() - 1];
                              String label =
                              DateFormat()
                                  .dateSymbols
                                  .SHORTMONTHS[(initMonth +
                                  value.round() -
                                  1) %
                                  12];
                              // String label = snapshot?.data?.data?.weightGainProgress[value.round()].monthYear.substring(0,3) ?? "";
                              return Container(
                                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: Text(
                                  label,
                                  style: CustomText.text1(
                                    color: CustomColor.black,
                                    bold: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      lineBarsData: chartData,
                      showingTooltipIndicators: [
                        ...chartData[0].spots.map((e) {
                          // print(chartData[1]);
                          ShowingTooltipIndicators res =
                          ShowingTooltipIndicators([
                            LineBarSpot(chartData[0], i++, e),
                          ]);
                          print("count " + i.toString());
                          return res;
                        }).toList(),
                        ShowingTooltipIndicators([
                          LineBarSpot(chartData[1], i++, chartData[1].spots[1]),
                        ]),
                      ],
                      lineTouchData: LineTouchData(
                        enabled: false,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (b) {
                            return Colors.transparent;
                          },
                          tooltipPadding: EdgeInsets.symmetric(vertical: 10),
                          tooltipMargin: 0,
                          getTooltipItems: (e) {
                            return e.map((e) {
                              if (e.x.toInt() - 1 == 0) {
                                return LineTooltipItem("", TextStyle());
                              }
                              double val = 0;
                              int idx = e.x.toInt();
                              if (e.bar.color == CustomColor.primaryDark) {
                                val =
                                ((snapshot
                                    ?.data
                                    ?.data
                                    ?.weightGainProgress[0]
                                    .recGain ??
                                    0) -
                                    (progressData?.first ?? 0));
                              } else {
                                val =
                                (progressData?[idx - 1] ??
                                    0 - (progressData?[idx - 2] ?? 0));
                              }

                              return LineTooltipItem(
                                (val >= 0 ? "+" : "") + val.toString() + " kg",
                                CustomText.text1(color: CustomColor.black),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "*The figure above shows your weight gain each month, while the table below shows your total weight gain each month",
                  style: CustomText.text1(color: CustomColor.black),
                ),
                CustomTable.defaultTable([
                  ["", "Goal", "Progress"],
                  ...?snapshot?.data?.data?.weightGainProgress.map(
                        (e) =>
                    [
                      e.monthYear.split(" ")[0],
                      "${e.totalGain} kg/${e.recGain} kg",
                      "${e.percentage}%",
                    ],
                  ),
                ]),
              ],
            ),
          );
        }
        return Center(child: const CircularProgressIndicator());
      },
    );
  }

  Widget dailyNutrients(BuildContext context, double deviceWidth) {
    return Column(
      children: [
        Container(
          width: deviceWidth,
          child: DayWeekPicker.type1(
            paramDate: args.date,
            setDate: changeDate,
            devicedWidth: deviceWidth,
          ),
        ),
        FutureBuilder<BaseResponse<NutrientPlanProgressResponse>>(
          future: requestedDataNutrients,
          key: _refreshKeyNutrient,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorWidget(snapshot, () {
                requestedDataNutrients = requestDataNutrient();
                setState(() {});
              });
            }

            if (snapshot.hasData) {
              NutrientPlanProgress? calorie =
                  snapshot.data?.data?.nutrientPlanProgresses
                      .where((e) => e.nutrientName == "Calories")
                      .firstOrNull;
              NutrientPlanProgress? protein =
                  snapshot.data?.data?.nutrientPlanProgresses
                      .where((e) => e.nutrientName == "Protein")
                      .firstOrNull;
              NutrientPlanProgress? carbohydrate =
                  snapshot.data?.data?.nutrientPlanProgresses
                      .where((e) => e.nutrientName == "Carbohydrate")
                      .firstOrNull;
              NutrientPlanProgress? fiber =
                  snapshot.data?.data?.nutrientPlanProgresses
                      .where((e) => e.nutrientName == "Fiber")
                      .firstOrNull;
              var nutrients = [calorie, protein, carbohydrate, fiber];

              showingBarGroups =
                  nutrients
                      .asMap()
                      .entries
                      .map((entry) {
                    print(entry.value?.nutrientAmount);
                    return makeGroupData(
                      entry.key,
                      entry.value?.goalAmount ?? 0,
                      entry.value?.nutrientAmount ?? 0,
                    );
                  }).toList();

              return Column(
                children: [
                  Container(
                    width: deviceWidth * 0.9,
                    child: Column(
                      spacing: 0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Keep it up!",
                          style: CustomText.subHeading1(
                            color: CustomColor.primaryDark,
                          ),
                        ),
                        Text(
                          "You almost reach today’s nutrient goal!!",
                          style: CustomText.subHeading3(
                            color: CustomColor.secondary,
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: CustomColor.primaryDark,
                            ),
                            Text(
                              "Your Goal",
                              style: CustomText.text1(color: CustomColor.black),
                            ),
                            Container(
                              width: 16,
                              height: 16,
                              color: CustomColor.secondary,
                            ),
                            Text(
                              "Your Progress",
                              style: CustomText.text1(color: CustomColor.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: deviceWidth * 0.9,
                    child: Column(
                      spacing: 10,
                      children: [
                        Container(
                          height: 320,
                          margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: BarChart(
                            // duration: Duration(milliseconds: 500),
                            BarChartData(
                              borderData: FlBorderData(
                                border: Border(
                                  left: BorderSide(
                                    color: CustomColor.gray,
                                    width: 2,
                                  ),
                                  bottom: BorderSide(
                                    color: CustomColor.gray,
                                    width: 2,
                                  ),
                                ),
                              ),
                              // maxY: maxValue + 25,
                              barTouchData: BarTouchData(
                                enabled: false,
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: (b) {
                                    return Colors.transparent;
                                  },
                                  tooltipPadding: EdgeInsets.all(0),
                                  tooltipMargin: 0,
                                  getTooltipItem: (group,
                                      groupIndex,
                                      rod,
                                      rodIndex,) {
                                    return BarTooltipItem(
                                      rod.toY.round().toString(),
                                      CustomText.text1(
                                        color: CustomColor.black,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              barGroups: showingBarGroups,
                              titlesData: FlTitlesData(
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 36,
                                    getTitlesWidget: (value, meta) {
                                      String label = "";
                                      String metrics = "";
                                      var d = nutrients[value.toInt()];
                                      label = d?.nutrientName ?? "";
                                      metrics = d?.unit ?? "";
                                      return Column(
                                        children: [
                                          Text(
                                            label,
                                            style: CustomText.text1(
                                              color: CustomColor.black,
                                              bold: true,
                                            ),
                                          ),
                                          Text(
                                            metrics,
                                            style: CustomText.text1(
                                              color: CustomColor.black,
                                              bold: true,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                // bottomTitles: AxisTitles(axisNameWidget: Text("test"))
                              ),
                            ),
                          ),
                        ),
                        CustomTable.defaultTable([
                          ["", "Goal", "Progress"],
                          ...?snapshot.data?.data?.nutrientPlanProgresses.map((
                              e,) {
                            return [
                              e.nutrientName ?? "",
                              "${e.goalAmount} ${e.unit}",
                              "${e.nutrientAmount} ${e.unit}",
                            ];
                          }),
                        ]),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(child: const CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   tabOption = args.tabOption;
    // });
    // if(tabOption == 1){
    //   requestedDataNutrients = requestDataNutrient();
    // }else{
    //   requestedDataWeight = requestDataWeight();
    // }
  }

  void changeDate(DateTime val) {
    Navigator.pushReplacementNamed(
      context,
      "/plan",
      arguments: PlanArguments(date: val),
    );
  }

  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery
        .sizeOf(context)
        .width;
    double deviceHeight = MediaQuery
        .sizeOf(context)
        .height;
    args = ModalRoute
        .of(context)!
        .settings
        .arguments as PlanArguments;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.white,
        bottomNavigationBar: CustomNavBar.navbar(context, 3),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              spacing: 12,
              children: [
                Container(
                  width: deviceWidth,
                  height: 40,
                  color: CustomColor.secondary,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  width: deviceWidth,
                  child: Column(
                    spacing: 8,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 2,
                                  color: CustomColor.gray,
                                ),
                              ),
                              boxShadow:
                              args.tabOption == 1
                                  ? <BoxShadow>[
                                BoxShadow(
                                  color: CustomColor.lightGray,
                                  blurRadius: 20,
                                  // blurStyle: BlurStyle.inner,
                                  spreadRadius: 0.5,
                                ),
                              ]
                                  : null,
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (args.tabOption != 1) args.tabOption = 1;
                                });
                              },
                              child: Text(
                                "Daily Nutrients",
                                style: CustomText.subHeading3(
                                  color: CustomColor.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              boxShadow:
                              args.tabOption == 2
                                  ? <BoxShadow>[
                                BoxShadow(
                                  color: CustomColor.lightGray,
                                  blurRadius: 20,
                                  // blurStyle: BlurStyle.inner,
                                  spreadRadius: 0.5,
                                ),
                              ]
                                  : null,
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (args.tabOption != 2) args.tabOption = 2;
                                });
                              },
                              child: Text(
                                "Monthly Weight",
                                style: CustomText.subHeading3(
                                  color: CustomColor.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      args.tabOption == 1
                          ? (){
                        requestedDataNutrients = requestDataNutrient();
                        return dailyNutrients(context, deviceWidth);
                      }()
                          : () {
                        requestedDataWeight = requestDataWeight();
                        return monthlyWeight(context, deviceWidth);
                      }(),
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
