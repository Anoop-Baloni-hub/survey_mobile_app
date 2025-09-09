import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

import '../../../api/api_services.dart';
import '../../../api/api_url.dart';
import '../../../utils/app_color.dart';
import '../repository/question_repository.dart';
import '../viewModel/AnswerList.dart';
import '../viewModel/questionList.dart';

class QuestionBankController extends GetxController{
  final QuestionRepository questionRepo;
  QuestionBankController(this.questionRepo);
  var selectedIndex = 0.obs;
  var selectedOption = ''.obs;
  final selectedCategoriesText = ''.obs;


  var isLoading = false.obs;
  var errorMessage = "".obs;
  var answerList = <AnswerGroupResponseModel>[].obs;
  var questionList = <QuestionResponseModel>[].obs;
  var filteredQuestionList = <QuestionResponseModel>[].obs;
  var filteredAnswerList = <AnswerGroupResponseModel>[].obs;
  var selectedSort = "Sort By".obs;
  final List<String> sortOptions = ["Last Modified", "Most Responses", "Ending soon"];
  void changeSort(String value) {
    selectedSort.value = value;
  }


  TextEditingController textController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController optionsController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  final optionsList =<String> [
    'Boolean',
    'Single Choice',
    'Multiple Choice',
    'Rainking',
    'Date',
    'Numeric',
    'Integer',
    'Image',
    'Slider',
    'Likert Scale',
    'Rating Scale',
    'Matrix Question',
    'Star Type Rating',
    'Overall Experience',
    'Text',
  ].obs;

  final categoryList = <String, bool>{
    'Mortgage': false,
    'Real State': false,
  }.obs;

  var answerOptionsControllers = <TextEditingController>[].obs;

  void deleteCampaign() {

    print("Campaign deleted");
    Get.snackbar("Deleted", "Campaign has been deleted successfully",
        backgroundColor: AppColor.greenColor, colorText: AppColor.whiteColor);
  }

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() => filterSearch(searchController.text));
    fetchAnswerGroups();
    fetchQuestionGroups();
  }

  Future<void> fetchAnswerGroups({int page = 1, int limit = 100}) async {
    try {
      isLoading(true);
      errorMessage("");

      final queryParams = {
        'pageNumber': page.toString(),
        'pageSize': limit.toString(),
      };
      final fullUrl = Uri.parse(ApiUrl.answerChoiceList).replace(queryParameters: queryParams);
      print("Fetching Answer Groups → $fullUrl");
      print("Headers → ${ApiUrl.dioClient.getHeaders(isAuthRequired: true)}");

      final response = await ApiUrl.dioClient.get(
        url: ApiUrl.answerChoiceList,
        queryParameters: queryParams,
        isAuthRequired: true,
      );

      if (response != null) {
        final model = AnswerListModel.fromJson(response);
        answerList.value = model.result?.answerGroupResponseModel ?? [];

        print("Fetched Answer Groups:");
        filteredAnswerList.assignAll(answerList);
        answerList.forEach((item) {
          print(
              "ID: ${item.answerChoiceGroupId}, "
                  "Name: ${item.answerChoiceGroupName}, "
                  "Category: ${item.categories}, "
                  "Modified On: ${item.modifiedOn}");
        });
      } else {
        errorMessage("Something went wrong: Response is null");
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future <void> fetchQuestionGroups({int page = 1, int limit = 100})async{
  try {
    isLoading(true);
    errorMessage("");

    final queryParams = {
      'pageNumber': page.toString(),
      'pageSize': limit.toString(),
    };
    final fullUrl = Uri.parse(ApiUrl.questionList).replace(queryParameters: queryParams);
    print("Fetching Answer Groups → $fullUrl");
    print("Headers → ${ApiUrl.dioClient.getHeaders(isAuthRequired: true)}");

    final response = await ApiUrl.dioClient.get(
      url: ApiUrl.questionList,
      queryParameters: queryParams,
      isAuthRequired: true,
    );

    if (response != null) {
      final model = QuestionListModel.fromJson(response);
      questionList.value = model.result?.questionResponseModel ?? [];

      print("Fetched Answer Groups:");
      filteredQuestionList.assignAll(questionList);
      questionList.forEach((item) {
        print(
            "ID: ${item.questionId}, "
                "Name: ${item.questionText}, "
                "Category: ${item.categories}, "
                "Modified On: ${item.modifiedOn}");
      });
    } else {
      errorMessage("Something went wrong: Response is null");
    }
  } catch (e) {
    errorMessage(e.toString());
  } finally {
    isLoading(false);
  }
}

  void filterSearch(String query) {
    if (query.isEmpty) {
      filteredQuestionList.assignAll(questionList); // ✅ keeps it reactive
    } else {
      filteredQuestionList.assignAll(
        questionList.where((q) =>
        q.questionText?.toLowerCase().contains(query.toLowerCase()) ?? false
        ),
      );
    }
  }

  Future<void> submitQuestion() async {
    final body = {
      "questionId": 0,
      "questionText": textController.text,
      "answerTypeId": 6,
      "dateValidationId": 1,
      "isActive": true,
      "createdBy": "admin",
      "updatedBy": "admin",
      "categoryModel": [
        {"categoryId": 1}
      ],
      "rateScaleModel": [],
      "questionAnswerChoiceModel": []
    };

    final apiResponse = await questionRepo.createQuestion(body);

    if (apiResponse != null) {
      print(" Question created successfully → $apiResponse");

      final newQuestion = QuestionResponseModel(
        questionId: apiResponse['result'] as int?,
        questionText: body['questionText'].toString(),
        answerTypeId: body['answerTypeId'] as int?,
        dateValidationId: body['dateValidationId'] as int?,
        categories: (body['categoryModel'] as List)
            .map((c) => c['categoryId'].toString())
            .join(","),
        isMandatory: false,
        modifiedOn: DateTime.now().toIso8601String(),
      );

      questionList.add(newQuestion);
      filterSearch(searchController.text);

      Get.snackbar("Success", "Question added successfully");
      textController.clear();
    } else {
      print(" Failed to create question");
      Get.snackbar("Error", "Failed to add question");
    }
  }

  Future<void> deleteQuestion(int questionId) async {
    final result = await questionRepo.deleteQuestion(questionId);

    if (result != null && result.message?.toLowerCase().contains("success") == true) {
      questionList.removeWhere((q) => q.questionId == questionId);
      filteredQuestionList.removeWhere((q) => q.questionId == questionId);
      update();
      Get.snackbar(
        "Success",
        result.message ?? "Question deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Deleted Question → ${result.message}");
    } else {
      Get.snackbar(
        "Error",
        result?.message ?? "Failed to delete question",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Failed to delete question → ${result?.message}");
    }
  }

}
