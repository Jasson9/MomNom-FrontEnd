import 'dart:convert';

import 'package:MomNom/components/snackbar.dart';
import 'package:MomNom/etc/errorHandler.dart';
import 'package:MomNom/etc/requestHandler.dart';
import 'package:MomNom/etc/utils.dart';
import 'package:MomNom/model/exceptions.dart';
import 'package:MomNom/model/plan.dart';
import 'package:MomNom/model/base.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import '../etc/urlEndpoint.dart';

class CreatePlanPage extends StatefulWidget {
  const CreatePlanPage({super.key});

  @override
  State<CreatePlanPage> createState() => _CreatePlanPageState();
}

class _CreatePlanPageState extends State<CreatePlanPage> {
  DateTime dob = DateTime.now();
  double height = 0;
  int weekOfPregnancy = 0;
  double currentWeight = 0;
  double prePregnancyWeight = 0;
  bool isLoading = false;

  void _createPlanButtonPressed() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    try {
      if (height == 0) {
        throw ValidationException("Height cannot be 0");
      }
      if (weekOfPregnancy == 0) {
        throw ValidationException("Week of Pregnancy cannot be 0");
      }
      if (currentWeight == 0) {
        throw ValidationException("Current Weight cannot be 0");
      }
      if (prePregnancyWeight == 0) {
        throw ValidationException("Pre-Pregnancy Weight cannot be 0");
      }

      var reqBody = CreatePlanRequest(
        age: calculateAge(dob),
        currentWeight: currentWeight,
        height: height,
        prePregnancyWeight: prePregnancyWeight,
        weekPregnancy: weekOfPregnancy,
        DOBstring: DateFormat('yyyy-MM-dd').format(dob),
      );

      BaseResponse<CreatePlanResponse> apiResponse = BaseResponse.fromJson(
        await RequestHandler.sendRequest(
          item: reqBody,
          url: URLEndpoint.createPlanEndpoint,
        ),
            (json) => (CreatePlanResponse.fromJson(json as Map<String, dynamic>)),
      );

      if (apiResponse.data?.planId == null) {
        throw CustomException("PlanId is null");
      } else {
        if (mounted) Navigator.pushReplacementNamed(context, "/dashboard");
      }
    } catch (ex) {
      if (mounted) customErrorHandler(ex, context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: CustomColor.primaryDark,
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/AppLogo-Sprite.png", scale: 1.5),
            SizedBox(
              width: deviceWidth * 0.8,
              child: Text(
                'Before we start, we need you to fill in these information to make the best meal plan dietary for you',
                style: CustomText.subHeading3(color: CustomColor.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.9,
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date of Birth',
                    style: CustomText.subHeading3(),
                    textAlign: TextAlign.left,
                  ),
                  CustomTextField.dateTimeForm(
                    context: context,
                    onDateTimeChanged: (e) {
                      dob = e;
                    },
                    value: dob,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.9,
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Height',
                    style: CustomText.subHeading3(),
                    textAlign: TextAlign.left,
                  ),
                  CustomTextField.inputWithMetrics(
                    metricsText: "cm",
                    onChanged:
                        (e) => setState(() {
                          height = e;
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.9,
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Week of Pregnancy',
                    style: CustomText.subHeading3(),
                    textAlign: TextAlign.left,
                  ),
                  CustomTextField.inputWithMetrics(
                    metricsText: "week",
                    onChanged:
                        (e) => setState(() {
                          weekOfPregnancy = e.toInt();
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.9,
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Weight',
                    style: CustomText.subHeading3(),
                    textAlign: TextAlign.left,
                  ),
                  CustomTextField.inputWithMetrics(
                    metricsText: "kg",
                    onChanged:
                        (e) => setState(() {
                          currentWeight = e;
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.9,
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pre-Pregnancy Weight',
                    style: CustomText.subHeading3(),
                    textAlign: TextAlign.left,
                  ),
                  CustomTextField.inputWithMetrics(
                    metricsText: "kg",
                    onChanged:
                        (e) => setState(() {
                          prePregnancyWeight = e;
                        }),
                  ),
                  Text(
                    'Please fill in your pre-pregnancy weight if the calculation result is different from the actual weight',
                    style: CustomText.text2(color: CustomColor.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.6,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: deviceWidth * 0.6,
                    child: CustomButton.secondary(
                      text: "Create Plan!",
                      onPress: _createPlanButtonPressed,
                      isLoading: isLoading
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
