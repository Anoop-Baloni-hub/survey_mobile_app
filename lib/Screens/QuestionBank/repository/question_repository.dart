

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
}
