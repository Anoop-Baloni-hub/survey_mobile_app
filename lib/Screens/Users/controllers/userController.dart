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
        backgroundColor: AppColor.greenColor, colorText: AppColor.whiteColor);
  }


  TextEditingController textController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchInvitedUsers();
    fetchOnboardUsers();
  }

  // void loadUsers() {
  //   invitedUsers.value = [
  //     UserModel(
  //       name: "Shubham Naithani",
  //       email: "shubhamnaithani27@gmail.com",
  //       details: const [
  //         {"label": "Role", "value": "Agent"},
  //         {"label": "Location", "value": "Miami"},
  //         {"label": "Category", "value": "Mortgage, Real Estate"},
  //       ],
  //     ),
  //     UserModel(
  //       name: "Shubham Naithani",
  //       email: "shubhamnaithani27@gmail.com",
  //       details: const [
  //         {"label": "Role", "value": "Agent"},
  //         {"label": "Location", "value": "Miami"},
  //         {"label": "Category", "value": "Mortgage, Real Estate"},
  //       ],
  //     ),
  //   ];
  //   onboardUsers.value = [
  //     UserModel(
  //       name: "Anoop Baloni",
  //       email: "anoopbaloni11@gmail.com",
  //       details: const [
  //         {"label": "Role", "value": "Agent"},
  //         {"label": "Location", "value": "Miami"},
  //         {"label": "Category", "value": "Mortgage, Real Estate"},
  //       ],
  //     ),
  //     UserModel(
  //       name: "Anoop Baloni",
  //       email: "anoopbaloni11@gmail.com",
  //         details: const [
  //         {"label": "Role", "value": "Agent"},
  //         {"label": "Location", "value": "Miami"},
  //         {"label": "Category", "value": "Mortgage, Real Estate"},
  //         ],
  //     ),
  //   ];
  // }


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




}