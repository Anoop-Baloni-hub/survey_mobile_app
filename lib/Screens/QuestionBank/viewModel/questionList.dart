class QuestionListModel {
  Result? result;
  String? message;

  QuestionListModel({this.result, this.message});

  QuestionListModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Result {
  List<QuestionResponseModel>? questionResponseModel;
  int? totalRecords;
  int? totalPages;

  Result({this.questionResponseModel, this.totalRecords, this.totalPages});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['questionResponseModel'] != null) {
      questionResponseModel = <QuestionResponseModel>[];
      json['questionResponseModel'].forEach((v) {
        questionResponseModel!.add(new QuestionResponseModel.fromJson(v));
      });
    }
    totalRecords = json['totalRecords'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionResponseModel != null) {
      data['questionResponseModel'] =
          this.questionResponseModel!.map((v) => v.toJson()).toList();
    }
    data['totalRecords'] = this.totalRecords;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class QuestionResponseModel {
  int? questionId;
  int? dateValidationId;
  String? questionText;
  int? answerTypeId;
  String? answerType;
  String? categories;
  bool? isMandatory;
  int? reOrder;
  String? modifiedOn;
  Null minimumCharacter;
  Null maximumCharacter;
  Null choice1;
  Null choice2;
  int? totalCount;

  QuestionResponseModel(
      {this.questionId,
        this.dateValidationId,
        this.questionText,
        this.answerTypeId,
        this.answerType,
        this.categories,
        this.isMandatory,
        this.reOrder,
        this.modifiedOn,
        this.minimumCharacter,
        this.maximumCharacter,
        this.choice1,
        this.choice2,
        this.totalCount});

  QuestionResponseModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    dateValidationId = json['dateValidationId'];
    questionText = json['questionText'];
    answerTypeId = json['answerTypeId'];
    answerType = json['answerType'];
    categories = json['categories'];
    isMandatory = json['isMandatory'];
    reOrder = json['reOrder'];
    modifiedOn = json['modifiedOn'];
    minimumCharacter = json['minimumCharacter'];
    maximumCharacter = json['maximumCharacter'];
    choice1 = json['choice1'];
    choice2 = json['choice2'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['dateValidationId'] = this.dateValidationId;
    data['questionText'] = this.questionText;
    data['answerTypeId'] = this.answerTypeId;
    data['answerType'] = this.answerType;
    data['categories'] = this.categories;
    data['isMandatory'] = this.isMandatory;
    data['reOrder'] = this.reOrder;
    data['modifiedOn'] = this.modifiedOn;
    data['minimumCharacter'] = this.minimumCharacter;
    data['maximumCharacter'] = this.maximumCharacter;
    data['choice1'] = this.choice1;
    data['choice2'] = this.choice2;
    data['totalCount'] = this.totalCount;
    return data;
  }
}



class SubmitQuestionModel {
  int? result;
  String? message;

  SubmitQuestionModel({this.result, this.message});

  SubmitQuestionModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      result = 0;
      message = "No response";
      return;
    }
    result = json['result'] is int ? json['result'] : 0;
    message = json['message'];

    // normalize: treat -1 as success if message says "deleted successfully"
    if (result == -1 && (message?.toLowerCase().contains("success") ?? false)) {
      result = 1;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
    };
  }
}


