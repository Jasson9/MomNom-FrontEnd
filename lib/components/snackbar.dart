import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../etc/styles.dart';
import 'package:intl/intl.dart';

mixin CustomSnackbar {
  // List<TextEditingController> multiFieldInputControllers = [];
  static void showErrorSnackbar(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(
        message,
        style: CustomText.text1(color: CustomColor.black),
      ),
      backgroundColor: CustomColor.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
