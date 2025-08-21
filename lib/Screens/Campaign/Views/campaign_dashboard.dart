

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:survey_app/Screens/Campaign/controllers/campaign_controller.dart';
import 'package:survey_app/common/common_app_shell.dart';
import 'package:survey_app/common/custom_tab_bar.dart';

import '../../../common/common_divider.dart';
import '../../../common/common_flex.dart';
import '../../../common/common_textfield.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';
import '../../../utils/app_text_style.dart';

class CampaignDashboard extends GetView<CampaignController> {
  const CampaignDashboard({super.key});

  @override
  Widget build(BuildContext context) {
  return AppShell(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            divider(),
        h(20),
        Text(
          'Campaign Details',
          style: AppTextStyle.medium16(AppColor.blackColor),
        ),
         h(20),
          Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, i) {
                    final bgColor = controller.tileColors[i % controller.tileColors.length];
                    final imgPath = controller.tileImages.isNotEmpty
                        ? controller.tileImages[i % controller.tileImages.length]
                        : AppImage.frame1;

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
                          children: [
                            Image.asset(imgPath),
                            h(8),
                            Text("Total Survey", style: AppTextStyle.medium12(AppColor.greyColor)),
                            h(10),
                            Text('50', style: AppTextStyle.bold14(AppColor.blackColor)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
           h(10),
           Text('Surveys',
             style: AppTextStyle.semiBold14(AppColor.blackColor)),
              h(10),
              Padding(
                padding:  EdgeInsets.only(left: 15.w,right: 10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextInput(
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.greyPurpleColor,
                          size: 20.sp,
                        ),
                        textEditController: controller.textController,
                        hintTextString: "Search Campaign",
                        borderColor: AppColor.borderColor,
                        inputType: InputType.defaults,
                      ),
                    ),
                    SizedBox(width: 20.w), // spacing
                    Container(
                      height: 32.h,
                      width: 75.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.lightGreyColor),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 3.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Short By",
                              style: AppTextStyle.medium12(AppColor.greyColor),
                            ),
                            w(3),// small gap
                            const Icon(
                              Icons.swap_vert,
                              color: AppColor.greyColor,
                              size: 16, // adjust as per your design
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              h(15),
              CustomTabBar(
                  tabs: const ["ALL", "ACTIVE", "INACTIVE", "DRAFTS"],
                  controller: controller.tabController,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    allTabContent(),
                    allTabContent(),
                    allTabContent(),
                    allTabContent(),

                  ],
                ),
              ),
        ]
        ),
      )
  );
  }
}