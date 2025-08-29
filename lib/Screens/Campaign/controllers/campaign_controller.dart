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
      startDateController.text =
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
      endDateController.text =
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

  void deleteCampaign() {

    print("Campaign deleted");
    Get.snackbar("Deleted", "Campaign has been deleted successfully",
        backgroundColor: AppColor.greenColor, colorText: AppColor.whiteColor);
  }

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