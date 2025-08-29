import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../common/common_widget.dart';
import '../../../utils/app_color.dart';

class Usercontroller extends GetxController{


  var selectedIndex = 0.obs;
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
    loadUsers();
  }
  var invitedUsers = <UserModel>[].obs;
  var onboardUsers = <UserModel>[].obs;
  void loadUsers() {
    invitedUsers.value = [
      UserModel(
        name: "Shubham Naithani",
        email: "shubhamnaithani27@gmail.com",
        details: const [
          {"label": "Role", "value": "Agent"},
          {"label": "Location", "value": "Miami"},
          {"label": "Category", "value": "Mortgage, Real Estate"},
        ],
      ),
      UserModel(
        name: "Shubham Naithani",
        email: "shubhamnaithani27@gmail.com",
        details: const [
          {"label": "Role", "value": "Agent"},
          {"label": "Location", "value": "Miami"},
          {"label": "Category", "value": "Mortgage, Real Estate"},
        ],
      ),
    ];
    onboardUsers.value = [
      UserModel(
        name: "Anoop Baloni",
        email: "anoopbaloni11@gmail.com",
        details: const [
          {"label": "Role", "value": "Agent"},
          {"label": "Location", "value": "Miami"},
          {"label": "Category", "value": "Mortgage, Real Estate"},
        ],
      ),
      UserModel(
        name: "Anoop Baloni",
        email: "anoopbaloni11@gmail.com",
          details: const [
          {"label": "Role", "value": "Agent"},
          {"label": "Location", "value": "Miami"},
          {"label": "Category", "value": "Mortgage, Real Estate"},
          ],
      ),
    ];
  }

}