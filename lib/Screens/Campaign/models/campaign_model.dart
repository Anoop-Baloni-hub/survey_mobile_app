class Campaign {
  final int campaignId;
  final String campaignName;
  final DateTime startDate;
  final DateTime endDate;
  final int totalSurveys;
  final int activeSurveys;
  final int inactiveSurveys;
  final int draftedSurveys;
  final DateTime modifiedOn;

  final List<CategoryModel> categoryModel;

  Campaign({
    required this.campaignId,
    required this.campaignName,
    required this.startDate,
    required this.endDate,
    required this.totalSurveys,
    required this.activeSurveys,
    required this.inactiveSurveys,
    required this.draftedSurveys,
    required this.modifiedOn,
    required this.categoryModel,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      campaignId: json['campaignId'] ?? 0,
      campaignName: json['campaignName'] ?? '',
      startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(json['endDate'] ?? '') ?? DateTime.now(),
      totalSurveys: json['totalSurveys'] ?? 0,
      activeSurveys: json['activeSurveys'] ?? 0,
      inactiveSurveys: json['inactiveSurveys'] ?? 0,
      draftedSurveys: json['draftedSurveys'] ?? 0,
      modifiedOn: DateTime.tryParse(json['modifiedOn'] ?? '') ?? DateTime.now(),
      categoryModel: (json['categoryModel'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}


class CreateCampaignResponse {
  final int result;
  final String message;

  CreateCampaignResponse({required this.result, required this.message});

  factory CreateCampaignResponse.fromJson(Map<String, dynamic> json) {
    return CreateCampaignResponse(
      result: json['result'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}


class CategoryModel {
  final int categoryId;

  CategoryModel({required this.categoryId});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
    };
  }
}
