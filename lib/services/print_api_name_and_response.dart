import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
const String red = "\x1B[31m";
const String green = "\x1B[32m";
const String yellow = "\x1B[33m";
const String blue = "\x1B[34m";
const String magenta = "\x1B[35m";
const String cyan = "\x1B[36m";
const String white = "\x1B[0m";
class PrintAPINameAndResponse {
  static printAPINameResponse(
      {required String apiName,
        required String apiUrl,
        required Response response}) {
    if (kDebugMode) {
      if(response.statusCode == 200) {
        print("$green---------------########################## Response ################################---------------$white");
        print("$apiName Url : $apiUrl");
        print("$apiName API response statusCode : ${response.statusCode}");
        log("$apiName API response : ${response.data.toString()}");
        print(
            "$green---------------########################## Response ################################---------------$white");

      }
    }
  }
  static printAPIErrorResponse(
      {required String apiUrl,
       required Response response}) {
    if (kDebugMode) {
      print(
          "$red---------------########################## Error Response ################################---------------$white");
      print("Url : $apiUrl");
      print("API response statusCode : ${response.statusCode}");
      print("API response : ${jsonEncode(response.data)}");
      print(
          "$red---------------########################## Error Response ################################---------------$white");

    }
  }

  static errorMessageAndRetryPrint({required String message}) {
    if (kDebugMode) {
      print("$red---------------*********************** Error & Attempt ***************************************---------------$white");
      List tempUrl = message.split("[");
      List url = tempUrl[1].split("]");
      print("url : ${url[0]}");
      List messageList = message.split("attempt:");
      print("attempt : ${messageList[1].toString().substring(0, 4)}");
      List error = messageList[1].split("error:");
      print("$red error : ${error[1]}$white");
      print("$red---------------*********************** Error & Attempt ***************************************---------------$white");
    }
  }
}