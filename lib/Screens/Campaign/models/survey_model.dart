

class SurveyResponseModel {
  final int? surveyId;
  final String message;

  SurveyResponseModel({
    required this.surveyId,
    required this.message,
  });
  factory SurveyResponseModel.fromJson(Map<String, dynamic> json) {
    final rawResult = json['result'];

    int? parsedId;
    if (rawResult is int) {
      parsedId = rawResult;
    } else if (rawResult is String) {
      parsedId = int.tryParse(rawResult);
    } else {
      print("⚠️ Unexpected result type: ${rawResult.runtimeType}, value: $rawResult");
    }

    return SurveyResponseModel(
      surveyId: parsedId,
      message: json['message'] ?? '',
    );
  }

  bool get hasSurveyId => surveyId != null && surveyId! > 0;
}

class SaveSurveyQuestionModel {
  final bool result;
  final String message;

  SaveSurveyQuestionModel({
    required this.result,
    required this.message,
  });

  factory SaveSurveyQuestionModel.fromJson(Map<String, dynamic> json) {
    return SaveSurveyQuestionModel(
      result: json['result'] ?? false,
      message: json['message'] ?? '',
    );
  }
}



class QuestionModel {
  final int questionId;
  final String questionText;
  final int answerTypeId;
  final String? answerType;
  final bool isDefault;

  QuestionModel({
    required this.questionId,
    required this.questionText,
    required this.answerTypeId,
    this.answerType,
    required this.isDefault,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      questionId: json['questionId'] ?? 0,
      questionText: json['questionText'] ?? '',
      answerTypeId: json['answerTypeId'] ?? 0,
      answerType: json['answerType'],
      isDefault: json['isDefault'] ?? false,
    );
  }
}

class GetQuestionsResponse {
  final List<QuestionModel> result;
  final int? resultCount;
  final String message;

  GetQuestionsResponse({
    required this.result,
    this.resultCount,
    required this.message,
  });

  factory GetQuestionsResponse.fromJson(Map<String, dynamic> json) {
    final rawResult = json['result'];

    List<QuestionModel> parsedList = [];
    int? count;

    if (rawResult is List) {
      try {
        parsedList = rawResult
            .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print("❌ Failed to parse questions list → $e");
      }
    } else if (rawResult is int) {
      count = rawResult;
      print("⚠️ Backend returned an int result instead of list → $count");
    } else if (rawResult != null) {
      print("⚠️ Unexpected result type → ${rawResult.runtimeType}, value: $rawResult");
    } else {
      print("⚠️ result is null");
    }

    return GetQuestionsResponse(
      result: parsedList,
      resultCount: count,
      message: json['message'] ?? '',
    );
  }
  bool get hasQuestions => result.isNotEmpty;
  void debugPrint() {
    if (hasQuestions) {
      print("Parsed ${result.length} questions:");
      for (var q in result.take(10)) {
        print("   • ${q.questionId}: ${q.questionText}");
      }
      if (result.length > 10) {
        print("   ...and ${result.length - 10} more");
      }
    } else {
      print("ℹ️ No questions parsed. Count = $resultCount, Message = $message");
    }
  }

}



