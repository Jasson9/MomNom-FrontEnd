import 'package:MomNom/pages/dashboard.dart';
import 'package:MomNom/pages/diaryPage.dart';
import 'package:MomNom/pages/exercisePage.dart';
import 'package:MomNom/pages/planPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../etc/styles.dart';
import 'package:intl/intl.dart';

mixin CustomDropdown implements NavigationBar {
  static Widget dropdown(
    List<String> elements,
    String defaultVal,
    ValueChanged<String?> onChange,
  ) {
    print("Default " + defaultVal);
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      // margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      alignment: Alignment.center,
      child: DropdownButton<String>(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        elevation: 16,
        dropdownColor: CustomColor.primary,
        focusColor: CustomColor.primary,
        value: defaultVal,
        iconSize: 30,
        underline: SizedBox(),
        isExpanded: true,
        isDense: true,
        icon: SizedBox(child: Icon(Icons.arrow_drop_down,color: CustomColor.white,),),
        style: CustomText.textMd1(color: CustomColor.black,bold: true),
        borderRadius: BorderRadius.circular(8),
        alignment: Alignment.center,
        items:
            elements.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: CustomText.textMd1(
                      color: CustomColor.black,
                      bold: true,
                    ),
                  ),
                ),
              );
            }).toList(),
        onChanged: onChange,
      ),
    );
  }
}
