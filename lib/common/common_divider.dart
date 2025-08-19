import 'package:flutter/material.dart';
import '../utils/app_color.dart';

Widget divider({Color? color, thickness, indent, endIndent}) {
  return Divider(
    color: color ?? AppColor.darkBlueColor,
    thickness: thickness,
    indent: indent,
    endIndent: endIndent,
  );
}
