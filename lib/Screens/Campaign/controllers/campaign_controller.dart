import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';

class CampaignController extends GetxController with GetSingleTickerProviderStateMixin{

  var selectedIndex = 0.obs;
  TextEditingController textController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
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

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

}