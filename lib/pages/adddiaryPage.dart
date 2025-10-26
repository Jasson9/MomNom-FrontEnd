import 'package:MomNom/components/navbar.dart';
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
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class AddDiaryPage extends StatefulWidget {
  const AddDiaryPage({super.key});

  static final String routeName = "/addDiary";

  @override
  State<AddDiaryPage> createState() => _AddDiaryPageState();
}

class AddDiaryArguments {
  final DateTime addDate;

  // 1 = manual, 2 = scan
  int option;

  AddDiaryArguments(this.addDate, this.option);
}

class FoodItem {
  final String name;
  final int quantity;

  FoodItem(this.name, this.quantity);
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  List<List<TextEditingController>> multiFieldTextController = [];
  List<CustomTextField> multiFieldTextList = [];
  late AddDiaryArguments args;

  // _AddDiaryPageState({DailyDiaryArguments? args});

  void _addMultiTextField() {
    setState(() {
      multiFieldTextController.add([
        TextEditingController(),
        TextEditingController(),
      ]);
      multiFieldTextList.add(CustomTextField());
    });
  }

  void _deleteMultiTextField(int index) {
    setState(() {
      multiFieldTextController.removeAt(index);
      multiFieldTextList.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    // Start with one TextField by default
    _addMultiTextField();
  }

  Future<void> imagePickerWidget(BuildContext context) async {
    bool isEmpty = false;
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.camera);
    String foodName = "test";
    setState(() {
      for (int i = 0; i < multiFieldTextController.length; i++) {
        if (multiFieldTextController[i][0].value.text.isEmpty) {
          isEmpty = true;
          multiFieldTextController[i][0].value = TextEditingValue(
            text: foodName,
          );
          break;
        }
      }
      if (isEmpty == false) {
        multiFieldTextController.add([
          TextEditingController.fromValue(TextEditingValue(text: "test")),
          TextEditingController(),
        ]);
        multiFieldTextList.add(CustomTextField());
      }
      if (args.option == 2) {
        args.option = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;
    args = ModalRoute.of(context)!.settings.arguments as AddDiaryArguments;
    String dateString = args.addDate.toIso8601String();
    dateString = DateFormat("d MMMM yyyy").format(args.addDate);
    // _addMultiTextField();
    print("amount " + multiFieldTextList.length.toString());
    if (args.option == 2) {
      imagePickerWidget(context);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.white,
        bottomNavigationBar: CustomNavBar.navbar(context, 1),
        body: Container(
          width: deviceWidth,
          padding: EdgeInsets.all(20),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                dateString,
                style: CustomText.subHeading2(color: CustomColor.primaryDarker),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: multiFieldTextList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == multiFieldTextList.length) {
                      return Column(
                        spacing: 8,
                        // padding:  const EdgeInsets.only(bottom:16.0),
                        children: [
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
                                  onPress: _addMultiTextField,
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
                          Column(
                            children: [
                              Text(
                                "Are there scan results that don't match?",
                                style: CustomText.textMd1(
                                  color: CustomColor.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Give us feedback here!",
                                style: CustomText.textMd1(
                                  color: CustomColor.black,
                                  decor: TextDecoration.underline
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: multiFieldTextList[index].multiFieldInput(
                        placeholder1: "Food Name",
                        placeholder2: "Qty",
                        metrics: "gr",
                        controller1: multiFieldTextController[index][0],
                        controller2: multiFieldTextController[index][1],
                        onDelete: () => _deleteMultiTextField(index),
                      ),
                      // Only show the remove button if there's more than one TextField
                    );
                  },
                ),
              ),
              CustomButton.secondary(
                text: "Save",
                colorFill: CustomColor.primary,
                colorText: CustomColor.black,
                horizontalPad: 80,
                onPress: (){
                  print(multiFieldTextController[0][0].text);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
