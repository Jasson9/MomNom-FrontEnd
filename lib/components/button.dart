import 'package:flutter/material.dart';
import '../etc/styles.dart';

mixin CustomButton implements TextButton {
  // CustomButton({super.key, required super.onPressed, required super.child});

  static TextButton secondary({
    required String text,
    VoidCallback? onPress,
    Color colorFill = CustomColor.tertiary,
    Color colorText = CustomColor.primaryDark,
    double? horizontalPad = 0,
    bool? isDense = false
  }) {
    return TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        backgroundColor: colorFill,
        padding: EdgeInsets.symmetric(horizontal: horizontalPad ?? 0, vertical: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        )
      ),
      child: Text(text, style: CustomText.subHeading3(color: colorText)),
    );
  }

  static Widget dateButton({
    required String day,
    required int date,
    required Function(int date) onPress,
    bool? selected = false,
  }) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              selected == true ? CustomColor.tertiary : Colors.transparent,
        ),
        onPressed: () {
          onPress(date);
        },
        child: Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Text(
                day,
                style: CustomText.subHeading3(color: CustomColor.primaryDark),
              ),
              Text(
                date.toString(),
                style: CustomText.subHeading3(color: CustomColor.primaryDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
