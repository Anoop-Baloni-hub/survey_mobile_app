

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../common/common_widget.dart';

class NewSurveyController extends GetxController {

  TextEditingController textController = TextEditingController();
  TextEditingController surveyTextController = TextEditingController();
  TextEditingController surveyStartDateController = TextEditingController();
  TextEditingController surveyEndDateController = TextEditingController();

  var selectedIndex = (-1).obs;
  var selectedTabIndex = 0.obs;
  var isMandatory = false.obs;
  var isSelected = false.obs;
  var inviteReviewer = false.obs;
  var selectedButtonIndex = 0.obs;


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
      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
  void nextStep() {
    if (currentStep.value < totalSteps) {
      currentStep.value++;
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
  void loadUsers() {
    users.value = [
      UserModel(
        name: "Anoop Baloni",
        email: "anoopbaloni11@gmail.com",
        details: const [
          {"label": "First Name", "value": "Anoop"},
          {"label": "Last Name", "value": "Baloni"},
          {"label": "Email", "value": "anoopbaloni11@gmail.com"},
        ],
      ),
      UserModel(
        name: "Anoop Baloni",
        email: "anoopbaloni11@gmail.com",
        details: const [
          {"label": "First Name", "value": "Anoop"},
          {"label": "Last Name", "value": "Baloni"},
          {"label": "Email", "value": "anoopbaloni11@gmail.com"},
        ],
      ),
    ];
  }

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
    loadUsers();
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
}