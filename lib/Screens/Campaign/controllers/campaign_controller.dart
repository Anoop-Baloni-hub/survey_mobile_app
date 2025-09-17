import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/api_services.dart';
import '../../../api/api_url.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';
import '../models/campaign_model.dart';

class CampaignController extends GetxController with GetSingleTickerProviderStateMixin{

  var selectedIndex = 0.obs;
  var campaigns = <Campaign>[].obs;
  var filteredCampaigns = <Campaign>[].obs;
  var isLoading = false.obs;
  var selectedCampaignId = RxnInt();

  TextEditingController searchController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();


  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  final categoryList = <String, bool>{
    'Mortgage': false,
    'Real State': false,
  }.obs;

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

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

  List<Map<String, dynamic>> getSelectedCategories() {
    final selected = <Map<String, dynamic>>[];
    categoryList.forEach((key, value) {
      if (value) {
        if (key == 'Mortgage') {
          selected.add({"categoryId": 1});
        } else if (key == 'Real State') {
          selected.add({"categoryId": 3});
        }
      }
    });
    return selected;
  }


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
    searchController.addListener(() {
      filterCampaigns(searchController.text);
    });
    fetchCampaigns();
  }

  void filterCampaigns(String query) {
    if (query.isEmpty) {
      filteredCampaigns.assignAll(campaigns);
    } else {
      filteredCampaigns.assignAll(
        campaigns.where((c) =>
            c.campaignName.toLowerCase().contains(query.toLowerCase())
        ),
      );
    }
  }

  Future<void> fetchCampaigns() async {
    isLoading(true);
    try {
      print("➡️ Fetching from: ${ApiUrl.campaign}");
      final response = await apiClient.get(
        url: ApiUrl.campaign,
        isAuthRequired: true,
      );

      if (response != null && response["result"] != null) {
        campaigns.value = List<Campaign>.from(
          response["result"].map((x) => Campaign.fromJson(x)),
        );
        filteredCampaigns.assignAll(campaigns);
      } else {
        Get.snackbar("Error", "No data found");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<CreateCampaignResponse?> saveCampaign({int? campaignId}) async {
    if (!validateDates()) return null;

    final body = {
      "campaignId": selectedCampaignId.value ?? 0,
      "campaignName": textController.text.trim(),
      "startDate": formatDate(selectedStartDate!),
      "endDate": formatDate(selectedEndDate!),
      "categoryModel": getSelectedCategories(),
      "isActive": true,
      "createdBy": "admin",
      "updatedBy": "admin",
    };

    final bool isUpdate = campaignId != null && campaignId > 0;

    final response = isUpdate
        ? await apiClient.put(
      url: ApiUrl.campaign,
      requestBody: body,
      isAuthRequired: true,
    )
        : await apiClient.post(
      url: ApiUrl.campaign,
      requestBody: body,
      isAuthRequired: true,
    );

    if (response != null) {
      final result = CreateCampaignResponse.fromJson(response);
      await fetchCampaigns();

      Get.snackbar("Success", result.message,
          backgroundColor: Colors.green, colorText: Colors.white);

      return result;
    }
    return null;
  }

  Future<CreateCampaignResponse?> deleteCampaign(int campaignId) async {
    try {
      final response = await apiClient.delete(
        url: "${ApiUrl.campaign}/$campaignId",
        isAuthRequired: true,
      );

      if (response != null) {
        final result = CreateCampaignResponse.fromJson(response);

        await fetchCampaigns();

        Get.snackbar("Success", result.message,
            backgroundColor: AppColor.greenColor, colorText: Colors.white);

        return result;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
    return null;
  }

  void resetForm() {
    textController.clear();
    startDateController.clear();
    endDateController.clear();
    categoryController.clear();
    selectedStartDate = null;
    selectedEndDate = null;
    categoryList.updateAll((key, value) => false);
  }

  void prepareForAdd() {
    resetForm();
    selectedCampaignId.value = null;
  }

  void prepareForEdit(Campaign campaign) {
    selectedCampaignId.value = campaign.campaignId;
    textController.text = campaign.campaignName;
    selectedStartDate = campaign.startDate;
    selectedEndDate = campaign.endDate;
    startDateController.text = formatDate(campaign.startDate);
    endDateController.text = formatDate(campaign.endDate);

    categoryList.updateAll((key, value) => false);
    for (var cat in campaign.categoryModel) {
      if (cat.categoryId == 1) {
        categoryList['Mortgage'] = true;
      } else if (cat.categoryId == 2) {
        categoryList['Real State'] = true;
      }
    }}

}