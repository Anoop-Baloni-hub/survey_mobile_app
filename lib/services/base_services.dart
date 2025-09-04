import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:survey_app/services/print_api_name_and_response.dart';

String token="";
class BaseService {

  Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(
  LogInterceptor(
      error: true,
      responseBody: false,
      responseHeader: false,
      request: true,
      requestBody: true,
      requestHeader: true,
      logPrint: (object) {
        if (kDebugMode) {
          print(object.toString());
        }
      },
    ),
    );

    dio.options.headers["authorization"] = "Bearer $token";
        dio.options.headers["Content-Type"] = "application/json";
    return dio;
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParameters,bool isShowMessage = true}) async {
    Dio dio = getDio();
    try {
      final Response response = await dio.get(url, queryParameters: queryParameters);
      PrintAPINameAndResponse.printAPINameResponse(apiName: 'GET', apiUrl: url, response: response);
      return response;
    } on DioException catch(ex) {
      if(ex.response != null) {
        PrintAPINameAndResponse.printAPIErrorResponse(
            apiUrl: url, response: ex.response!);
        if(isShowMessage) {

          // ShowAppMessage.showMessage(ex.response!.data['message'].toString(), snackBarType: SnackBarType.error);
        }
        // getx.Get.snackbar('Error', ex.response!.data['message'].toString(),barBlur: 7,colorText: Colors.white,backgroundColor: Colors.redAccent,overlayColor: Colors.white);
        return ex.response!;
      }
      if (kDebugMode) {
        log("Error statusCode => ${ex.response?.statusCode}");
        log("Error data => ${ex.response?.data}");
        String errorMessage = DioExceptionHandler.handleError(ex);
        log('API Request Error: $errorMessage');
      }
      throw Exception("Failed to perform GET request: $ex");
    }
  }

  Future<Response> post(String url, {dynamic data,bool isShowMessage = true}) async {
    Dio dio = getDio();
    try {
      final Response response = await dio.post(url, data: data);
      if(response.statusCode == 200) {
        if(isShowMessage) {
          // ShowAppMessage.showMessage(response.data['message'].toString(), snackBarType: SnackBarType.success);
        }
      }
      PrintAPINameAndResponse.printAPINameResponse(apiName: 'POST', apiUrl: url, response: response);
      return response;
    } on DioException catch(ex) {
      if(ex.response != null) {
        PrintAPINameAndResponse.printAPIErrorResponse(
            apiUrl: url, response: ex.response!
        );
        // ShowAppMessage.showMessage(ex.response!.data['message'].toString(),snackBarType: SnackBarType.error);
        // getx.Get.snackbar('Error', ex.response!.data['message'].toString(),barBlur: 7,colorText: Colors.white,backgroundColor: Colors.redAccent,overlayColor: Colors.white);
        return ex.response!;
      }
      if (kDebugMode) {
        // print("Error data => ${ex.response?.data}");
        String errorMessage = DioExceptionHandler.handleError(ex);
        print('API Request Error: $errorMessage');

      }
      throw Exception("Failed to perform POST request: $ex");
    }
  }

  Future<Response> put(String url, {dynamic data}) async {
    Dio dio = getDio();
    try {
      final Response response = await dio.put(url, data: data);
      PrintAPINameAndResponse.printAPINameResponse(apiName: 'PUT', apiUrl: url, response: response);
      return response;
    } on DioException catch(ex) {
      if(ex.response != null) {
        PrintAPINameAndResponse.printAPIErrorResponse(
            apiUrl: url, response: ex.response!);
        // ShowAppMessage.showMessage(ex.response!.data['message'].toString(),snackBarType: SnackBarType.error);
        return ex.response!;
      }
      if (kDebugMode) {
        // print("Error data => ${ex.response?.data}");
        String errorMessage = DioExceptionHandler.handleError(ex);
        print('API Request Error: $errorMessage');

      }
      throw Exception("Failed to perform PUT request: $ex");
    }
  }

  Future<Response> delete(String url, {dynamic data}) async {
    Dio dio = getDio();
    try {
      final Response response = await dio.delete(url, data: data);
      if(response.statusCode == 200) {
        // ShowAppMessage.showMessage(response.data['message'].toString(),snackBarType: SnackBarType.success);
      }
      PrintAPINameAndResponse.printAPINameResponse(apiName: 'DELETE', apiUrl: url, response: response);

      return response;
    } on DioException catch(ex) {
      if(ex.response != null) {
        PrintAPINameAndResponse.printAPIErrorResponse(
            apiUrl: url, response: ex.response!);
        // ShowAppMessage.showMessage(ex.response!.data['message'].toString(),snackBarType: SnackBarType.error);
        return ex.response!;
      }
      if (kDebugMode) {
        // print("Error data => ${ex.response?.data}");
        String errorMessage = DioExceptionHandler.handleError(ex);
        print('API Request Error: $errorMessage');

      }
      throw Exception("Failed to perform DELETE request: $ex");
    }
  }
}
class DioExceptionHandler {
  static String handleError(dynamic error) {
    String errorDescription = '';
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Request to API server was canceled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Connection timeout with API server';
          break;
        case DioExceptionType.unknown:
          errorDescription = 'Unknown error occurred';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Receive timeout in connection with API server';
          break;
        case DioExceptionType.badResponse:
          errorDescription =
              _handleResponseError(error.response?.statusCode!);
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = 'Send timeout in connection with API server';
          break;
        case DioExceptionType.badCertificate:
          errorDescription = 'Bad Certificate error occurred';
          break;
        case DioExceptionType.connectionError:
          errorDescription = 'Connection error occurred';
          break;
      }
    } else {
      errorDescription = 'Unexpected error occurred';
    }

    return errorDescription;
  }

  static String _handleResponseError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Received invalid status code: $statusCode';
    }
  }
}
