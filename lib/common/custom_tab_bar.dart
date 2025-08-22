
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../nav/app_pages.dart';
import '../utils/app_color.dart';
import '../utils/app_text_style.dart';
import 'common_flex.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;
  final TabController controller;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: false, // equal spacing
      indicatorColor: Colors.blue,
      indicatorWeight: 2,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      tabs: tabs.map((t) => Tab(text: t)).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

Widget allTabContent() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        h(20),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.surveyScreen);
          },
          child: Container(
            height: 180.h,
            width: 180.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.borderColor, // your theme border color
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor:AppColor.blueColor,
                  child: const Icon(Icons.add, color: AppColor.whiteColor),
                ),
                h(10),
                Text(
                  "Create New", style: AppTextStyle.medium14(AppColor.blackColor),
                ),
                Text(
                  "Survey",
                  style: AppTextStyle.semiBold16(AppColor.blackColor),
                ),
              ],
            ),
          ),
        ),
        h(20),
        // Info message
        Text(
          "You haven’t created any Survey yet…",
          style: AppTextStyle.medium12(AppColor.greyColor),
          textAlign: TextAlign.center,
        ),
        h(5),
        Text(
          "Click on the ‘Create New Survey’ button to get started",
          style: AppTextStyle.medium12(AppColor.greyColor),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}



