import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:survey_app/utils/app_color.dart';

import '../../../nav/app_pages.dart';
import '../../../utils/app_image.dart';

class HomePageController extends GetxController {

  var selectedRoute = Routes.home.obs;

  int selectedIndex = 0;

  void setSelectedRoute(String route) {
    selectedRoute.value = route;
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


}