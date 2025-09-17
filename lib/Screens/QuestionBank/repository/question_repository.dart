

import 'package:dio/dio.dart';
import 'package:survey_app/api/api_url.dart';

import '../../../api/api_services.dart';
import '../viewModel/AnswerList.dart';
import '../viewModel/questionList.dart';


class QuestionRepository {
  final DioClient _client = apiClient;

  Future<dynamic> createQuestion(Map<String, dynamic> body) async {
    try {
      final response = await _client.post(
        url: ApiUrl.addQuestion,
        requestBody: body,
        isAuthRequired: true,
      );
      return response;
    } catch (e) {
      print(" createQuestion error: $e");
      return null;
    }
  }

  Future<SubmitQuestionModel?> deleteQuestion(int questionId) async {
    try {
      final response = await _client.delete(
        url: "${ApiUrl.questionList}/$questionId",
        isAuthRequired: true,
      );

      if (response == null) {
        print("Delete API Response is null");
        return null;
      }

      final Map<String, dynamic> data =
      response is Map<String, dynamic> ? response : (response.data ?? {});

      print("Delete API Response → $data");

      return SubmitQuestionModel.fromJson(data);
    } catch (e, stack) {
      print("deleteQuestion error: $e");
      print(stack);
      return null;
    }
  }

  Future<SubmitAnswerChoiceModel?> deleteAnswer(int answerId) async {
    try {
      final response = await _client.delete(
        url: "${ApiUrl.answerChoiceList}/$answerId",
        isAuthRequired: true,
      );

      if (response == null) {
        print("Delete API Response is null");
        return null;
      }

      final Map<String, dynamic> data =
      response is Map<String, dynamic> ? response : (response.data ?? {});

      print("Delete API Response → $data");

      return SubmitAnswerChoiceModel.fromJson(data);
    } catch (e, stack) {
      print("deleteAnswer error: $e");
      print(stack);
      return null;
    }
  }

  Future<SubmitQuestionModel?> updateQuestion(
      int questionId, Map<String, dynamic> body) async {
    try {
      final updatedBody = {
        ...body,
        "questionId": questionId,
      };

      final response = await _client.put(
        url: ApiUrl.questionList,
        requestBody: updatedBody,
        isAuthRequired: true,
      );

      if (response == null) {
        print("Update API returned null");
        return null;
      }

      print("Update API Response → $response");
      return SubmitQuestionModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print("updateQuestion error: $e");
      return null;
    }
  }

  Future<SubmitAnswerChoiceModel?> createAnswerChoiceGroup(
      Map<String, dynamic> body) async {
    try {
      final response = await _client.post(
        url: ApiUrl.answerChoiceList,
        requestBody: body,
        isAuthRequired: true,
      );
      print("📥 Raw API Response (Create) → $response");

      if (response == null) return null;
      final data = response is Map<String, dynamic> ? response : response.data;
      print("📥 Parsed API Data → $data");
      return SubmitAnswerChoiceModel.fromJson(data);
    } catch (e) {
      print("createAnswerChoiceGroup error: $e");
      return null;
    }
  }

  Future<SubmitAnswerChoiceModel?> updateAnswerChoiceGroup(
      int groupId, Map<String, dynamic> body) async {
    try {
      final updatedBody = {
        ...body,
        "answerChoiceGroupId": groupId,
      };

      final response = await _client.put(
        url: ApiUrl.answerChoiceList,
        requestBody: updatedBody,
        isAuthRequired: true,
      );

      if (response == null) return null;

      final data = response is Map<String, dynamic> ? response : response.data;
      print("Update AnswerChoiceGroup API Response → $data");

      return SubmitAnswerChoiceModel.fromJson(data);
    } catch (e) {
      print("updateAnswerChoiceGroup error: $e");
      return null;
    }
  }

  Future<List<AnswerType>> getAnswerTypes() async {
    try {
      final response = await _client.get(
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
