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
  TextEditingController answerTextController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController optionsController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  final optionsList =<String> [
    'Boolean',
    'Single Choice',
    'Multiple Choice',
    'Ranking',
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

  Future<bool> submitQuestion({bool isEdit = false, int? questionId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final selectedCategories = categoryList.entries
          .where((e) => e.value)
          .map((e) => _mapCategoryNameToId(e.key))
          .toList();

      final body = {
        "surveyQuestionId": isEdit ? 1 : 0,
        "questionId": isEdit ? (questionId ?? 0) : 0,
        "questionText": textController.text.trim(),
        "answerTypeId": _mapAnswerTypeToId(selectedOption.value),
        "dateValidationId": 1,
        "isActive": true,
        "createdBy": "admin",
        "updatedBy": "admin",
        "isDefault": true,
        "minimumCharacter": isEdit ? int.tryParse(minController.text) ?? 0 : 0,
        "maximumCharacter": isEdit ? int.tryParse(maxController.text) ?? 0 : 0,
        "categoryModel": selectedCategories.map((id) => {"categoryId": id}).toList(),
        "questionAnswerChoiceModel": [],
      };

      dynamic response;
      if (isEdit) {
        response = await questionRepo.updateQuestion(questionId ?? 0, body);

        if (response != null) {
          final index = questionList.indexWhere((q) => q.questionId == questionId);
          if (index != -1) {
            questionList[index].questionText = body["questionText"]?.toString();
            questionList[index].answerTypeId = body["answerTypeId"] as int?;
            questionList[index].categories = categoryController.text;
            questionList[index].minimumCharacter =
            body["minimumCharacter"] as int?;
            questionList[index].maximumCharacter =
            body["maximumCharacter"] as int?;
          }

          filteredQuestionList.assignAll(questionList);
        }
      } else {
        response = await questionRepo.createQuestion(body);
        print("Create API Response → $response");

        if (response != null) {
          if (response is Map<String, dynamic> && response["result"] != null) {
            final result = response["result"];

            if (result is Map<String, dynamic>) {
              final newQuestion = QuestionResponseModel.fromJson(result);
              questionList.add(newQuestion);
            } else if (result is List) {
              final newQuestions = result
                  .map((e) => QuestionResponseModel.fromJson(e))
                  .toList();
              questionList.addAll(newQuestions);
            }
          }

          filteredQuestionList.assignAll(questionList);
        }
      }

      if (response != null) {
        Get.snackbar(" Success", isEdit ? "Question updated" : "Question created");
        return true;
      } else {
        Get.snackbar(" Error", "Something went wrong");
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", "Submit failed: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// map answer type string -> backend ID
  int _mapAnswerTypeToId(String option) {
    switch (option) {
      case "Boolean":
        return 1;
      case "Single Choice":
        return 2;
      case "Multiple Choice":
        return 3;
      case "Ranking":
        return 4;
      case "Date":
        return 5;
      case "Numeric":
        return 6;
      case "Integer":
        return 7;
      case "Image":
        return 8;
      case "Slider":
        return 9;
      case "Likert Scale":
        return 10;
      case "Rating Scale":
        return 11;
      case "Matrix Question":
        return 12;
      case "Star Type Rating":
        return 13;
      case "Overall Experience":
        return 14;
      case "Text":
        return 15;
      default:
        return 0;
    }
  }

  /// map category string -> backend ID
  int _mapCategoryNameToId(String category) {
    switch (category) {
      case "Mortgage":
        return 1;
      case "Real State":
        return 2;
      default:
        return 0;
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

  /// map answer type ID -> string (for edit mode)
  String mapAnswerTypeIdToName(int id) {
    switch (id) {
      case 1:
        return "Boolean";
      case 2:
        return "Single Choice";
      case 3:
        return "Multiple Choice";
      case 4:
        return "Ranking";
      case 5:
        return "Date";
      case 6:
        return "Numeric";
      case 7:
        return "Integer";
      case 8:
        return "Image";
      case 9:
        return "Slider";
      case 10:
        return "Likert Scale";
      case 11:
        return "Rating Scale";
      case 12:
        return "Matrix Question";
      case 13:
        return "Star Type Rating";
      case 14:
        return "Overall Experience";
      case 15:
        return "Text";
      default:
        return "";
    }
  }

  /// map category ID -> string (for edit mode)
  String mapCategoryIdToName(int id) {
    switch (id) {
      case 1:
        return "Mortgage";
      case 2:
        return "Real State";
      default:
        return "";
    }
  }


  Future<bool> submitAnswerChoiceGroup({bool isEdit = false, int? groupId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final body = {
        "answerChoiceGroupId": isEdit ? (groupId ?? 0) : 0,
        "answerChoiceGroupName": answerTextController.text.trim(),
        "isActive": true,
        "createdBy": "admin",
        "updatedBy": "admin",
        "answerChoiceModel": [
          {
            "answerChoiceId": isEdit ? 1 : 0,
            "answerChoiceName": answerTextController.text.trim(),
          }
        ],
        "categoryModel": [
          {"categoryId": 1}
        ]
      };

      print("📤 Sending Body → $body");

      dynamic response;
      if (isEdit) {
        response = await questionRepo.updateAnswerChoiceGroup(groupId ?? 0, body);
        print("📥 Update Response → $response");

        if (response != null) {
          final index = answerList.indexWhere((a) => a.answerChoiceGroupId == groupId);
          if (index != -1) {
            answerList[index].answerChoiceGroupName =
                body["answerChoiceGroupName"].toString();
          }
          answerList.refresh();
        }
      } else {
        response = await questionRepo.createAnswerChoiceGroup(body);
        print("📥 Create Response → $response");

        if (response != null && response.result != null) {
          final newGroup = AnswerGroupResponseModel(
            answerChoiceGroupId: response.result,
            answerChoiceGroupName: body["answerChoiceGroupName"].toString(),
            categories: "Category 1",
            totalCount: (body["answerChoiceModel"] as List?)?.length ?? 0,
          );
          // answerList.add(newGroup);
          // filteredAnswerList.clear();
          // filteredAnswerList.addAll(answerList);
          // filteredAnswerList.refresh();
          // answerTextController.clear();
          // answerOptionsControllers.clear();

          answerList.add(newGroup);
          answerList.refresh();
          answerTextController.clear();
          answerOptionsControllers.clear();
        }
      }

      if (response != null) {
        Get.snackbar("Success", isEdit ? "Answer choice updated" : "Answer choice created");
        return true;
      } else {
        Get.snackbar("Error", "Something went wrong");
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print("❌ Exception → $e");
      Get.snackbar("Error", "Submit failed: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }


}

