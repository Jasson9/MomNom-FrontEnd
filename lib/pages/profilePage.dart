import 'package:MomNom/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import 'package:vector_math/vector_math_64.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const String routeName = "/profile";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: deviceWidth,
                  decoration: BoxDecoration(color: CustomColor.primaryDark),
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "< Back",
                              style: CustomText.textMd1(
                                color: CustomColor.secondary,
                                bold: true,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();
                              prefs.remove("authToken");
                              if(mounted)Navigator.pushReplacementNamed(context, "/login");
                            },
                            child: Text(
                              "Logout",
                              style: CustomText.textMd1(
                                color: CustomColor.secondary,
                                bold: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: deviceWidth,
                  height: 10,
                  decoration: BoxDecoration(color: CustomColor.tertiary),
                ),
                Container(
                  transform: Matrix4.translation(Vector3(0, -64, 0)),
                  child: Column(
                    spacing: 4,
                    children: [
                      IconButton(
                        color: CustomColor.primary,
                        onPressed: () => {},
                        padding: EdgeInsets.all(0),
                        icon: CircleAvatar(
                          backgroundColor: CustomColor.primary,
                          child: Icon(Icons.person, size: 96),
                          radius: 64,
                        ),
                      ),
                      Text(
                        "+ Click to change",
                        style: CustomText.text1(
                          color: CustomColor.primaryDarker,
                          bold: true,
                        ),
                      ),
                      Container(
                        width: deviceWidth * 0.85,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField.input(
                              filled: false,
                              outline: true,
                              withHeader: true,
                              placeholder: "Username",
                              keyboardType: TextInputType.name,
                            ),
                            CustomTextField.input(
                              filled: false,
                              outline: true,
                              withHeader: true,
                              placeholder: "Email",
                              keyboardType: TextInputType.emailAddress,
                            ),
                            CustomTextField.dateTimeForm(
                              context: context,
                              headerTitle: "Date of Birth",
                              filled: false,
                              outline: true,
                            ),
                            CustomTextField.inputWithMetrics(
                              filled: false,
                              outline: true,
                              headerTitle: "Age",
                              metricsText: "",
                            ),
                            CustomTextField.inputWithMetrics(
                              filled: false,
                              outline: true,
                              headerTitle: "Height",
                              metricsText: "cm",
                            ),
                            CustomTextField.inputWithMetrics(
                              filled: false,
                              outline: true,
                              headerTitle: "Week of Pregnancy",
                              metricsText: "week",
                            ),
                            CustomTextField.inputWithMetrics(
                              filled: false,
                              outline: true,
                              headerTitle: "Current Weight",
                              metricsText: "kg",
                            ),
                            CustomTextField.inputWithMetrics(
                              filled: false,
                              outline: true,
                              headerTitle: "Pre-pregnancy Weight",
                              metricsText: "kg",
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                    child: CustomButton.secondary(
                                      text: "Save",
                                      colorText: CustomColor.black,
                                      colorFill: CustomColor.primary,
                                      onPress: () {
                                        Navigator.pop(context);
                                      },
                                    ),
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
        ),
      ),
    );
  }
}
