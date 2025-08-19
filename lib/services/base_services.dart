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


// Dio error handle function
// if (ex.type == DioErrorType.connectTimeout) {
//   // It occurs when url is opened timeout.
//   print("Connection Timeout Exception");
// } else if (ex.type == DioErrorType.sendTimeout) {
//   // It occurs when url is sent timeout.
//   print("Send Timeout Exception");
// } else if (ex.type == DioErrorType.receiveTimeout) {
//   //It occurs when receiving timeout
//   print("Receive Timeout Exception");
// } else if (ex.type == DioErrorType.response) {
//   // When the server response, but with a incorrect status, such as 404, 503...
//   print("Response Error Exception");
// } else if (ex.type == DioErrorType.cancel) {
//   // When the request is cancelled, dio will throw a error with this type.
//   print("Request Cancelled Exception");
// } else {
//   //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
//   print("Default Error Exception");
// }

// Dio error handle function
// if (ex.type == DioErrorType.connectTimeout) {
//   // It occurs when url is opened timeout.
//   print("Connection Timeout Exception");
// } else if (ex.type == DioErrorType.sendTimeout) {
//   // It occurs when url is sent timeout.
//   print("Send Timeout Exception");
// } else if (ex.type == DioErrorType.receiveTimeout) {
//   //It occurs when receiving timeout
//   print("Receive Timeout Exception");
// } else if (ex.type == DioErrorType.response) {
//   // When the server response, but with a incorrect status, such as 404, 503...
//   print("Response Error Exception");
// } else if (ex.type == DioErrorType.cancel) {
//   // When the request is cancelled, dio will throw a error with this type.
//   print("Request Cancelled Exception");
// } else {
//   //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
//   print("Default Error Exception");
// }



// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:get/get_utils/get_utils.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import '../common/common_snackbar.dart';
// import '../utils/app_string.dart';
// import '../services/api_exceptions.dart';
//
// enum RequestType {
//   get,
//   post,
//   put,
//   delete,
// }
//
// class BaseClient {
//   static final Dio _dio = Dio()
//     ..interceptors.add(PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseBody: true,
//       responseHeader: false,
//       error: true,
//       compact: true,
//       maxWidth: 90,
//     ));
//
//   /// dio getter (used for testing)
//   static get dio => _dio;
//
//   /// perform safe api request
//   static safeApiCall(
//     String url,
//     RequestType requestType, {
//     Map<String, dynamic>? headers,
//     Map<String, dynamic>? queryParameters,
//     required Function(Response response) onSuccess,
//     Function(ApiException)? onError,
//     Function(int value, int progress)? onReceiveProgress,
//     Function(int total, int progress)?
//         onSendProgress, // while sending (uploading) progress
//     Function? onLoading,
//     dynamic data,
//   }) async {
//     try {
//       // 1) indicate loading state
//       await onLoading?.call();
//       // 2) try to perform http request
//       late Response response;
//       if (requestType == RequestType.get) {
//         response = await _dio.get(
//           url,
//           onReceiveProgress: onReceiveProgress,
//           queryParameters: queryParameters,
//           options: Options(
//             headers: headers,
//           ),
//         );
//       } else if (requestType == RequestType.post) {
//         response = await _dio.post(
//           url,
//           data: data,
//           onReceiveProgress: onReceiveProgress,
//           onSendProgress: onSendProgress,
//           queryParameters: queryParameters,
//           options: Options(headers: headers),
//         );
//       } else if (requestType == RequestType.put) {
//         response = await _dio.put(
//           url,
//           data: data,
//           onReceiveProgress: onReceiveProgress,
//           onSendProgress: onSendProgress,
//           queryParameters: queryParameters,
//           options: Options(headers: headers),
//         );
//       } else {
//         response = await _dio.delete(
//           url,
//           data: data,
//           queryParameters: queryParameters,
//           options: Options(headers: headers),
//         );
//       }
//       // 3) return response (api done successfully)
//       await onSuccess(response);
//     } on DioException catch (error, stack) {
//       print(stack);
//       // dio error (api reach the server but not performed successfully
//       _handleDioError(error: error, url: url, onError: onError);
//     } on SocketException {
//       // No internet connection
//       _handleSocketException(url: url, onError: onError);
//     } on TimeoutException {
//       // Api call went out of time
//       _handleTimeoutException(url: url, onError: onError);
//     } catch (error) {
//       // unexpected error for example (parsing json error)
//       _handleUnexpectedException(url: url, onError: onError, error: error);
//     }
//   }
//
//   /// download file
//   static download(
//       {required String url, // file url
//       required String savePath, // where to save file
//       Function(ApiException)? onError,
//       Function(int value, int progress)? onReceiveProgress,
//       required Function onSuccess}) async {
//     try {
//       await _dio.download(
//         url,
//         savePath,
//         options: Options(
//             receiveTimeout: const Duration(seconds: 9999),
//             sendTimeout: const Duration(seconds: 9999)),
//         onReceiveProgress: onReceiveProgress,
//       );
//       onSuccess();
//     } catch (error) {
//       var exception = ApiException(url: url, message: error.toString());
//       onError?.call(exception) ?? _handleError(error.toString());
//     }
//   }
//
//   /// handle unexpected error
//   static _handleUnexpectedException(
//       {Function(ApiException)? onError,
//       required String url,
//       required Object error}) {
//     if (onError != null) {
//       onError(
//         ApiException(
//           message: error.toString(),
//           url: url,
//         ),
//       );
//     } else {
//       _handleError(error.toString());
//     }
//   }
//
//   /// handle timeout exception
//   static _handleTimeoutException(
//       {Function(ApiException)? onError, required String url}) {
//     if (onError != null) {
//       onError(
//         ApiException(
//           message: AppString.serverNotResponding.tr,
//           url: url,
//         ),
//       );
//     } else {
//       _handleError(AppString.serverNotResponding.tr);
//     }
//   }
//
//   /// handle timeout exception
//   static _handleSocketException(
//       {Function(ApiException)? onError, required String url}) {
//     if (onError != null) {
//       onError(ApiException(
//         message: AppString.noInternetConnection.tr,
//         url: url,
//       ));
//     } else {
//       _handleError(AppString.noInternetConnection.tr);
//     }
//   }
//
//   /// handle Dio error
//   static _handleDioError(
//       {required DioException error,
//       Function(ApiException)? onError,
//       required String url}) {
//     // 404 error
//     if (error.response?.statusCode == 404) {
//       if (onError != null) {
//         return onError(ApiException(
//           message: AppString.urlNotFound.tr,
//           url: url,
//           statusCode: 404,
//         ));
//       } else {
//         return _handleError(AppString.urlNotFound.tr);
//       }
//     }
//
//     // no internet connection
//     if (error.message!.toLowerCase().contains('socket')) {
//       if (onError != null) {
//         return onError(ApiException(
//           message: AppString.noInternetConnection.tr,
//           url: url,
//         ));
//       } else {
//         return _handleError(AppString.noInternetConnection.tr);
//       }
//     }
//
//     // check if the error is 500 (server problem)
//     if (error.response?.statusCode == 500) {
//       var exception = ApiException(
//         message: AppString.serverError.tr,
//         url: url,
//         statusCode: 500,
//       );
//
//       if (onError != null) {
//         return onError(exception);
//       } else {
//         return handleApiError(exception);
//       }
//     }
//
//     var exception = ApiException(
//         url: url,
//         message: error.message!,
//         response: error.response,
//         statusCode: error.response?.statusCode);
//     if (onError != null) {
//       return onError(exception);
//     } else {
//       return handleApiError(exception);
//     }
//   }
//
//   /// handle error automaticly (if user didnt pass onError) method
//   /// it will try to show the message from api if there is no message
//   /// from api it will show the reason (the dio message)
//   static handleApiError(ApiException apiException) {
//     String msg = apiException.toString();
//     CustomSnackBar.showCustomErrorToast(message: msg);
//   }
//
//   /// handle errors without response (500, out of time, no internet,..etc)
//   static _handleError(String msg) {
//     CustomSnackBar.showCustomErrorToast(message: msg);
//   }
// }



