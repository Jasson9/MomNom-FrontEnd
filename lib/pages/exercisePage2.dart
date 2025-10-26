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

class ExercisePage2 extends StatefulWidget {
  const ExercisePage2({super.key});

  static final String routeName = "/exercise";

  @override
  State<ExercisePage2> createState() => _ExercisePage2State();
}

class _ExercisePage2State extends State<ExercisePage2> {
  List<List<List<TextEditingController>>> multiFieldTextController = [];

  @override
  void initState() {
    super.initState();
    // Start with one TextField by default
    _addWeekCard();
  }

  void _addMultiTextField(int index) {
    setState(() {
      multiFieldTextController[index].add([
        TextEditingController(),
        TextEditingController(),
      ]);
      // multiFieldTextList.add(CustomTextField());
    });
  }

  void _addWeekCard(){
    setState(() {
      multiFieldTextController.add([]);
      multiFieldTextController[multiFieldTextController.length-1].add([
        TextEditingController(),
        TextEditingController(),
      ]);
      print("length "+ multiFieldTextController.length.toString());
    });
  }

  void _deleteMultiTextField(int indexWeek, int index) {
    print("On deleted");
    setState(() {
      multiFieldTextController[indexWeek].removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;

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
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
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
                              child: Container(
                                padding: EdgeInsets.fromLTRB(14, 9, 14, 14),
                                decoration: ShapeDecoration(
                                  color: CustomColor.secondary,
                                  shape: CircleBorder(),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "210",
                                      style: CustomText.textBg1(
                                        color: CustomColor.primaryDarker,
                                      ),
                                    ),
                                    Text(
                                      "Minutes",
                                      style: CustomText.text1(
                                        color: CustomColor.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: CustomColor.primary,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Column(
                                  spacing: 4,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "3 Aug 2025 - 9 Aug 2025 Week 2",
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
                                      child: Column(
                                        children: [
                                          Table(
                                            columnWidths: {
                                              0:FlexColumnWidth(0.7),
                                              1:FlexColumnWidth(0.15),
                                              2:FlexColumnWidth(0.15)
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Text("Exercise 1", style: CustomText.text1(color: CustomColor.black, bold: true),),
                                                  Text("XX", style: CustomText.text1(color: CustomColor.black, bold: true)),
                                                  Text("min", style: CustomText.text1(color: CustomColor.black, bold: true)),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Text("Exercise 2", style: CustomText.text1(color: CustomColor.black, bold: true)),
                                                  Text("XX", style: CustomText.text1(color: CustomColor.black, bold: true)),
                                                  Text("min", style: CustomText.text1(color: CustomColor.black, bold: true)),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Text("Exercise 3", style: CustomText.text1(color: CustomColor.black, bold: true)),
                                                  Text("XX", style: CustomText.text1(color: CustomColor.black, bold: true)),
                                                  Text("min", style: CustomText.text1(color: CustomColor.black, bold: true)),
                                                ],
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
                          ],
                        ),
                      ),
                      // CustomCard.exerciseExpandedCard2(),
                      Column(
                        spacing: 16,
                        children: multiFieldTextController.asMap().entries.map((e){
                          return CustomCard.exerciseExpandedCard2(e.value, ()=>_addMultiTextField(e.key), (d)=>_deleteMultiTextField(e.key,d));
                        }).toList(),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: CustomColor.gray,
                            ),
                          ),
                          Container(
                            width: 160,
                            child: CustomButton.secondary(
                              text: "+ Add New",
                              colorFill: CustomColor.secondary,
                              colorText: CustomColor.black,
                              onPress: _addWeekCard,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: CustomColor.gray,
                            ),
                          ),
                        ],

                      ),
                      CustomButton.secondary(
                          text: "Save",
                          colorFill: CustomColor.primary,
                          colorText: CustomColor.black,
                          horizontalPad: 80,
                          onPress: (){
                          }
                      )
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
