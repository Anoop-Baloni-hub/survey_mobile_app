import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FontFamily {dmsans}

class AppTextStyle {

  static TextStyle _regular(double size, Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    switch(fontFamily) {
      case FontFamily.dmsans:
        return TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w400,
          fontSize: size.sp,
          height: 1,
          color: color,
          decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
        );
    }
  }

  static TextStyle _medium(double size, Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    switch(fontFamily) {
      case FontFamily.dmsans:
        return TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w500,
          fontSize: size.sp,
          height: 1,
          color: color,
          decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
        );
    }
  }

  static TextStyle _semiBold(double size, Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    switch(fontFamily) {
      case FontFamily.dmsans:
        return TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.w600,
          fontSize: size.sp,
          height: 1,
          color: color,
          decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
        );
    }
  }

  static TextStyle _bold(double size, Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    switch(fontFamily) {
      case FontFamily.dmsans:
        return TextStyle(
          fontFamily: "DM Sans",
          fontWeight: FontWeight.bold,
          fontSize: size.sp,
          height: 1,
          color: color,
          decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
        );
    }
  }

  static TextStyle bold10(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(10, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold11(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(11, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold12(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(12, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold13(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(13, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold14(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(14, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold15(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(15, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold16(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(16, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold17(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(17, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold18(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(18, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold19(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(19, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold20(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(20, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold21(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(21, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold22(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(22, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold23(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(23, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold24(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(24, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold25(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(25, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold26(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(26, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold27(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(27, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold28(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(28, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold29(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(29, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold30(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(30, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold31(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(31, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold32(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _bold(32, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold10(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(10, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold11(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(11, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold12(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(12, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold13(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(13, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold14(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(14, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold15(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(15, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold16(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(16, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold17(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(17, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold18(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(18, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold19(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(19, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold20(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(20, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold21(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(21, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold22(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(22, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold23(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(23, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold24(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(24, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold25(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(25, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold26(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(26, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold27(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(27, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold28(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(28, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold29(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(29, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold30(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(30, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold31(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(31, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle semiBold32(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _semiBold(32, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular7(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(7, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular8(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(8, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular10(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(10, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular11(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(11, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular12(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(12, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular13(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(13, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular14(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(14, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular15(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(15, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular16(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(16, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular17(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(17, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular18(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(18, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular19(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(19, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular20(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(20, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular21(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(21, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular22(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(22, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular23(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(23, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular24(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(24, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular25(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(25, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular26(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(26, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular27(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(27, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular28(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(28, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular29(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(29, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular30(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(30, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular31(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(31, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular32(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _regular(32, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium10(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(10, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium11(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(11, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium12(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(12, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium13(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(13, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium14(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(14, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium15(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(15, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium16(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(16, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium17(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(17, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium18(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(18, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium19(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(19, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium20(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(20, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium21(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(21, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium22(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(22, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium23(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(23, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium24(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(24, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium25(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(25, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium26(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(26, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium27(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(27, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium28(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(28, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium29(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(29, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium30(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(30, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium31(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(31, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium32(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.dmsans}) {
    return _medium(32, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }
}