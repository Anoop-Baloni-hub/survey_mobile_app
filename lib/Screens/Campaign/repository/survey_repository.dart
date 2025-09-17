
import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../api/api_services.dart';
import '../../../api/api_url.dart';
import '../../QuestionBank/viewModel/AnswerList.dart';
import '../models/survey_model.dart';

class SurveyRepository {
  final DioClient _dioClient = ApiUrl.dioClient;

  Future<SurveyResponseModel?> saveSurveyDescription(Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.post(
        url: ApiUrl.saveSurveyDescription,
        requestBody: body,
        isAuthRequired: true,
      );

      print("saveSurveyDescription raw response → $response");
       print('full api response is: ${ApiUrl.saveSurveyDescription}');
      if (response == null) {
        return null;
      }

      if (response is! Map<String, dynamic>) {
        print(" Unexpected response type: ${response.runtimeType}");
        return null;
      }

      return SurveyResponseModel.fromJson(response);
    } catch (e) {
      print(" Error saving survey → $e");
      return null;
    }
  }

  Future<SaveSurveyQuestionModel?> updateSurveyQuestion(Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.post(
        url: ApiUrl.updateSurveyQuestion,
        requestBody: body,
        isAuthRequired: true,
      );

      print("updateSurveyQuestion raw response → $response");

      if (response == null || response is! Map<String, dynamic>) {
        print(" updateSurveyQuestion → invalid or null response");
        return null;
      }

      return SaveSurveyQuestionModel.fromJson(response);
    } on DioException catch (e) {
      print(" DioException in updateSurveyQuestion → ${e.message}");
      print("Status code → ${e.response?.statusCode}");
      print("Response → ${e.response?.data}");
      return null;
    } catch (e, stack) {
      print(" Unexpected error in updateSurveyQuestion → $e");
      print(stack);
      return null;
    }
  }


  Future<GetQuestionsResponse?> getQuestions(int categoryId) async {
    try {
      final response = await _dioClient.get(
        url: ApiUrl.getquestionsList,
        queryParameters: {"categoryIds": categoryId.toString()},
        isAuthRequired: true,
      );

      print("getAnswers raw response → $response");
      print("getAnswers raw response type → ${response.runtimeType}");

      Map<String, dynamic>? json;

      if (response is Map<String, dynamic>) {
        json = response;
      } else if (response is String) {
        json = jsonDecode(response) as Map<String, dynamic>;
      } else {
        print(" getAnswers → Unexpected response type: ${response.runtimeType}");
        return null;
      }

      final parsed = GetQuestionsResponse.fromJson(json);
      parsed.debugPrint();
      return parsed;
    } catch (e, stack) {
      print(" Error in getAnswers → $e");
      print(stack);
      return null;
    }
  }

  Future<List<AnswerType>> getAnswerTypes() async {
    try {
      final response = await _dioClient.get(
        url: ApiUrl.answerType,
        isAuthRequired: true,
      );
      print("Raw API response → $response");
      if (response != null && response['result'] != null) {
        final List<dynamic> result = response['result'];
        return result.map((json) => AnswerType.fromJson(json)).toList();
      } else {
        return [];
      }
    }catch (error) {
      print("GET request error: $error");
      if (error is DioException) {
        print("Dio error type → ${error.type}");
        print("Dio error response → ${error.response?.data}");
        print("Dio error status → ${error.response?.statusCode}");
      }
      return [];
    }
  }

}