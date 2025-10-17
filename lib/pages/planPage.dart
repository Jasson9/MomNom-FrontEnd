import 'package:MomNom/components/dropdown.dart';
import 'package:MomNom/components/navbar.dart';
import 'package:MomNom/components/table.dart';
import 'package:MomNom/components/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:intl/intl.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import 'package:fl_chart/fl_chart.dart';

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

  PlanArguments({required this.date});
}

class _Popup extends StatefulWidget {
  _Popup({required this.selectedMonth, required this.popupKey});

  String selectedMonth =
      DateFormat().dateSymbols.MONTHS[DateTime.now().month - 1];
  GlobalKey<CustomPopupState> popupKey;

  @override
  State<_Popup> createState() =>
      __PopupState(selectedMonth: selectedMonth, popupKey: popupKey);
}

class __PopupState extends State<_Popup> {
  __PopupState({required this.selectedMonth, required this.popupKey});

  String selectedMonth;
  GlobalKey<CustomPopupState> popupKey;

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
              CustomTextField.inputWithMetrics(placeholder: 40, metricsText: "kg"),
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
          ),
        ],
      ),
    );
  }
}

class _PlanPageState extends State<PlanPage> {
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late PlanArguments args;
  double maxValue = 175;
  final double width = 24;
  int tabOption = 1;
  String selectedMonth =
      DateFormat().dateSymbols.MONTHS[DateTime.now().month - 1];

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

  List<LineChartBarData> createLineCharBarData(
    List<double> progressData,
    List<double> goalData,
  ) {
    int i1 = 1;
    int i2 = 1;

    LineChartBarData progressChartData = LineChartBarData(
      color: CustomColor.primaryDark,
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
      spots:
          goalData.map((e) {
            FlSpot res = FlSpot((i2.toDouble()), e);
            i2++;
            return res;
          }).toList(),
    );

    return [progressChartData, goalChartData];
  }

  final popupKey = GlobalKey<CustomPopupState>();
  final anchorKey = GlobalKey<CustomPopupState>();

  Widget monthlyWeight(BuildContext context, double deviceWidth) {
    List<double> progressData = [40, 42, 44, 45, 45, 46, 46, 47, 48];
    List<double> goalData = [40, 41, 42, 44, 45, 46, 47, 48, 48];
    List<LineChartBarData> chartData = createLineCharBarData(
      progressData,
      goalData,
    );

    CustomPopup popup = CustomPopup(
      showArrow: true,
      key: popupKey,
      anchorKey: anchorKey,
      arrowColor: CustomColor.tertiary,
      backgroundColor: CustomColor.tertiary,
      content: _Popup(selectedMonth: selectedMonth, popupKey: popupKey),
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
    return Column(
      children: [
        Container(
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
                    style: CustomText.subHeading3(color: CustomColor.secondary),
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
                            String label =
                                DateFormat()
                                    .dateSymbols
                                    .SHORTMONTHS[value.round() - 1];
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
                    showingTooltipIndicators:
                        chartData[0].spots.map((e) {
                          ShowingTooltipIndicators res =
                              ShowingTooltipIndicators([
                                LineBarSpot(chartData[0], i++, e),
                              ]);
                          print("count " + i.toString());
                          return res;
                        }).toList(),
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
                            int val = 0;
                            int idx = e.x.toInt();
                            val =
                                (progressData[idx - 1] - goalData[idx - 1])
                                    .round();
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
                "*The numbers above show the difference between your weight and your goal",
                style: CustomText.text1(color: CustomColor.black),
              ),
              CustomTable.defaultTable([
                ["", "Goal", "Progress"],
                ["August", "50 kg", "50 kg"],
                ["September", "55 kg", "55 kg"],
                ["October", "60 kg", "60 kg"],
                ["November", "60 kg", "65 kg"],
                ["December", "65 kg", "58 kg"],
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget dailyNutrients(BuildContext context, double deviceWidth) {
    return Column(
      children: [
        Container(
          width: deviceWidth,
          child: DayWeekPicker.type1(paramDate: args.date, setDate: changeDate, devicedWidth: deviceWidth),
        ),
        Container(
          width: deviceWidth * 0.9,
          child: Column(
            spacing: 0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Keep it up!",
                style: CustomText.subHeading1(color: CustomColor.primaryDark),
              ),
              Text(
                "You almost reach today’s nutrient goal!!",
                style: CustomText.subHeading3(color: CustomColor.secondary),
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
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: BarChart(
                  // duration: Duration(milliseconds: 500),
                  BarChartData(
                    borderData: FlBorderData(
                      border: Border(
                        left: BorderSide(color: CustomColor.gray, width: 2),
                        bottom: BorderSide(
                          color: CustomColor.gray,
                          width: 2,
                        ),
                      ),
                    ),
                    maxY: maxValue + 25,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (b) {
                          return Colors.transparent;
                        },
                        tooltipPadding: EdgeInsets.all(0),
                        tooltipMargin: 0,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            rod.toY.round().toString(),
                            CustomText.text1(color: CustomColor.black),
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
                            switch (value) {
                              case 0:
                                label = "Calorie";
                                metrics = "kcal";
                                break;
                              case 1:
                                label = "Protein";
                                metrics = "gr";
                                break;
                              case 2:
                                label = "Carbohydrate";
                                metrics = "gr";
                                break;
                              case 3:
                                label = "Fiber";
                                metrics = "gr";
                                break;
                            }
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
                ["Vitamin A", "770 µg", "770 µg"],
                ["Vitamin C", "85 mg", "85 mg"],
                ["Vitamin D", "5 µg", "5 µg"],
                ["Calcium", "1 gr", "1 gr"],
                ["Iron", "27-60 mg", "27-60 mg"],
                ["Zinc", "11 mg", "11 mg"],
              ]),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 140, 120);
    final barGroup2 = makeGroupData(1, 76, 70);
    final barGroup3 = makeGroupData(2, 175, 60);
    final barGroup4 = makeGroupData(3, 28, 22);

    final items = [barGroup1, barGroup2, barGroup3, barGroup4];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  void changeDate(DateTime val) {
    Navigator.pushReplacementNamed(
      context,"/plan",arguments: PlanArguments(date: val)
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;
    args = ModalRoute.of(context)!.settings.arguments as PlanArguments;
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
                                  tabOption == 1
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
                                  if (tabOption != 1) tabOption = 1;
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
                                  tabOption == 2
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
                                  if (tabOption != 2) tabOption = 2;
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
                      tabOption == 1
                          ? dailyNutrients(context, deviceWidth)
                          : monthlyWeight(context, deviceWidth),
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
