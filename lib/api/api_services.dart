import 'package:dio/dio.dart';
import 'package:survey_app/services/base_services.dart';

import 'injection_container.dart';
final DioClient apiClient = DioClient();

class DioClient {
  final Dio dio = getDio();

   Options options = Options(
     receiveDataWhenStatusError: true,
     contentType: "application/json",
     sendTimeout: const Duration(seconds: 5),
     receiveTimeout: const Duration(seconds: 5),
   );

  String? bearerToken;
  void setToken(String token) {
    bearerToken = token;
  }

  Map<String, dynamic> getHeaders( isAuthRequired) {
    if (isAuthRequired && bearerToken != null) {
      return {"Authorization": "Bearer $bearerToken"};
    }
    return {};
  }

   ///Get Api ======
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    bool isAuthRequired = false,
  }) async {
    options.headers = getHeaders(isAuthRequired);
    final fullUrl = Uri.parse(url).replace(queryParameters: queryParameters);
    print("GET Request → $fullUrl");
    print("Headers → ${options.headers}");

    try {
      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      return response.data;
    } catch (error) {

      print("GET request error: $error");
      return null;
    }
  }

  ///Post Api ======
   Future <dynamic> post ({required String url, Object? requestBody,
     bool isAuthRequired = false})async{
     options.headers = getHeaders(isAuthRequired);

     try{
       Response response;
       if(requestBody == null){
         response = await dio.post(url, options: options);
       } else{
         response = await dio.post(url, data: requestBody, options: options);
       }
       return response.data ;

     } catch (error){
       return null;
     }
   }

  ///Put Api ======
  Future <dynamic> put ({required String url, Object? requestBody, bool isAuthRequired = false})async{
    options.headers = getHeaders(isAuthRequired);

    try{
      Response response;
      if(requestBody == null){
        response = await dio.put(url, options: options);
      } else{
        response = await dio.put(url, data: requestBody, options: options);
      }
      return response.data ;

    } catch (error){
      return null;
    }
  }


  ///Patch Api ======
  Future <dynamic> patch ({required String url, Object? requestBody, bool isAuthRequired = false})async{
    options.headers = getHeaders(isAuthRequired);

    try{
      Response response;
      if(requestBody == null){
        response = await dio.patch(url, options: options);
      } else{
        response = await dio.patch(url, data: requestBody, options: options);
      }
      return response.data ;

    } catch (error){
      return null;
    }
  }


  ///Delete Api ======
  Future <dynamic> delete ({required String url, Object? requestBody, bool isAuthRequired = false})async{
    options.headers = getHeaders(isAuthRequired);

    try{
      Response response;
      if(requestBody == null){
        response = await dio.delete(url, options: options);
      } else{
        response = await dio.delete(url, data: requestBody, options: options);
      }
      return response.data ;

    } catch (error){
      return null;
    }
  }

}
