import 'package:flutter/material.dart';
import '../utils/app_color.dart';

Future<DateTime?> datePicker({
  context,
  hintText,
  required DateTime currentDate,
}) {
  return showDatePicker(
    context: context,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: AppColor.primaryColor,
          ),
          dialogBackgroundColor: AppColor.primaryColor,
        ),
        child: child ?? Text(hintText),
      );
    },
    initialDate: currentDate,
    firstDate: DateTime(1900),
    lastDate: currentDate,
    helpText: hintText,
  );
}
