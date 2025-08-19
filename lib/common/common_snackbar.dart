import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/app_color.dart';

class CustomSnackBar {
  static showCustomSnackBar(
      {required String title,
      required String message,
      Duration? duration,
      Color? colorText,
      Color? backgroundColor,
      Widget? icon}) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: colorText ?? AppColor.primaryColor,
      backgroundColor: backgroundColor ?? AppColor.secondaryColor,
      icon: icon,
    );
  }

  static showCustomErrorSnackBar(
      {required String title,
      required String message,
      Color? color,
      Duration? duration}) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: Colors.white,
      backgroundColor: color ?? Colors.redAccent,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }

  static showCustomToast(
      {String? title,
      required String message,
      Color? color,
      Duration? duration}) {
    Get.rawSnackbar(
      title: title,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.green,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }

  static showCustomErrorToast(
      {String? title,
      required String message,
      Color? color,
      Duration? duration}) {
    Get.rawSnackbar(
      title: title,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.redAccent,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }

  static dynamic showSnackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(message, style: const TextStyle(color: AppColor.primaryColor)),
        backgroundColor: AppColor.whiteColor,
      ),
    );
  }

  // static showToast(context, {required String messages, Color? textColor}) {
  //   Fluttertoast.showToast(
  //     msg: messages,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 2,
  //     backgroundColor: AppColor.primaryColor,
  //     textColor: textColor ?? AppColor.secondaryColor,
  //     fontSize: 16.0,
  //   );
  // }

  static showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: AppColor.whiteColor,
      content: Row(
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.blackColor),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child:  Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Loading",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColor.blackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<bool> hide(context) async {
    try {
      Navigator.of(context).pop();
      debugPrint('ProgressDialog dismissed');
      return Future.value(true);
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }
}
