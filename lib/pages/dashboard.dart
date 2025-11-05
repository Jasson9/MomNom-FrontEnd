import 'dart:convert';

import 'package:MomNom/components/navbar.dart';
import 'package:MomNom/etc/errorHandler.dart';
import 'package:MomNom/etc/tips.dart';
import 'package:MomNom/model/dashboard.dart';
import 'package:MomNom/model/exceptions.dart';
import 'package:MomNom/pages/exercisePage.dart';
import 'package:MomNom/pages/planPage.dart';
import 'package:MomNom/pages/profilePage.dart';
import 'package:MomNom/etc/utils.dart';
import 'package:MomNom/model/base.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../components/card.dart';
import '../etc/requestHandler.dart';
import '../etc/styles.dart';
import '../components/card.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import 'package:vector_math/vector_math_64.dart';

import '../etc/urlEndpoint.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<BaseResponse<DashboardResponse>> requestedData;
  Key _refreshKey = UniqueKey();

  Future<BaseResponse<DashboardResponse>> requestData() async {
    try {
      await isAuthExistAsync(context);
      BaseResponse<DashboardResponse> response = BaseResponse.fromJson(
        await RequestHandler.sendRequest(
          url: URLEndpoint.dashboardEndpoint,
          useAuth: true,
        ),
        (json) => (DashboardResponse.fromJson(json as Map<String, dynamic>)),
      );

      if (response.data!.plans!.isEmpty && mounted) {
        Navigator.pushReplacementNamed(context, "/createPlan");
      }
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
    final safePadding = MediaQuery.paddingOf(context).top;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.white,
        bottomNavigationBar: CustomNavBar.navbar(context, 0),
        body: Container(
          width: deviceWidth,
          child: FutureBuilder<BaseResponse<DashboardResponse>>(
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
                var data = snapshot.data!.data;
                var calorieNeeded =
                    data?.remainingNutritions
                        ?.where((e) => e.nutrientName == "Calorie")
                        .firstOrNull;
                var proteinNeeded =
                    data?.remainingNutritions
                        ?.where((e) => e.nutrientName == "Protein")
                        .firstOrNull;
                var carbohydrateNeeded =
                    data?.remainingNutritions
                        ?.where((e) => e.nutrientName == "Carbohydrate")
                        .firstOrNull;
                var fiberNeeded =
                    data?.remainingNutritions
                        ?.where((e) => e.nutrientName == "Fiber")
                        .firstOrNull;
                print(data?.dailyLogs);
                return SingleChildScrollView(
                  child: Column(
                    spacing: 18,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: deviceWidth,
                            // height: 160,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 48),
                            transform: Matrix4.translation(Vector3(0, 48, 0)),
                            decoration: BoxDecoration(
                              color: CustomColor.secondary,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 32,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello, ${data?.username ?? ""}!",
                                  style: CustomText.subHeading1(
                                    color: CustomColor.primaryDarker,
                                  ),
                                ),
                                Text(
                                  "This is your very own personal pregnancy diet plan, see your diet progress and food diary for a healthy mom and baby",
                                  style: CustomText.subHeading3(
                                    color: CustomColor.primaryDark,
                                    // bold: true,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                            width: deviceWidth * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed:
                                      () => {
                                        Navigator.pushNamed(
                                          context,
                                          ProfilePage.routeName,
                                        ),
                                      },
                                  padding: EdgeInsets.all(0),
                                  icon: CircleAvatar(
                                    child: Icon(Icons.person, size: 36),
                                    radius: 36,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: deviceWidth * 0.95,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 180,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 160,
                                    child: ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Container(
                                          width: getConstrainedWidth(
                                            context,
                                            0.45,
                                            minWidth: 224,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                            color: CustomColor.tertiary,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 16,
                                          ),
                                          child: Column(
                                            spacing: 8,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Today you still need...",
                                                style: CustomText.text1(
                                                  color: CustomColor.black,
                                                  bold: true,
                                                ),
                                              ),
                                              SizedBox(
                                                child: Row(
                                                  spacing: 8,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/Calorie.png",
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "Calorie",
                                                        style: CustomText.text1(
                                                          color:
                                                              CustomColor
                                                                  .primaryDarker,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${calorieNeeded?.remainingNutrient ?? 0} ${calorieNeeded?.unit ?? "kcal"}",
                                                      style: CustomText.text1(
                                                        color:
                                                            CustomColor
                                                                .primaryDarker,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                child: Row(
                                                  spacing: 8,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/Protein.png",
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "Protein",
                                                        style: CustomText.text1(
                                                          color:
                                                              CustomColor
                                                                  .primaryDarker,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${proteinNeeded?.remainingNutrient ?? 0} ${proteinNeeded?.unit ?? "g"}",
                                                      style: CustomText.text1(
                                                        color:
                                                            CustomColor
                                                                .primaryDarker,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                child: Row(
                                                  spacing: 8,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/Carbohydrate.png",
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "Carbohydrate",
                                                        style: CustomText.text1(
                                                          color:
                                                              CustomColor
                                                                  .primaryDarker,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${carbohydrateNeeded?.remainingNutrient ?? 0} ${carbohydrateNeeded?.unit ?? "g"}",
                                                      style: CustomText.text1(
                                                        color:
                                                            CustomColor
                                                                .primaryDarker,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                child: Row(
                                                  spacing: 8,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/Fiber.png",
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "Fiber",
                                                        style: CustomText.text1(
                                                          color:
                                                              CustomColor
                                                                  .primaryDarker,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${fiberNeeded?.remainingNutrient ?? 0} ${fiberNeeded?.unit ?? "g"}",
                                                      style: CustomText.text1(
                                                        color:
                                                            CustomColor
                                                                .primaryDarker,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                            8,
                                            0,
                                            0,
                                            0,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                            color: CustomColor.secondary,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 4,
                                          ),
                                          child: Column(
                                            spacing: 4,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "${data?.currWeightGain?.monthYear}",
                                                  style: CustomText.text1(
                                                    color: CustomColor.black,
                                                    bold: true,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      // width: 80,
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 24,
                                                      ),
                                                      child: Column(
                                                        spacing: 8,
                                                        children: [
                                                          Text(
                                                            "Progress",
                                                            style: CustomText.text1(
                                                              color:
                                                              CustomColor
                                                                  .primaryDarker,
                                                            ),
                                                          ),
                                                          Column(
                                                            spacing: 0,
                                                            children: [
                                                              Text(
                                                                "${data?.currWeightGain?.totalGain}/${data?.currWeightGain?.recGain ?? 0}",
                                                                style: CustomText.subHeading2(
                                                                  color:
                                                                  CustomColor
                                                                      .primaryDarker,
                                                                ),
                                                              ),
                                                              Text(
                                                                "kg",
                                                                style: CustomText.text2(
                                                                  color:
                                                                  CustomColor
                                                                      .primaryDarker,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 160,
                                                      width: 1,
                                                      decoration: BoxDecoration(
                                                        color:
                                                        CustomColor
                                                            .darkGray,
                                                      ),
                                                    ),
                                                    Container(
                                                      // width: 80,
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 24,
                                                      ),
                                                      child: Column(
                                                        spacing: 8,
                                                        children: [
                                                          Text(
                                                            "Percentage",
                                                            style: CustomText.text1(
                                                              color:
                                                              CustomColor
                                                                  .primaryDarker,
                                                            ),
                                                          ),
                                                          Column(
                                                            spacing: 0,
                                                            children: [
                                                              Text(
                                                                "${data?.currWeightGain?.percentage}",
                                                                style: CustomText.subHeading2(
                                                                  color:
                                                                  CustomColor
                                                                      .primaryDarker,
                                                                ),
                                                              ),
                                                              Text(
                                                                "%",
                                                                style: CustomText.text2(
                                                                  color:
                                                                  CustomColor
                                                                      .primaryDarker,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        ,
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              PlanPage.routeName,
                                              arguments: PlanArguments(
                                                date: DateTime.now(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "See Details ->",
                                            textAlign: TextAlign.right,
                                            style: CustomText.text1(
                                              color: CustomColor.primaryDarker,
                                              decor: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 140,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: getConstrainedWidth(
                                      context,
                                      0.65,
                                      minWidth: 240,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      color: CustomColor.primary,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color:
                                                          CustomColor
                                                              .primaryDark,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Exercise",
                                                  style: CustomText.text1(
                                                    color:
                                                        CustomColor
                                                            .primaryDarker,
                                                    bold: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "You haven’t exercise this week...",
                                                style: CustomText.text1(
                                                  color: CustomColor.black,
                                                  bold: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          ExercisePage.routeName,
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: ShapeDecoration(
                                              shape: CircleBorder(),
                                              color: CustomColor.primaryDark,
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: CustomColor.tertiary,
                                              size: 36,
                                            ),
                                          ),
                                          Text(
                                            "Go to Exercise",
                                            style: CustomText.text1(
                                              color: CustomColor.primaryDarker,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Today’s Diary",
                                        textAlign: TextAlign.left,
                                        style: CustomText.subHeading2(
                                          color: CustomColor.primaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 160,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 160,
                                              child: ListView(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Row(
                                                    spacing: 8,
                                                    children:
                                                        data?.dailyLogs?.map((
                                                          e,
                                                        ) {
                                                          return CustomCard.dailyFoodDiary2x2(
                                                            deviceWidth:
                                                                deviceWidth,
                                                            foodName:
                                                                e.foodName ??
                                                                "",
                                                            amount:
                                                                e.amount ?? 0,
                                                            nutrients:
                                                                e.nutrientsListDetail,
                                                          );
                                                        }).toList() ??
                                                        [],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Tips",
                                        textAlign: TextAlign.left,
                                        style: CustomText.subHeading2(
                                          color: CustomColor.primaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 140,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 140,
                                              child: ListView(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children:
                                                    Tips.getRandomTips().map((
                                                      e,
                                                    ) {
                                                      return Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                              0,
                                                              0,
                                                              8,
                                                              0,
                                                            ),
                                                        child:
                                                            CustomCard.tipsCard(
                                                              e,
                                                            ),
                                                      );
                                                    }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
                );
              }

              return Center(child: const CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
