import 'package:dio/dio.dart';
import '../data/local/shared_preference/shared_preference.dart';
import 'injection_container.dart';
final DioClient apiClient = DioClient();
class DioClient {
  final Dio dio = getDio();
  String? _token;

  void setToken(String token) {
    _token = token;
  }
   Options options = Options(
     receiveDataWhenStatusError: true,
     contentType: "application/json",
     sendTimeout: const Duration(seconds: 5),
     receiveTimeout: const Duration(seconds: 5),
   );
  String? bearerToken;
  // void setToken(String token) {
  //   bearerToken = token;
  // }

  Map<String, String> getHeaders({bool isAuthRequired = false}) {
    final headers = {'Content-Type': 'application/json'};
    if (isAuthRequired) {
      // Prefer saved token from SharedPreferences if _token is null
      final token = _token ?? MySharedPref.getString("accessToken") ?? '';
      if (token.isNotEmpty) headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

   ///Get Api ======
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    bool isAuthRequired = false,
  }) async {
    options.headers = getHeaders(isAuthRequired: isAuthRequired);
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
     options.headers = getHeaders(isAuthRequired: isAuthRequired);

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
    options.headers = getHeaders(isAuthRequired: isAuthRequired);

    try{
      Response response;
      if(requestBody == null){
        response = await dio.put(url, options: options);
      } else{
        response = await dio.put(url, data: requestBody, options: options);
      }
      return response.data ;

    } catch (error){
      print("PUT request error → $error");
      if (error is DioException) {
        print("Status code → ${error.response?.statusCode}");
        print("Response data → ${error.response?.data}");
      }
      return null;
    }
  }

  ///Patch Api ======
  Future <dynamic> patch ({required String url, Object? requestBody, bool isAuthRequired = false})async{
    options.headers = getHeaders(isAuthRequired: isAuthRequired);

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
    options.headers = getHeaders(isAuthRequired: isAuthRequired);

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
