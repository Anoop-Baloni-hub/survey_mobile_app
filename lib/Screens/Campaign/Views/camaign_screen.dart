
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:survey_app/Screens/Campaign/controllers/campaign_controller.dart';
import 'package:survey_app/common/common_app_shell.dart';
import 'package:survey_app/utils/app_image.dart';

import '../../../common/common_divider.dart';
import '../../../common/common_drop_down.dart';
import '../../../common/common_flex.dart';
import '../../../common/common_textfield.dart';
import '../../../common/common_widget.dart';
import '../../../nav/app_pages.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text_style.dart';

class CampaignScreen extends GetView<CampaignController>{
  const CampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final formKey = GlobalKey<FormState>();
    return AppShell(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              divider(),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          controller.selectedIndex.value = 0;
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(100.w, 30.h),
                          backgroundColor: controller.selectedIndex.value == 0
                              ? AppColor.rizePurpleColor
                              : AppColor.transparentColor,
                          side: const BorderSide(color: AppColor.blackColor, width: 1),
                        ),
                        child: Text(
                          'All',
                          style: AppTextStyle.semiBold14(
                            controller.selectedIndex.value == 0
                                ? AppColor.whiteColor
                                : AppColor.blackColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      w(5),
                      OutlinedButton(
                        onPressed: () {
                          controller.selectedIndex.value = 1;
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(100.w, 30.h),
                          backgroundColor: controller.selectedIndex.value == 1
                              ? AppColor.rizePurpleColor
                              : AppColor.transparentColor,
                          side: BorderSide(color: AppColor.blackColor.withOpacity(0.4), width: 1),
                        ),
                        child: Text(
                          'Draft',
                          style: AppTextStyle.semiBold14(
                            controller.selectedIndex.value == 1
                                ? AppColor.whiteColor
                                : AppColor.blackColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                h(20),
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
                      Obx(() {
                        return GestureDetector(
                          onTap: () async {
                            final RenderBox box = context.findRenderObject() as RenderBox;
                            final Offset position = box.localToGlobal(Offset.zero);

                            final result = await showMenu(
                              color: AppColor.offWhite,
                              context: context,
                              position: RelativeRect.fromLTRB(
                                position.dx + box.size.width,
                                position.dy,
                                0, 0,
                              ),
                              items: controller.sortOptions.map((option) {
                                return PopupMenuItem(
                                  value: option,
                                  child: Container(
                                   // color:  AppColor.greyColor,
                                    padding:  EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                                    child: Text(option, style:AppTextStyle.semiBold12(AppColor.blackColor)),
                                  ),
                                );
                              }).toList(),
                            );

                            if (result != null) {
                              controller.changeSort(result);
                            }
                          },
                          child: Container(
                            height: 32.h,
                            width: 75.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.lightGreyColor),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    controller.selectedSort.value,
                                    style: AppTextStyle.medium12(AppColor.greyColor),
                                  ),
                                  w(3),
                                  const Icon(
                                    Icons.swap_vert,
                                    color: AppColor.greyColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                h(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding:  EdgeInsets.only(left: 14.w),
                      child:GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                //  TextEditingController choiceController = TextEditingController();
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  title: Text("Add Campaign",style: AppTextStyle.bold14(AppColor.blackColor),),
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width * 1.w,
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomTextInput(
                                            textEditController: controller.textController,
                                            hintTextString: 'Enter Campaign Name',
                                            validator: (value) =>
                                            value == null || value.isEmpty ? "Campaign Name is required" : null,
                                          ),
                                          h(20),
                                          TextField(
                                            controller: controller.startDateController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: "Start Date",
                                              suffixIcon: const Icon(Icons.calendar_today_outlined),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8.r),
                                              ),
                                            ),
                                            onTap: () => controller.pickStartDate(context),
                                          ),
                                          h(20),
                                          TextField(
                                            controller: controller.endDateController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: "End Date",
                                              suffixIcon: const Icon(Icons.calendar_today_outlined),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8.r),
                                              ),
                                            ),
                                            onTap: () => controller.pickEndDate(context),
                                          ),
                                          h(20),
                                          TextField(
                                            controller: controller.categoryController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: "Select Category",
                                              suffixIcon: const Icon(Icons.arrow_drop_down),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8.r),
                                              ),
                                            ),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: const Text("Select Categories"),
                                                  content: Obx(() => SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: controller.categoryList.keys.map((category) {
                                                        return CheckboxListTile(
                                                          title: Text(category),
                                                          value: controller.categoryList[category],
                                                          onChanged: (val) {
                                                            controller.categoryList[category] = val ?? false;
                                                          },
                                                        );
                                                      }).toList(),
                                                    ),
                                                  )),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context),
                                                      child: const Text("Cancel"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        final selected = controller.categoryList.entries
                                                            .where((e) => e.value)
                                                            .map((e) => e.key)
                                                            .toList();

                                                        controller.categoryController.text = selected.join(", ");
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("OK"),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          h(10),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // Close popup
                                      },
                                      child: const Text("Cancel"),
                                    ),

                                    ElevatedButton(
                                      onPressed: () {
                                        if (!controller.validateDates()) return;
                                        String newChoice = controller.textController.text.trim();
                                        if (newChoice.isNotEmpty) {
                                          print("New Choice Group: $newChoice");
                                        }
                                        Navigator.pop(context); // Close popup
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.primaryColor
                                      ),
                                      child:  Text("Create",
                                        style: AppTextStyle.semiBold12(AppColor.whiteColor),
                                      ),
                                    ),
                                  ],
                                );});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20.w),
                          height: MediaQuery.of(context).size.height * 0.04.h,
                          width: MediaQuery.of(context).size.width * 0.4.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColor.primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              '+ Add Campaign',
                              style: AppTextStyle.semiBold15(AppColor.whiteColor),
                            ),
                          ),
                        ),
                      )
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                      child: Column(
                        children: [
                          Container(
                            // height: MediaQuery.sizeOf(context).height,
                             width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              topRight: Radius.circular(8.r), ),
                              color: AppColor.blueColor,
                            ),
                            child:  Padding(
                              padding:  EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Rize Mortgage Borrower',
                                      style: AppTextStyle.semiBold14(AppColor.whiteColor)),
                                  h(10),
                                  Text('Experience Survey 1',
                                      style: AppTextStyle.semiBold14(AppColor.whiteColor)),

                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r),
                              ),
                              color: AppColor.greyColor.withOpacity(0.1),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                              child: Column(
                                children: [
                                  h(10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                    children: [
                                      Image.asset(AppImage.jam),
                                      w(10),
                                      Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                        Text('11',style: AppTextStyle.semiBold12(AppColor.blackColor)),
                                        h(5),
                                        Text('Total Surveys',style: AppTextStyle.semiBold12(AppColor.blackColor))
                                        ],
                                      ),
                                    ],
                                      ),
                                      Row(
                                    children: [
                                      Image.asset(AppImage.arrow1),
                                      w(10),
                                      Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                        Text('11',style: AppTextStyle.semiBold12(AppColor.blackColor)),
                                          h(5),
                                          Text('Active Surveys',style: AppTextStyle.semiBold12(AppColor.blackColor))
                                        ],
                                      ),


                                    ],
                                      ),
                                    ],
                                  ),
                                  h(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                    children: [
                                      Image.asset(AppImage.charmCircle),
                                      w(10),
                                      Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                        Text('11',style: AppTextStyle.semiBold12(AppColor.blackColor)),
                                        h(5),
                                        Text('Total Surveys',style: AppTextStyle.semiBold12(AppColor.blackColor))
                                        ],
                                      ),
                                    ],
                                      ),

                                      Row(
                                    children: [
                                      Image.asset(AppImage.mingcute),
                                      w(10),
                                      Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                        Text('11',style: AppTextStyle.semiBold12(AppColor.blackColor)),
                                          h(5),
                                        Text('Active Surveys',style: AppTextStyle.semiBold12(AppColor.blackColor))
                                        ],
                                      ),


                                    ],
                                      ),

                                    ],
                                  ),
                                  h(20),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     GestureDetector(
                                       onTap:(){
                                         showDialog(
                                             context: context,
                                             builder: (context) {
                                               return AlertDialog(
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(10.r),
                                                 ),
                                                 title: Text("Edit Campaign",style: AppTextStyle.bold14(AppColor.blackColor),),
                                                 content: SizedBox(
                                                   width: MediaQuery.of(context).size.width * 1.w,
                                                   child: Form(
                                                     key: formKey,
                                                     child: Column(
                                                       mainAxisSize: MainAxisSize.min,
                                                       children: [
                                                         CustomTextInput(
                                                           textEditController: controller.textController,
                                                           hintTextString: 'Enter Campaign Name',
                                                           validator: (value) =>
                                                           value == null || value.isEmpty ? "Campaign Name is required" : null,
                                                         ),
                                                         h(20),
                                                         TextField(
                                                           controller: controller.startDateController,
                                                           readOnly: true,
                                                           decoration: InputDecoration(
                                                             labelText: "Start Date",
                                                             suffixIcon: const Icon(Icons.calendar_today_outlined),
                                                             border: OutlineInputBorder(
                                                               borderRadius: BorderRadius.circular(8.r),
                                                             ),
                                                           ),
                                                           onTap: () => controller.pickStartDate(context),
                                                         ),
                                                         h(20),
                                                         TextField(
                                                           controller: controller.endDateController,
                                                           readOnly: true,
                                                           decoration: InputDecoration(
                                                             labelText: "End Date",
                                                             suffixIcon: const Icon(Icons.calendar_today_outlined),
                                                             border: OutlineInputBorder(
                                                               borderRadius: BorderRadius.circular(8.r),
                                                             ),
                                                           ),
                                                           onTap: () => controller.pickEndDate(context),
                                                         ),
                                                         h(20),
                                                         TextField(
                                                           controller: controller.categoryController,
                                                           readOnly: true,
                                                           decoration: InputDecoration(
                                                             labelText: "Select Category",
                                                             suffixIcon: const Icon(Icons.arrow_drop_down),
                                                             border: OutlineInputBorder(
                                                               borderRadius: BorderRadius.circular(8.r),
                                                             ),
                                                           ),
                                                           onTap: () {
                                                             showDialog(
                                                               context: context,
                                                               builder: (_) => AlertDialog(
                                                                 title: const Text("Select Categories"),
                                                                 content: Obx(() => SingleChildScrollView(
                                                                   child: Column(
                                                                     mainAxisSize: MainAxisSize.min,
                                                                     children: controller.categoryList.keys.map((category) {
                                                                       return CheckboxListTile(
                                                                         title: Text(category),
                                                                         value: controller.categoryList[category],
                                                                         onChanged: (val) {
                                                                           controller.categoryList[category] = val ?? false;
                                                                         },
                                                                       );
                                                                     }).toList(),
                                                                   ),
                                                                 )),
                                                                 actions: [
                                                                   TextButton(
                                                                     onPressed: () => Navigator.pop(context),
                                                                     child: const Text("Cancel"),
                                                                   ),
                                                                   ElevatedButton(
                                                                     onPressed: () {
                                                                       final selected = controller.categoryList.entries
                                                                           .where((e) => e.value)
                                                                           .map((e) => e.key)
                                                                           .toList();

                                                                       controller.categoryController.text = selected.join(", ");
                                                                       Navigator.pop(context);
                                                                     },
                                                                     child: const Text("OK"),
                                                                   )
                                                                 ],
                                                               ),
                                                             );
                                                           },
                                                         ),
                                                         h(10),
                                                       ],
                                                     ),
                                                   ),
                                                 ),
                                                 actions: [
                                                   TextButton(
                                                     onPressed: () {
                                                       Navigator.pop(context); // Close popup
                                                     },
                                                     child: const Text("Cancel"),
                                                   ),

                                                   ElevatedButton(
                                                     onPressed: () {
                                                       if (!controller.validateDates()) return;
                                                       String newChoice = controller.textController.text.trim();
                                                       if (newChoice.isNotEmpty) {
                                                         print("New Choice Group: $newChoice");
                                                       }
                                                       Navigator.pop(context); // Close popup
                                                     },
                                                     style: ElevatedButton.styleFrom(
                                                         backgroundColor: AppColor.primaryColor
                                                     ),
                                                     child:  Text("Create",
                                                       style: AppTextStyle.semiBold12(AppColor.whiteColor),
                                                     ),
                                                   ),
                                                 ],
                                               );});
                                       },
                                         child: const Icon(Icons.edit,size: 20)),
                                     w(20),
                                     GestureDetector(
                                         onTap:(){},
                                         child: const Icon(Icons.copy,size: 20)),
                                     w(20),
                                     GestureDetector(
                                         onTap:(){
                                           showDialog(context: context,
                                               builder: (context){
                                             return AlertDialog(
                                               shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(10.r),
                                               ),
                                               title: Text("Delete Campaign",style: AppTextStyle.bold14(AppColor.blackColor),),
                                               content: Text('''Are you sure , you want to delete this Campaign? This process can't be undone''',
                                                 style: AppTextStyle.medium14(AppColor.blackColor),
                                               ),
                                               actions: [
                                                 TextButton(
                                                   onPressed: () {
                                                     Navigator.pop(context);
                                                   },
                                                   child: const Text("Cancel"),
                                                 ),
                                                 ElevatedButton(
                                                   style: ElevatedButton.styleFrom(
                                                     backgroundColor: AppColor.primaryColor,
                                                   ),
                                                   onPressed: () {
                                                     controller.deleteCampaign();
                                                     Navigator.pop(context);
                                                   },
                                                   child: const Text("Delete"),
                                                 ),
                                               ],
                                             );
                                               }
                                           );
                                         },
                                         child: const Icon(Icons.delete,size: 20)),
                                     Expanded(
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.end,

                                         children: [
                                           GestureDetector(
                                               onTap:(){
                                                 Get.toNamed(Routes.campaignDashBoard);
                                               },
                                               child: Text('View More',style: AppTextStyle.semiBold14(AppColor.saffronColor))),
                                           const Icon(Icons.arrow_forward_ios,size: 18,color: AppColor.saffronColor,)
                                         ],
                                       ),
                                     )
                                   ],
                                 ),
                                  h(10),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
          ]
          ),
        )
    );

  }

}
