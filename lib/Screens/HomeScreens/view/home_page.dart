


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:survey_app/Screens/HomeScreens/controllers/home_controller.dart';
import 'package:survey_app/utils/app_color.dart';
import 'package:survey_app/utils/app_text_style.dart';

import '../../../common/common_appbar.dart';
import '../../../common/common_divider.dart';
import '../../../common/common_drawer.dart';
import '../../../common/common_flex.dart';
import '../../../nav/app_pages.dart';
import '../../../utils/app_image.dart';

class HomePageView extends GetView<HomePageController> {

  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
  return Scaffold(
    backgroundColor: AppColor.offWhite,
    key: _scaffoldKey,
    drawerEnableOpenDragGesture: true,
    drawer: CommonDrawer(
      header: SizedBox(
        height: 50,
        child: Image.asset(AppImage.appLogo, fit: BoxFit.contain),
      ),
      items: [
        DrawerItem(label: 'DashBoard', leading: Image.asset(AppImage.vector),route: Routes.home),
        DrawerItem(label: 'Question Bank', leading: Image.asset(AppImage.group),route: Routes.questionBank),
        DrawerItem(label: 'Campaign', leading: Image.asset(AppImage.check)),
        DrawerItem(label: 'Users', leading: Image.asset(AppImage.profileCircle)),
      ],
      onLogout: () {},
    ),
   appBar: const CommonAppbar(),
    body:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        divider(),
        h(20),
        Text('Survey’s Summary',
            style: AppTextStyle.medium16(AppColor.blackColor)),
        h(20),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w),
          child: GridView.builder(
            shrinkWrap: true,
            //itemCount: controller.items.length,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing:15,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context,i){
              final bgColor = controller.tileColors[i % controller.tileColors.length];
              final imgPath = controller.tileImages.isNotEmpty
                  ? controller.tileImages[i % controller.tileImages.length]
                  : AppImage.frame1; // fallback
              return InkWell(
                onTap: () {},
                child: Ink(
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(color: AppColor.borderColor),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(imgPath),
                      h(8),
                      Text("Total Survey",
                          style: AppTextStyle.medium12(AppColor.greyColor)),
                      h(10),
                      Text('50', style: AppTextStyle.bold14(AppColor.blackColor))

                    ],
                  ),
                ),
              );
            },
          ),
        ),

      ],
    ) ,
  );
  }
}