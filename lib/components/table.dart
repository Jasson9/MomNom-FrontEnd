import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../etc/styles.dart';
import 'package:intl/intl.dart';

mixin CustomTable {
  // List<TextEditingController> multiFieldInputControllers = [];
  static Table defaultTable(List<List<String>> items) {
    return Table(
      border: TableBorder.symmetric(
        inside: BorderSide(color: Colors.black, width: 1),
      ),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children:
          items.map((e) {
            return TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    e[0],
                    style: CustomText.text1(color: CustomColor.black, bold: true),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    e[1],
                    style: CustomText.text1(color: CustomColor.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    e[2],
                    style: CustomText.text1(color: CustomColor.black),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
