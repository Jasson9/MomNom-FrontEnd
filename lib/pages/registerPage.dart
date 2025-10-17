import 'dart:convert';

import 'package:MomNom/etc/errorHandler.dart';
import 'package:MomNom/model/exceptions.dart';
import 'package:MomNom/model/register.dart';
import 'package:MomNom/model/base.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import '../etc/urlEndpoint.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String strEmail = "";
  String strPassword = "";
  String strUsername = "";
  String strPasswordConfirm = "";
  bool isLoading = false;

  void sendRegisterRequest() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    // TODO: Loading Indicator
    // TODO: Validation
    try {
      var url = URLEndpoint.registerEndpoint;
      var reqBody = RegisterRequest(
        Email: strEmail,
        Password: strPassword,
        PasswordConfirm: strPasswordConfirm,
        Username: strUsername
      );
      print(jsonEncode(reqBody.toJson()));
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
      BaseResponse<RegisterResponse> apiResponse =
      BaseResponse.fromJson(
        respJson,
            (json) => RegisterResponse.fromJson(
          json as Map<String, dynamic>,
        ),
      );

      if (apiResponse.statusCode != 200) {
        throw APIException(apiResponse.statusCode, apiResponse.statusMessage);
      } else {
        if (apiResponse.data?.sessionId == null) {
          throw CustomException("session id is null");
        } else {
          final prefs =
          await SharedPreferences.getInstance();
          await prefs.setString(
            'authToken',
            apiResponse.data!.sessionId!,
          );
          if (mounted){
            Navigator.pushReplacementNamed(context, "/dashboard");
          }
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
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/AppLogo-Sprite.png",scale: 0.7,),
            Text('Register', style: CustomText.heading1(color: CustomColor.white)),
            SizedBox(width: deviceWidth * 0.9,
              child: Column(spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username', style: CustomText.subHeading3(),textAlign: TextAlign.left),
                  CustomTextField.input(placeholder:"Jane Doe",onChanged: (String str)=>strUsername = str )
                ],
              ),
            ),
            SizedBox(width: deviceWidth * 0.9,
              child: Column(spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email Address', style: CustomText.subHeading3(),textAlign: TextAlign.left),
                  CustomTextField.input(placeholder:"example123@gmail.com",onChanged: (String str)=>strEmail = str )
                ],
              ),
            ),
            SizedBox(width:  deviceWidth * 0.9,
              child: Column(spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Password', style: CustomText.subHeading3(),textAlign: TextAlign.left,),
                  CustomTextField.input(placeholder:"Password",onChanged: (String str)=>strPassword = str ,obscureText: true)
                ],
              ),
            ),
            SizedBox(width:  deviceWidth * 0.9,
              child: Column(spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Confirm Password', style: CustomText.subHeading3(),textAlign: TextAlign.left,),
                  CustomTextField.input(placeholder:"Confirm Password",onChanged: (String str)=>strPasswordConfirm = str ,obscureText: true)
                ],
              ),
            ),
            SizedBox(
              width:  deviceWidth * 0.6,
              child: Column(spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: deviceWidth * 0.6,child:
                  CustomButton.secondary(text: "Register", onPress: ()=>sendRegisterRequest())
                    ,),
                  TextButton(onPressed: ()=>Navigator.pushNamed(context,"/login"), child: Text('Already Have An Account? Login Here', style: CustomText.text1(color: CustomColor.white), textAlign: TextAlign.center,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}