import 'package:MomNom/components/navbar.dart';
import 'package:MomNom/etc/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:intl/intl.dart';
import '../components/card.dart';
import '../components/dropdown.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  static final String routeName = "/exercise";

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _Popup extends StatefulWidget {
  _Popup({required this.popupKey});

  GlobalKey<CustomPopupState> popupKey;

  @override
  State<_Popup> createState() => __PopupState(popupKey: popupKey);
}

class __PopupState extends State<_Popup> {
  __PopupState({required this.popupKey});

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

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;

    CustomPopup popup = CustomPopup(
      showArrow: true,
      key: popupKey,
      arrowColor: CustomColor.tertiary,
      backgroundColor: CustomColor.tertiary,
      content: _Popup(popupKey: popupKey),
      child: Container(
        padding: EdgeInsets.fromLTRB(28, 18, 28, 28),
        decoration: ShapeDecoration(
          color: CustomColor.secondary,
          shape: CircleBorder(),
        ),
        child: Column(
          children: [
            Image.asset("assets/images/Exercise-1.png"),
            Text(
              "Click here!",
              style: CustomText.text1(color: CustomColor.black),
            ),
          ],
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.white,
        bottomNavigationBar: CustomNavBar.navbar(context, 2),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: deviceWidth,
                  height: 160,
                  decoration: BoxDecoration(color: CustomColor.secondary),
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: Column(
                    children: [
                      Text(
                        "I’m Capable, I’m Strong!",
                        style: CustomText.subHeading1(
                          color: CustomColor.primaryDarker,
                        ),
                      ),
                      Text(
                        "Appropriate and regular exercise can improve the health of both mother and baby. Track your exercise progress here!",
                        style: CustomText.textMd1(
                          color: CustomColor.primaryDark,
                          bold: true,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  width: deviceWidth * 0.9,
                  child: Column(
                    spacing: 8,
                    children: [
                      Container(
                        width: deviceWidth * 0.9,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: CustomColor.gray,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          "  This week’s exercise",
                          style: CustomText.textMd1(
                            color: CustomColor.black,
                            bold: true,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        decoration: ShapeDecoration(
                          shape: Border(
                            bottom: BorderSide(
                              color: CustomColor.gray,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          spacing: 28,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              decoration: ShapeDecoration(
                                color: CustomColor.secondary,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: CustomColor.primary,
                                    width: 4,
                                    strokeAlign: 6,
                                  ),
                                ),
                              ),
                              child: popup,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: CustomColor.primary,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Column(
                                  spacing: 4,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "9 August 2025 - Week 2",
                                        style: CustomText.text1(
                                          color: CustomColor.primaryDarker,
                                          bold: true,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: CustomColor.darkGray,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua annyeong...",
                                        style: CustomText.text2(
                                          color: CustomColor.black,
                                          bold: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomCard.exerciseExpandedCard(),
                      CustomCard.exerciseExpandedCard(),
                      CustomCard.exerciseExpandedCard(),
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
