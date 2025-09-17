

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:survey_app/Screens/Campaign/models/survey_model.dart';

import '../../../common/common_widget.dart';
import '../../QuestionBank/viewModel/AnswerList.dart';
import '../repository/survey_repository.dart';

class NewSurveyController extends GetxController {
  final SurveyRepository surveyRepo = SurveyRepository();

  TextEditingController surveyNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController surveyDesController = TextEditingController();
  TextEditingController surveyStartDateController = TextEditingController();
  TextEditingController surveyEndDateController = TextEditingController();
  TextEditingController questionController = TextEditingController();

  var selectedIndex = (-1).obs;
  var selectedTabIndex = 0.obs;
  var answerTypes = <AnswerType>[].obs;
  var optionsList = <String>[].obs;
  var selectedOption = "".obs;
  var isMandatory = false.obs;
  var isSelected = false.obs;
  var inviteReviewer = false.obs;
  var selectedButtonIndex = 0.obs;
  var responseMessage = ''.obs;
  var isLoading = false.obs;
  var questions = <QuestionModel>[].obs;
  final selectedCategoryId = 0.obs;
 // final RxList<QuestionModel> answers = <QuestionModel>[].obs;
  final RxString selectedAnswerType = ''.obs;
  var selectedQuestions = <String>[].obs;

  onCategorySelected(int id) {
    selectedCategoryId.value = id;
  }
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  ///Pick Start Date ====
  Future<void> pickStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (selectedEndDate != null && pickedDate.isAfter(selectedEndDate!)) {
        Get.snackbar("Error", "Start date cannot be after End date",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        return;
      }
      selectedStartDate = pickedDate;
      surveyStartDateController.text =
      pickedDate.toIso8601String().split('T')[0];
    }
  }

  ///Pick End Date ====
  Future<void> pickEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (selectedStartDate != null && pickedDate.isBefore(selectedStartDate!)) {
        Get.snackbar("Error", "End date cannot be before Start date",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        return;
      }
      selectedEndDate = pickedDate;
      surveyEndDateController.text =
      pickedDate.toIso8601String().split('T')[0];
    }
  }

  /// Final validation before submit====
  bool validateDates() {
    if (selectedStartDate == null || selectedEndDate == null) {
      Get.snackbar("Error", "Please select both start and end dates",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return false;
    }

    if (selectedStartDate!.isAfter(selectedEndDate!)) {
      Get.snackbar("Error", "Start date must be before End date",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return false;
    }
    return true;
  }

  var selectedListIndexes = <int>[].obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }

  void selectButton(int index) {
    selectedIndex.value = index;
  }

  RxInt currentStep = 1.obs;
  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  final int totalSteps = 4;

  void nextStep() async {
    if (currentStep.value == 1) {
      final saved = await saveSurvey();
      if (saved) {
        await fetchQuestions(selectedCategoryId.value);
        currentStep.value++;
      }
    } else if (currentStep.value == 2) {
      final res = await saveSurveyQuestion();
      if (res) {
        currentStep.value++;
      }
    } else {
      if (currentStep.value < totalSteps) {
        currentStep.value++;
      }
    }
  }


  final selectList = <String, bool>{
    'Days': false,
    'Weeks': false,
    'Months': false,
    'Years': false,
  }.obs;

  var isExpanded = RxnInt();
  var users = <UserModel>[].obs;
  void toggleExpand(int index) {
    if (isExpanded.value == index) {
      isExpanded.value = null; // collapse
    } else {
      isExpanded.value = index; // expand this card
    }
  }
  @override
  void onInit() {
    super.onInit();
  }
  void submitForm() async {

    try {

      Get.snackbar("Success", "Form Submitted Successfully 🎉",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Failed to submit: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> saveSurvey() async {
    isLoading.value = true;

    final body = {
      "campaignId": 59,
      "surveyId": 0,
      "statusId": 3,
      "surveyName": surveyNameController.text.trim(),
      "surveyDescription": surveyDesController.text.trim(),
      "startDate": surveyStartDateController.text.trim(),
      "endDate": surveyEndDateController.text.trim(),
      "isDraft": false,
      "isActive": true,
      "createdBy": "admin",
      "updatedBy": "admin"
    };

    final SurveyResponseModel? res = await surveyRepo.saveSurveyDescription(
        body);

    if (res != null && res.hasSurveyId) {
      print(" Survey saved successfully → id=${res.surveyId}");
      Get.snackbar("Success", res.message);
      return true;
    } else {
      responseMessage.value = "Something went wrong!";
      return false;
    }

  }

  Future<bool> saveSurveyQuestion() async {
    isLoading.value = true;
    final text = questionController.text.trim();
    final body = {
      "campaignId": 45,
      "surveyId": 1026,
      "surveyQuestions": [
        {
          "questionId": 74,
          "questionText":text,
          "answerTypeId": 14,
          "dateValidationId": 0,
          "minimumCharacter": null,
          "maximumCharacter": null,
          "choice1": "",
          "choice2": "",
          "isActive": true,
          "isDefault": true,
          "sequenceNo": 1,
          "isMandatory": true,
          "createdBy": "admin",
          "updatedBy": "admin",
          "saveInQuestionBank": false,
          "isQuestionUpdated": true,
          "scalingLabelModel": null,
          "scalingRowModel": null,
          "questionAnswerChoiceModel": [],
          "rateScaleModel": []
        }
      ],
      "thirdPartyReviews": []
    };

    final res = await surveyRepo.updateSurveyQuestion(body);

    if (res != null && res.result) {
      Get.snackbar("Success", res.message);
      return true;
    } else {
      Get.snackbar("Error", res?.message ?? "Something went wrong!");
      return false;
    }

  }

  Future<void> fetchQuestions(int categoryId) async {
    isLoading.value = true;

    final res = await surveyRepo.getQuestions(categoryId);
    if (res == null) {
      print(" fetchAnswers → response is null");
    } else {
      print(" fetchAnswers → message: ${res.message}");
      print(" fetchAnswers → resultCount: ${res.resultCount}");
      print(" fetchAnswers → parsed list length: ${res.result.length}");

      for (final q in res.result) {
        print("   • id=${q.questionId}, text=${q.questionText}, answerTypeId=${q.answerTypeId}, answerType=${q.answerType}");
      }
    }
    if (res != null && res.hasQuestions) {
      questions.value = res.result;
      res.debugPrint();
      Get.snackbar("Success", res.message);
    } else if (res != null && res.resultCount != null) {
      questions.clear();
      res.debugPrint();
      Get.snackbar("Info", res.message.isNotEmpty ? res.message : "No questions available");
    } else {
      Get.snackbar("Error", "Something went wrong");
    }
    isLoading.value = false;
  }

  void fetchAnswerTypes() async {
    try {
      isLoading(true);
      final result = await surveyRepo.getAnswerTypes();
      print("API Response → $result");

      answerTypes.assignAll(result);
      optionsList.assignAll(result.map((e) => e.name).toList());

    } catch (e) {
      print("Error fetching answer types → $e");
    } finally {
      isLoading(false);
    }
  }
}

// if (text.isEmpty || text.length < 10) {
//   Get.snackbar("Error", "Question text must be at least 10 characters long",
//       snackPosition: SnackPosition.BOTTOM);
//   isLoading.value = false;
//   return false;
// }