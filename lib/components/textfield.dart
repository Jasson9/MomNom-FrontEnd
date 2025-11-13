import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../etc/styles.dart';
import 'package:intl/intl.dart';

class CustomTextField extends TextField {
  // List<TextEditingController> multiFieldInputControllers = [];
  Widget multiFieldInput2({
    String placeholder1 = "Exercise",
    String placeholder2 = "min",
    ValueChanged<String>? onChanged1,
    ValueChanged<String>? onChanged2,
    TextEditingController? controller1,
    TextEditingController? controller2,
    VoidCallback? onDelete,
    VoidCallback? onAdd,
  }){
    return Row(
      spacing: 4,
      children: [
        Expanded(
          child: Container(
            // height: 60,
            child: TextField(
              maxLines: 1,
              onChanged: onChanged1,
              style: CustomText.text1(color: CustomColor.black),
              controller: controller1,
              decoration: InputDecoration(
                  hintText: placeholder1,
                  fillColor: CustomColor.white,
                  filled: true,
                  hintStyle: CustomText.text1(color: CustomColor.darkGray),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  )
              ),
            ),
          ),
        ),
        Container(
          // height: 40,
          width: 60,
          child: TextField(
            maxLines: 1,
            textAlign: TextAlign.right,
            style: CustomText.text1(color: CustomColor.black),
            keyboardType: TextInputType.number,
            onChanged: onChanged2,
            controller: controller2,
            decoration: InputDecoration(
                hintText: "min",
                fillColor: CustomColor.white,
                filled: true,
                hintStyle: CustomText.text1(color: CustomColor.darkGray),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                )
            ),
          ),
        ),
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              child:  IconButton(onPressed: onAdd, icon: Icon(Icons.add,size: 16,),),
            ),
            Container(
              width: 32,
              height: 32,
              child:  IconButton(onPressed: onDelete, icon: Icon(Icons.remove,size: 16,)),
            ),
            // IconButton(onPressed: (){}, icon: Icon(Icons.remove)),
          ],
        )
      ],
    );
  }
  Widget multiFieldInput({
    String placeholder1 = "Food Name",
    String placeholder2 = "Qty",
    String metrics = "gr",
    ValueChanged<String>? onChanged1,
    ValueChanged<String>? onChanged2,
    TextEditingController? controller1,
    TextEditingController? controller2,
    String placeholder = "placeholder",
    bool withHeader = false,
    OutlineInputBorder? border,
    VoidCallback? onDelete,
  }) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withHeader)
          Text(
            placeholder,
            style: CustomText.subHeading3(color: CustomColor.primaryDarker),
            textAlign: TextAlign.start,
          ),
        Row(
          spacing: 10,
          children: [
            if(onDelete != null)
              Container(
                child: IconButton(onPressed: onDelete, icon: Icon(Icons.close)),
                width:48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: CustomColor.primary, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            Expanded(
              flex: 1,
              child: TextField(
                controller: controller1,
                style: CustomText.text1(color: CustomColor.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 10.0,
                  ),
                  hintText: placeholder1,
                  enabledBorder: border??OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: CustomColor.primary,
                        width: 2
                    ),
                  ),
                  hintStyle: CustomText.text1(color: CustomColor.darkGray),
                  border: border??OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: CustomColor.primary,
                      width: 2
                    ),
                  ),
                ),
                maxLines: 1,
                onChanged: onChanged1,
              ),
            ),
            SizedBox(
              width: 64,
              child: TextField(
                controller: controller2,
                style: CustomText.text1(color: CustomColor.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 10.0,
                  ),
                  hintText: placeholder2,
                  enabledBorder: border??OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: CustomColor.primary,
                        width: 2
                    ),
                  ),
                  hintStyle: CustomText.text1(color: CustomColor.darkGray),
                  border: border ?? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: CustomColor.primary,
                      width: 2,
                    ),
                  ),
                ),
                maxLines: 1,
                onChanged: onChanged2,
              ),
            ),
            Text(metrics, style: CustomText.text1(color: CustomColor.black)),
          ],
        ),
      ],
    );
  }

  static Widget input({
    String placeholder = "Placeholder",
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool obscureText = false,
    bool outline = false,
    bool filled = true,
    bool withHeader = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withHeader)
          Text(
            placeholder,
            style: CustomText.subHeading3(color: CustomColor.primaryDarker),
            textAlign: TextAlign.start,
          ),
        Container(
          decoration: BoxDecoration(
            color: filled ? CustomColor.lightGray : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: outline ? CustomColor.primary : Colors.transparent,
              width: outline ? 2 : 0,
            ),
          ),
          height: 40,
          child: TextField(
            keyboardType: keyboardType,
            style: CustomText.text1(color: CustomColor.black),
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 10.0,
              ),
              hintText: placeholder,
              filled: filled,
              fillColor: CustomColor.lightGray,
              hintStyle: CustomText.text1(color: CustomColor.darkGray),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            maxLines: 1,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
      ],
    );
  }

  static Widget grayMultiLines({
    String placeholder = "Placeholder",
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool obscureText = false,
  }) {
    return SizedBox(
      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        minLines: 4,
        style: CustomText.text1(color: CustomColor.darkGray),
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          hintText: placeholder,
          filled: true,
          fillColor: CustomColor.lightGray,
          hintStyle: CustomText.text1(color: CustomColor.darkGray),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }

  static Widget inputWithMetrics({
    int placeholder = 0,
    String metricsText = "kg",
    ValueChanged<double>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool outline = false,
    bool filled = true,
    String headerTitle = "",
    TextEditingController? controller
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerTitle != "")
          Text(
            headerTitle,
            style: CustomText.subHeading3(color: CustomColor.primaryDarker),
            textAlign: TextAlign.start,
          ),
        Container(
          decoration: BoxDecoration(
            color: filled ? CustomColor.lightGray : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: outline ? CustomColor.primary : Colors.transparent,
              width: outline ? 2 : 0,
            ),
          ),
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: CustomText.text1(color: CustomColor.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10.0,
                    ),
                    hintText: placeholder.toString(),
                    hintStyle: CustomText.text1(color: CustomColor.darkGray),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  maxLines: 1,
                  onChanged: (String e) {
                    if (onChanged != null) {
                      if (e != "") {
                        onChanged(double.parse(e));
                      } else {
                        onChanged(0);
                      }
                    }
                  },
                ),
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    metricsText,
                    textAlign: TextAlign.right,
                    style: CustomText.text1(color: CustomColor.black),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget dateTimeForm({
    ValueChanged<String>? onSubmitted,
    required BuildContext context,
    bool outline = true,
    bool filled = true,
    String headerTitle = "",
    ValueChanged<DateTime>? onDateTimeChanged,
    DateTime? value,
  }) {
    print("called " + value.toString());
    if (value == null) {
      value = DateTime.now();
    }
    final TextEditingController _dateController = TextEditingController(
      text: value.day.toString(),
    );
    final TextEditingController _monthController = TextEditingController(
      text: value.month.toString(),
    );
    final TextEditingController _yearController = TextEditingController(
      text: value.year.toString(),
    );

    void dateFieldChange() {
      if (_yearController.value.text == "") {
        _yearController.value = TextEditingValue(text: "0");
      }
      if (_monthController.value.text == "") {
        _monthController.value = TextEditingValue(text: "0");
      }
      if (_dateController.value.text == "") {
        _dateController.value = TextEditingValue(text: "0");
      }
      if (_yearController.value.text.startsWith('0') &&
          _yearController.value.text.length > 1) {
        final newValue = int.parse(_yearController.value.text).toString();
        _yearController.value = _yearController.value.copyWith(
          text: newValue,
          selection: TextSelection.collapsed(offset: newValue.length),
        );
      }
      if (_monthController.value.text.startsWith('0') &&
          _monthController.value.text.length > 1) {
        final newValue = int.parse(_monthController.value.text).toString();
        _monthController.value = _monthController.value.copyWith(
          text: newValue,
          selection: TextSelection.collapsed(offset: newValue.length),
        );
      }
      if (_dateController.value.text.startsWith('0') &&
          _dateController.value.text.length > 1) {
        final newValue = int.parse(_dateController.value.text).toString();
        _dateController.value = _dateController.value.copyWith(
          text: newValue,
          selection: TextSelection.collapsed(offset: newValue.length),
        );
      }

      if (int.parse(_dateController.value.text) > 31) {
        final newValue = "31";
        _dateController.value = _dateController.value.copyWith(
          text: newValue,
          selection: TextSelection.collapsed(offset: newValue.length),
        );
      }

      if (int.parse(_monthController.value.text) > 12) {
        final newValue = "12";
        _monthController.value = _monthController.value.copyWith(
          text: newValue,
          selection: TextSelection.collapsed(offset: newValue.length),
        );
      }

      if (int.parse(_yearController.value.text) > 2999) {
        final newValue = "2999";
        _yearController.value = _yearController.value.copyWith(
          text: newValue,
          selection: TextSelection.collapsed(offset: newValue.length),
        );
      }

      value = DateTime(
        int.parse(_yearController.value.text),
        int.parse(_monthController.value.text),
        int.parse(_dateController.value.text),
      );
      print(value);
      if (onDateTimeChanged != null) {
        onDateTimeChanged(value!);
      }
    }

    void _onCalendarButtonPressed() async {
      DateTime? datePicker = await showDatePicker(
        context: context,
        firstDate: DateTime(0),
        lastDate: DateTime(2999),
        initialDate: DateTime(
          int.parse(_yearController.value.text),
          int.parse(_monthController.value.text),
          int.parse(_dateController.value.text),
        ),
      );
      if (datePicker != null) {
        _dateController.value = TextEditingValue(
          text: datePicker.day.toString(),
        );
        _monthController.value = TextEditingValue(
          text: datePicker.month.toString(),
        );
        _yearController.value = TextEditingValue(
          text: datePicker.year.toString(),
        );
      }

      dateFieldChange();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerTitle != "")
          Text(
            headerTitle,
            style: CustomText.subHeading3(color: CustomColor.primaryDarker),
            textAlign: TextAlign.start,
          ),
        Container(
          height: 40,
          child: Row(
            spacing: 10,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: filled ? CustomColor.lightGray : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                      color: outline ? CustomColor.primary : Colors.transparent,
                      width: outline ? 2 : 0,
                    ),
                  ),
                  child: TextField(
                    style: CustomText.text1(color: CustomColor.black),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 10.0,
                      ),
                      filled: filled,
                      fillColor: CustomColor.lightGray,
                      hintStyle: CustomText.text1(color: CustomColor.darkGray),
                      hintText: "DD",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 1,
                    onChanged: (e)=>dateFieldChange(),
                    controller: _dateController,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: filled ? CustomColor.lightGray : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                      color: outline ? CustomColor.primary : Colors.transparent,
                      width: outline ? 2 : 0,
                    ),
                  ),
                  child: TextField(
                    style: CustomText.text1(color: CustomColor.black),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintStyle: CustomText.text1(color: CustomColor.darkGray),
                      hintText: "MM",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 1,
                    onChanged: (e)=>dateFieldChange(),
                    controller: _monthController,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: filled ? CustomColor.lightGray : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                      color: outline ? CustomColor.primary : Colors.transparent,
                      width: outline ? 2 : 0,
                    ),
                  ),
                  child: TextField(
                    style: CustomText.text1(color: CustomColor.black),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintStyle: CustomText.text1(color: CustomColor.darkGray),
                      hintText: "YYYY",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 1,
                    onChanged: (e)=>dateFieldChange(),
                    controller: _yearController,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: LimitedBox(
                  child: IconButton(
                    onPressed: _onCalendarButtonPressed,
                    icon: const Icon(Icons.calendar_month),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                        Set states,
                      ) {
                        return CustomColor.lightGray;
                      }),
                      shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((
                        Set states,
                      ) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