// import 'package:dio/dio.dart';
// import 'api_exception.dart';
// import 'custom_snackbar.dart';
//
// class CommonApiService {
//   static final Dio _dio = Dio();
//
//   static Future<Response> get({
//     required String url,
//     Map<String, dynamic>? queryParams,
//     Options? options,
//     Function(ApiException)? onError,
//   }) async {
//     try {
//       final response = await _dio.get(url, queryParameters: queryParams, options: options);
//       return response;
//     } catch (error) {
//       _handleError(url: url, error: error, onError: onError);
//       rethrow;
//     }
//   }
//
//   static Future<Response> post({
//     required String url,
//     dynamic data,
//     Options? options,
//     Function(ApiException)? onError,
//   }) async {
//     try {
//       final response = await _dio.post(url, data: data, options: options);
//       return response;
//     } catch (error) {
//       _handleError(url: url, error: error, onError: onError);
//       rethrow;
//     }
//   }
//
//   static Future<Response> put({
//     required String url,
//     dynamic data,
//     Options? options,
//     Function(ApiException)? onError,
//   }) async {
//     try {
//       final response = await _dio.put(url, data: data, options: options);
//       return response;
//     } catch (error) {
//       _handleError(url: url, error: error, onError: onError);
//       rethrow;
//     }
//   }
//
//   static Future<Response> delete({
//     required String url,
//     dynamic data,
//     Options? options,
//     Function(ApiException)? onError,
//   }) async {
//     try {
//       final response = await _dio.delete(url, data: data, options: options);
//       return response;
//     } catch (error) {
//       _handleError(url: url, error: error, onError: onError);
//       rethrow;
//     }
//   }
//
//   static Future<void> download({
//     required String url,
//     required String savePath,
//     Function(int, int)? onReceiveProgress,
//     Function(ApiException)? onError,
//     required Function onSuccess,
//   }) async {
//     try {
//       await _dio.download(
//         url,
//         savePath,
//         onReceiveProgress: onReceiveProgress,
//         options: Options(receiveTimeout: const Duration(seconds: 9999), sendTimeout: const Duration(seconds: 9999)),
//       );
//       onSuccess();
//     } catch (error) {
//       _handleError(url: url, error: error, onError: onError);
//     }
//   }
//
//   static void _handleError({
//     required String url,
//     required Object error,
//     Function(ApiException)? onError,
//   }) {
//     var exception = ApiException(url: url, message: error.toString());
//     if (onError != null) {
//       onError(exception);
//     } else {
//       CustomSnackBar.showCustomErrorToast(message: exception.toString());
//     }
//     // Log the error
//     print('Error occurred: $exception');
//   }
// }

// class ApiException implements Exception {
//   final String message;
//   final String url;
//   final int? statusCode;
//   final Response? response;
//
//   ApiException({
//     required this.message,
//     required this.url,
//     this.statusCode,
//     this.response,
//   });
//
//   @override
//   String toString() {
//     return 'ApiException: $message (URL: $url, Status Code: $statusCode)';
//   }
// }

// import 'package:flutter/material.dart';
//
// class CustomSnackBar {
//   static void showCustomErrorToast({required String message}) {
//     // Implement your custom error toast here
//     print('Error: $message');
//   }
// }