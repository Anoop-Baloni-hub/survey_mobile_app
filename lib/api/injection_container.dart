

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:survey_app/utils/print_values.dart';

Dio getDio(){
  Dio dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(

      onRequest: (RequestOptions options, handler){
        printValue(tag: 'API URl:', '${options.uri}');
        printValue(tag: 'HEADER:', '${options.headers}');
        printValue(tag: 'REQUEST BODY:', jsonEncode(options.data));
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler){
        printValue(tag: 'API RESPONSE:', response.data);
        return handler.next(response);
      },

      onError:  (DioException e , handler){
        printValue(tag: 'STATUS CODE:', '${e.response?.statusCode?? ""}');
        printValue(tag: 'HEADER:', e.response?.data??"");
        return handler.next(e);
  }
    )
  );
return Dio();

}