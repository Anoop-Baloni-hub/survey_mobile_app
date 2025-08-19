import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget spacer() => const Spacer();
Widget spacerWithFlex({required int flex}) => Spacer(flex: flex);
Widget h(double value) => SizedBox(height: value.h);
Widget w(double value) => SizedBox(width: value.w);
Widget expanded({required Widget child}) => Expanded(child: child);
Widget sizedBox({double? height, double? width, Widget? child}) => SizedBox(
      height: height?.h,
      width: width?.w,
      child: child,
    );
Widget expandedWithFlex({required int flex, required Widget child}) => Expanded(
      flex: flex,
      child: child,
    );
