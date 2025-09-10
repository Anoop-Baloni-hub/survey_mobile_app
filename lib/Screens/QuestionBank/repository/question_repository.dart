

import 'package:survey_app/api/api_url.dart';

import '../../../api/api_services.dart';
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


      final Map<String, dynamic> data =
      response is Map<String, dynamic> ? response : response.data;

      print("Delete API Response → $data"); // Debugging

      return SubmitQuestionModel.fromJson(data);
    } catch (e) {
      print("deleteQuestion error: $e");
      return null;
    }
  }

  Future<SubmitQuestionModel?> updateQuestion(
      int questionId, Map<String, dynamic> body) async {
    try {
      // backend ko sirf base url chahiye, id body me rahega
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


}
