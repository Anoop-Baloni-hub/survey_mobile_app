import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';

class CampaignController extends GetxController with GetSingleTickerProviderStateMixin{

  var selectedIndex = 0.obs;
 // var isMandatory = false.obs;
  //var isSelected = false.obs;
  TextEditingController textController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  // TextEditingController surveyTextController = TextEditingController();
  // TextEditingController surveyStartDateController = TextEditingController();
  // TextEditingController surveyEndDateController = TextEditingController();


  // void toggleSelection() {
  //   isSelected.value = !isSelected.value;
  // }



  final categoryList = <String, bool>{
    'Mortgage': false,
    'Real State': false,
  }.obs;

  final tileColors = <Color>[
    AppColor.gredientColor,
    AppColor.redGredientColor,
    AppColor.greenGrediantColor,
    AppColor.lightYellowColor,
  ];

  final tileImages = <String>[
    AppImage.frame1,
    AppImage.frame2,
    AppImage.frame3,
    AppImage.frame4,
  ];


  //var inviteReviewer = false.obs;
 // RxInt currentStep = 1.obs;
 //  final int totalSteps = 4;
 //  void nextStep() {
 //    if (currentStep.value < totalSteps) {
 //      currentStep.value++;
 //    }
 //  }
 //
 //  void previousStep() {
 //    if (currentStep.value > 1) {
 //      currentStep.value--;
 //    }
 //  }

  late TabController tabController;
  var selectedSort = "Sort By".obs;
  final List<String> sortOptions = ["Last Modified", "Most Responses", "Ending soon"];

  void changeSort(String value) {
    selectedSort.value = value;
  }

  var filteredCampaigns = <String>[].obs;
  final List<String> allCampaigns = [
    "Rize ",
    "Winter Discount",
    "Diwali Offer",
    "Black Friday",
    "Christmas Deals",
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);

    //search campaign logic======
    filteredCampaigns.assignAll(allCampaigns);
    textController.addListener(() {
      filterCampaigns(textController.text);
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }


  void filterCampaigns(String query) {
    if (query.isEmpty) {
      filteredCampaigns.assignAll(allCampaigns);
    } else {
      filteredCampaigns.assignAll(
        allCampaigns.where(
              (c) => c.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

}