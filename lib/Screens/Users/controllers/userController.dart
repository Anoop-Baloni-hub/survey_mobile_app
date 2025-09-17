import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/api_url.dart';
import '../../../common/common_widget.dart';
import '../../../utils/app_color.dart';
import '../models/invite_user_model.dart';

class UserController extends GetxController{


  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;
  final roleList = <String, bool>{
    'Admin': false,
    'Agent': false,
  }.obs;

  final categoryList = <String, bool>{
    'Mortgage': false,
    'Real State': false,
  }.obs;

  final locationList = ['Jacksonville', 'Miami', 'Tampa'];
  var selectedLocation = RxnString();
  var invitedUserList = <UserResponseModel>[].obs;
  var filteredInvitedUserList = <UserResponseModel>[].obs;
  var invitedUsers = <UserResponseModel>[].obs;
  var onboardUsers = <UserResponseModel>[].obs;

  void deleteCampaign() {
    print("Campaign deleted");
    Get.snackbar("Deleted", "Campaign has been deleted successfully",
        backgroundColor: AppColor.orangeAB, colorText: AppColor.whiteColor);
  }

  TextEditingController textController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController defaultController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchInvitedUsers();
    fetchOnboardUsers();
  }

  Future<void> fetchInvitedUsers({int page = 1, int limit = 100}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await ApiUrl.dioClient.get(
        url: ApiUrl.inviteUser,
        queryParameters: {
          'pageNumber': page.toString(),
          'pageSize': limit.toString(),
          'SortByColumn': 'modifiedOn',
          'SortBy': 'true',
        },
        isAuthRequired: true,
      );

      if (response != null) {
        final model = InvitedUserListModel.fromJson(response);
        invitedUsers.value = model.result?.userResponseModel ?? [];
      } else {
        errorMessage.value = "Response is null";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOnboardUsers({int page = 1, int limit = 100}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await ApiUrl.dioClient.get(
        url: ApiUrl.onBoardUser,
        queryParameters: {
          'pageNumber': page.toString(),
          'pageSize': limit.toString(),
          'SortByColumn': 'modifiedOn',
          'SortBy': 'true',
        },
        isAuthRequired: true,
      );

      if (response != null) {
        final model = OnboardUserModel.fromJson(response);
        onboardUsers.value = model.result?.userResponseModel ?? [];
      } else {
        errorMessage.value = "Response is null";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<CreateUserResponse?> createUser() async {
    try {
      isLoading.value = true;
      String roleName = roleList.entries.firstWhere((e) => e.value,
          orElse: () => const MapEntry('Agent', true)).key;
      int roleId = roleName == 'Admin' ? 1 : 2;

      final categoryModel = <Map<String, dynamic>>[];
      categoryList.forEach((key, value) {
        if (value) {
          if (key == 'Mortgage') {
            categoryModel.add({"categoryId": 1});
          } else if (key == 'Real State') {
            categoryModel.add({"categoryId": 2});
          }
        }
      });

      int locationId = 0;
      if (selectedLocation.value == 'Jacksonville') {
        locationId = 1;
      } else if (selectedLocation.value == 'Miami') {
        locationId = 2;
      } else if (selectedLocation.value == 'Tampa') {
        locationId = 5;
      }

      final body = {
        "userId": 0,
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "contactNo": phoneController.text.trim(),
        "roleId": roleId,
        "roleName": roleName,
        "locationId": locationId,
        "defaultSurveyId": null,
        "createdBy": "admin",
        "updatedBy": "admin",
        "isActive": true,
        "categoryModel": categoryModel,
      };
      print("➡️ API POST: ${ApiUrl.newUser}");
      final response = await ApiUrl.dioClient.post(
        url: ApiUrl.newUser,
        requestBody: body,
        isAuthRequired: true,
      );

      if (response != null) {
        final result = CreateUserResponse.fromJson(response);

        Get.snackbar("Success", result.message,
            backgroundColor: AppColor.greenColor, colorText: AppColor.whiteColor);

        await fetchInvitedUsers();
        return result;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: AppColor.redGredientColor, colorText: AppColor.whiteColor);
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  void resetForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    categoryController.clear();
    roleList.updateAll((key, value) => false);
    categoryList.updateAll((key, value) => false);
    selectedLocation.value = null;
  }




}