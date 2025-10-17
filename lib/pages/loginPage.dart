import 'dart:convert';

import 'package:MomNom/etc/errorHandler.dart';
import 'package:MomNom/etc/urlEndpoint.dart';
import 'package:MomNom/etc/utils.dart';
import 'package:MomNom/model/base.dart';
import 'package:MomNom/model/exceptions.dart';
import 'package:MomNom/model/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget implements PageRouteProperty {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  @override
  final String routeName = "/login";
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  String strEmail = "";
  String strPassword = "";
  bool isLoading = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _emailChanged(String email) {
    setState(() {
      strEmail = email;
    });
  }

  void _passwordChanged(String pass) {
    setState(() {
      strPassword = pass;
    });
  }

  void sendLoginRequest() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    // TODO: Loading Indicator
    // TODO: Validation
    try {
      var url = URLEndpoint.loginEndpoint;
      var reqBody = LoginRequest(Email: strEmail, Password: strPassword);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reqBody.toJson()),
      );
      if (response.statusCode != 200) {
        throw HttpException(response.statusCode, response.body);
      }

      var respJson = jsonDecode(response.body);
      BaseResponse<LoginResponse> apiResponse = BaseResponse.fromJson(
        respJson,
        (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
      );

      if (apiResponse.statusCode != 200) {
        throw APIException(
          apiResponse.statusCode ?? 500,
          apiResponse.statusMessage ?? "Null Status Message",
        );
      } else {
        if (apiResponse.data?.sessionId == null) {
          throw CustomException("SessionId is null");
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('authToken', apiResponse.data!.sessionId!);
          if(mounted)Navigator.pushReplacementNamed(context, "/dashboard");
        }
      }
    } catch (ex) {
      if(mounted)customErrorHandler(ex, context);
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
          spacing: 28,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/AppLogo-Sprite.png", scale: 0.7),
            Text('Login', style: CustomText.heading1(color: CustomColor.white)),
            Container(
              width: deviceWidth * 0.9,
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Address',
                    style: CustomText.subHeading3(),
                    textAlign: TextAlign.left,
                  ),
                  CustomTextField.input(
                    placeholder: "example123@gmail.com",
                    onChanged: _emailChanged,
                  ),
                ],
              ),
            ),
            Container(
              width: deviceWidth * 0.9,
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: CustomText.subHeading3(),
                    textAlign: TextAlign.left,
                  ),
                  CustomTextField.input(
                    placeholder: "Password",
                    onChanged: _passwordChanged,
                    obscureText: true,
                  ),
                ],
              ),
            ),
            Container(
              width: deviceWidth * 0.6,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: deviceWidth * 0.6,
                    child: CustomButton.secondary(
                      text: "login",
                      onPress: sendLoginRequest,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (isLoading) {
                        return;
                      }
                      Navigator.pushNamed(context, "/register");
                    },
                    child: Text(
                      'Don’t Have An Account? Register Here',
                      style: CustomText.text1(color: CustomColor.white),
                      textAlign: TextAlign.center,
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
