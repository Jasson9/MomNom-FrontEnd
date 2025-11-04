import 'dart:convert';

import 'package:MomNom/components/navbar.dart';
import 'package:MomNom/components/snackbar.dart';
import 'package:MomNom/model/addDiary.dart';
import 'package:MomNom/model/foodDetection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../components/card.dart';
import '../etc/errorHandler.dart';
import '../etc/requestHandler.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import '../etc/urlEndpoint.dart';
import '../model/base.dart';
import '../model/exceptions.dart';
import 'dailydiaryPage.dart';

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
  bool isLoading = false;

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

  void _saveFoodDiary() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    List<AddDiaryFoodItem> items = [];
    try {
      if (multiFieldTextController.length == 0) {
        throw ValidationException("Add at least 1 food to save");
      }
      multiFieldTextController.forEach((e) {
        var foodName = e[0].value.text;
        var amt = e[1].value.text;

        if (foodName.trim() == "") {
          throw ValidationException("Food name should not be empty");
        }

        if (amt.trim() == "" || double.parse(amt) < 0) {
          throw ValidationException("Amount should be more than 0");
        }
        items.add(
          AddDiaryFoodItem(foodName: foodName, amountGr: double.parse(amt)),
        );
      });

      AddDiaryRequest reqBody = AddDiaryRequest(args.addDate, items);

      BaseResponse<AddDiaryResponse> apiResponse = BaseResponse.fromJson(
        await RequestHandler.sendRequest(
          item: reqBody,
          url: URLEndpoint.addFoodDiary,
          useAuth: true,
        ),
        (json) => (AddDiaryResponse.fromJson(json as Map<String, dynamic>)),
      );

      Navigator.pushNamed(
        context,
        DailyDiaryPage.routeName,
        arguments: DailyDiaryArguments(
          DateTime(args.addDate.year, args.addDate.month, args.addDate.day),
        ),
      );
    } catch (ex) {
      if (mounted) customErrorHandler(ex, context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
    var base64Data = "data:image/";
    RegExp fileFormatRegex = RegExp(r"\.(.+)$");

    if (result?.name == null) {
      setState(() {
        if (args.option == 2) args.option = 1;
      });
      throw Exception("Invalid Image Filename");
    }
    Match? match = fileFormatRegex.firstMatch(result!.name);

    if (match == null || match.group(1) == null) {
      setState(() {
        if (args.option == 2) args.option = 1;
      });
      throw Exception("Invalid Image Format");
    } else {
      base64Data += match.group(1)!;
      base64Data += ";base64,";
    }

    var imageBytes = await result.readAsBytes();
    String base64Img = base64Encode(imageBytes);

    base64Data += base64Img;
    if (mounted) {
      CustomSnackbar.showErrorSnackbar(
        "Loading..., detecting food from image",
        context,
      );
    }
    setState(() {
      if (args.option == 2) {
        args.option = 1;
      }
      isLoading = true;
    });

    try {
      var apiResponse = BaseResponse.fromJson(
        await RequestHandler.sendRequest(
          item: FoodDetectionRequest(base64Data),
          url: URLEndpoint.foodDetection,
        ),
        (json) =>
            (FoodDetectionResponse.fromJson(json as Map<String, dynamic>)),
      );

      if (apiResponse.data!.foodNameList == null) {
        throw CustomException("Food list empty");
      }

      List<String>? foodNames = apiResponse.data!.foodNameList;
      print(foodNames);
      setState(() {
        foodNames?.forEach((e) {
          isEmpty = false;
          for (int i = 0; i < multiFieldTextController.length; i++) {
            if (multiFieldTextController[i][0].value.text.isEmpty) {
              isEmpty = true;
              multiFieldTextController[i][0].value = TextEditingValue(text: e);
              break;
            }
          }
          if (isEmpty == false) {
            multiFieldTextController.add([
              TextEditingController.fromValue(TextEditingValue(text: e)),
              TextEditingController(),
            ]);
            multiFieldTextList.add(CustomTextField());
          }
        });
      });
    } catch (ex) {
      if (mounted) customErrorHandler(ex, context);
    }

    setState(() {
      isLoading = false;
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
                                  decor: TextDecoration.underline,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
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
                isLoading: isLoading,
                onPress: () {
                  _saveFoodDiary();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
