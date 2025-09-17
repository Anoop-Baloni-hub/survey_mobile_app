class AnswerListModel {
  Result? result;
  String? message;

  AnswerListModel({this.result, this.message});

  AnswerListModel.fromJson(Map<String, dynamic> json) {
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
  List<AnswerGroupResponseModel>? answerGroupResponseModel;
  int? totalRecords;
  int? totalPages;

  Result({this.answerGroupResponseModel, this.totalRecords, this.totalPages});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['answerGroupResponseModel'] != null) {
      answerGroupResponseModel = <AnswerGroupResponseModel>[];
      json['answerGroupResponseModel'].forEach((v) {
        answerGroupResponseModel!.add(new AnswerGroupResponseModel.fromJson(v));
      });
    }
    totalRecords = json['totalRecords'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answerGroupResponseModel != null) {
      data['answerGroupResponseModel'] =
          this.answerGroupResponseModel!.map((v) => v.toJson()).toList();
    }
    data['totalRecords'] = this.totalRecords;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class AnswerGroupResponseModel {
  int? answerChoiceGroupId;
  String? answerChoiceGroupName;
  String? modifiedOn;
  String? categories;
  int? totalCount;

  AnswerGroupResponseModel(
      {this.answerChoiceGroupId,
        this.answerChoiceGroupName,
        this.modifiedOn,
        this.categories,
        this.totalCount});

  AnswerGroupResponseModel.fromJson(Map<String, dynamic> json) {
    answerChoiceGroupId = json['answerChoiceGroupId'];
    answerChoiceGroupName = json['answerChoiceGroupName'];
    modifiedOn = json['modifiedOn'];
    categories = json['categories'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerChoiceGroupId'] = this.answerChoiceGroupId;
    data['answerChoiceGroupName'] = this.answerChoiceGroupName;
    data['modifiedOn'] = this.modifiedOn;
    data['categories'] = this.categories;
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class SubmitAnswerChoiceModel {
  final int? result;
  final String? message;

  SubmitAnswerChoiceModel({this.result, this.message});

  factory SubmitAnswerChoiceModel.fromJson(Map<String, dynamic> json) {
    return SubmitAnswerChoiceModel(
      result: json['result'],
      message: json['message'],
    );
  }
}


class AnswerType {
  final int id;
  final String name;

  AnswerType({required this.id, required this.name});

  factory AnswerType.fromJson(Map<String, dynamic> json) {
    return AnswerType(
      id: json['id'],
      name: json['name'],
    );
  }
}

