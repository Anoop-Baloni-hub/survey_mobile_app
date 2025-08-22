

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../common/common_app_shell.dart';
import '../../../common/common_divider.dart';
import '../../../common/common_drop_down.dart';
import '../../../common/common_flex.dart';
import '../../../common/common_textfield.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text_style.dart';
import '../controllers/campaign_controller.dart';

class CreateNewSurveyScreen extends GetView<CampaignController>{
  const CreateNewSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
   //            final formKey = GlobalKey<FormState>();
    return AppShell(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                divider(),
                h(20),
               Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 15.w),
                 child: Column(
                   children: [
                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 15.w),
                       child: Row(
                         children: [
                           GestureDetector(
                             onTap:(){
                               Navigator.pop(context);
                             },
                               child: Icon(Icons.arrow_back_ios,size: 20.sp,color: AppColor.greyColor,)),
                           w (20),
                           Text('Create New Survey',style: AppTextStyle.semiBold14(AppColor.blackColor)),
                         ],
                       ),
                     ),
                     h(20),
                     Container(
                       height: MediaQuery.of(context).size.height/5,
                       width: MediaQuery.of(context).size.width*0.9,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.r),
                           color: AppColor.lightGreyColor.withOpacity(0.8)
                       ),
                       child: Column(
                         children: [
                           h(20),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: List.generate(4, (index) {
                               bool isActive = index == 0;
                               return Row(
                                 children: [
                                   buildStepCircle("${index + 1}", isActive),
                                   if (index < 3)
                                     buildStepLine(context),
                                 ],
                               );
                             }),
                           ),
                           h(30),
                           Padding(
                             padding:  EdgeInsets.only(right: 10.w),
                             child: Align(
                               alignment: Alignment.bottomRight,
                               child: OutlinedButton(
                                 style: OutlinedButton.styleFrom(
                                   side:  BorderSide(color: AppColor.primaryColor,width: 2.w),
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(8.r),
                                   ),
                                 ),
                                 onPressed: () {},
                                 child: Text(
                                   "Save as draft",
                                   style: AppTextStyle.bold12(AppColor.primaryColor),
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     h(20),
                     Obx(() {
                       return Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           // Previous button
                           OutlinedButton(
                             onPressed: controller.currentStep.value == 1
                                 ? null
                                 : controller.previousStep,
                             style: OutlinedButton.styleFrom(
                               backgroundColor: controller.currentStep.value == 1
                                   ? AppColor.greyColor
                                   : AppColor.blackColor,
                               foregroundColor: controller.currentStep.value == 1
                                   ? AppColor.blackColor
                                   : AppColor.whiteColor,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(8.r),
                               ),
                             ),
                             child: const Text('Previous'),
                           ),
                           w(10),

                           OutlinedButton(
                             onPressed: () {
                               if (controller.currentStep.value < controller.totalSteps) {
                                 controller.nextStep();
                               }
                             },
                             style: OutlinedButton.styleFrom(
                               backgroundColor: AppColor.primaryColor,
                               foregroundColor: AppColor.whiteColor,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(8.r),
                               ),
                             ),
                             child: const Text('Next'),
                           ),
                         ],
                       );
                     }),
                     h(20),
                     Obx(() {
                       switch (controller.currentStep.value) {
                         case 1:
                           return FirstScreenWidget(context);
                         case 2:
                           return SecondScreenWidget(context);
                          case 3:
                            return ThirdScreenWidget(context);
                         default:
                           return const SizedBox();
                       }
                     }),
                     // TextField(
                     //   decoration: InputDecoration(
                     //     label: RichText(
                     //       text: TextSpan(
                     //         children: [
                     //           TextSpan(
                     //             text: 'Survey Name ',
                     //             style: AppTextStyle.semiBold12(AppColor.greyColor),
                     //           ),
                     //           TextSpan(
                     //             text: '*',
                     //             style: AppTextStyle.semiBold12(AppColor.redColor),
                     //           ),
                     //         ],
                     //       ),
                     //     ),
                     //     border: OutlineInputBorder(
                     //       borderRadius: BorderRadius.circular(8.r),
                     //     ),
                     //   ),
                     // ),
                     // h(20),
                     // CustomTextInput(
                     //     textEditController: controller.surveyTextController,
                     //   hintTextString: 'Survey Description',
                     //   maxLines: 8,
                     // ),
                     // h(20),
                     // TextField(
                     //   controller: controller.surveyStartDateController,
                     //  // readOnly: true,
                     //   decoration: InputDecoration(
                     //     label: RichText(
                     //       text: TextSpan(
                     //         children: [
                     //           TextSpan(
                     //             text: 'Start Date ',
                     //             style: AppTextStyle.semiBold12(AppColor.greyColor),
                     //           ),
                     //           TextSpan(
                     //             text: '*',
                     //             style: AppTextStyle.semiBold12(AppColor.redColor),
                     //           ),
                     //         ],
                     //       ),
                     //     ),
                     //     suffixIcon: const Icon(Icons.calendar_today_outlined),
                     //     border: OutlineInputBorder(
                     //       borderRadius: BorderRadius.circular(8.r),
                     //     ),
                     //   ),
                     //   onTap: () async {
                     //     DateTime? pickedDate = await showDatePicker(
                     //       context: context,
                     //       initialDate: DateTime.now(),
                     //       firstDate: DateTime(2000),
                     //       lastDate: DateTime(2100),
                     //     );
                     //
                     //     if (pickedDate != null) {
                     //       String formattedDate =
                     //           "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                     //       controller.surveyStartDateController.text = formattedDate;
                     //     }
                     //   },
                     // ),
                     // h(20),
                     // TextField(
                     //   controller: controller.surveyEndDateController,
                     //   //readOnly: true,
                     //   decoration: InputDecoration(
                     //     label: RichText(
                     //       text: TextSpan(
                     //         children: [
                     //           TextSpan(
                     //             text: 'End Date ',
                     //             style: AppTextStyle.semiBold12(AppColor.greyColor),
                     //           ),
                     //           TextSpan(
                     //             text: '*',
                     //             style: AppTextStyle.semiBold12(AppColor.redColor),
                     //           ),
                     //         ],
                     //       ),
                     //     ),
                     //     suffixIcon: const Icon(Icons.calendar_today_outlined),
                     //     border: OutlineInputBorder(
                     //       borderRadius: BorderRadius.circular(8.r),
                     //     ),
                     //   ),
                     //   onTap: () async {
                     //     DateTime? pickedDate = await showDatePicker(
                     //       context: context,
                     //       initialDate: DateTime.now(),
                     //       firstDate: DateTime(2000),
                     //       lastDate: DateTime(2100),
                     //     );
                     //
                     //     if (pickedDate != null) {
                     //       String formattedDate =
                     //           "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                     //       controller.surveyEndDateController.text = formattedDate;
                     //     }
                     //   },
                     // ),
                     // h(20),
                   ],
                 ),
               ),


              ]
          ),
        )
    );
  }

  Widget buildStepCircle(String text, bool isActive) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: isActive ? AppColor.primaryColor : AppColor.greyColor,
      child: Text(
        text,
        style:  AppTextStyle.semiBold12(AppColor.whiteColor),
      ),
    );
  }

  Widget buildStepLine(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.002,
      color: AppColor.blueColor,
    );
  }

 Widget FirstScreenWidget(BuildContext context){
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            label: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Survey Name ',
                    style: AppTextStyle.semiBold12(AppColor.greyColor),
                  ),
                  TextSpan(
                    text: '*',
                    style: AppTextStyle.semiBold12(AppColor.redColor),
                  ),
                ],
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        h(20),
        CustomTextInput(
          textEditController: controller.surveyTextController,
          hintTextString: 'Survey Description',
          maxLines: 8,
        ),
        h(20),
        TextField(
          controller: controller.surveyStartDateController,
          // readOnly: true,
          decoration: InputDecoration(
            label: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Start Date ',
                    style: AppTextStyle.semiBold12(AppColor.greyColor),
                  ),
                  TextSpan(
                    text: '*',
                    style: AppTextStyle.semiBold12(AppColor.redColor),
                  ),
                ],
              ),
            ),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              String formattedDate =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              controller.surveyStartDateController.text = formattedDate;
            }
          },
        ),
        h(20),
        TextField(
          controller: controller.surveyEndDateController,
          //readOnly: true,
          decoration: InputDecoration(
            label: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'End Date ',
                    style: AppTextStyle.semiBold12(AppColor.greyColor),
                  ),
                  TextSpan(
                    text: '*',
                    style: AppTextStyle.semiBold12(AppColor.redColor),
                  ),
                ],
              ),
            ),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              String formattedDate =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              controller.surveyEndDateController.text = formattedDate;
            }
          },
        ),
        h(20),
      ],
    );
 }

 Widget SecondScreenWidget(BuildContext context){
    return Column(
      children: [
        Container(
         // height: MediaQuery.of(context).size.height/5,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColor.lightGreyColor.withOpacity(0.8)
          ),
          child: Column(
            children: [
              h(20),
              Text('Add questions to the survey',
              style: AppTextStyle.semiBold14(AppColor.blueColor)),
              h(10),
              Padding(
                padding:  EdgeInsets.only(left: 10.w),
                child: Text('You can add questions from questionnaire or create new questions ',
                style: AppTextStyle.semiBold12(AppColor.greyColor)),
              ),
              h(15),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: AppColor.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text('Add From Questionnaire',
                        style: AppTextStyle.semiBold14(AppColor.whiteColor)),
                  ),
              h(15),
              OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: AppColor.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text('Create New Question',
                        style: AppTextStyle.semiBold14(AppColor.whiteColor)),
                  ),
              h(15),
            ],
          )
        ),
        h(20),
        Container(
         // height: MediaQuery.of(context).size.height/5,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColor.lightGreyColor.withOpacity(0.8)
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                h(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Question 1',
                  style: AppTextStyle.semiBold14(AppColor.greyColor)),
                ),
                h(10),
                TextField(
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Enter Question Here ',
                            style: AppTextStyle.semiBold12(AppColor.blackColor),
                          ),
                          TextSpan(
                            text: '*',
                            style: AppTextStyle.semiBold12(AppColor.redColor),
                          ),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                h(15),
                TextField(
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Select Answer Type',
                            style: AppTextStyle.semiBold12(AppColor.blackColor),
                          ),
                          TextSpan(
                            text: '*',
                            style: AppTextStyle.semiBold12(AppColor.redColor),
                          ),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                h(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mark as mandatory',
                    style: AppTextStyle.medium14(AppColor.greyColor)),
                  w(10),
                  Obx(() => Switch(
                    value: controller.isMandatory.value,
                    onChanged: (value) {
                      controller.isMandatory.value = value;
                    },
                    activeColor: Colors.white,
                    activeTrackColor: AppColor.blueColor,
                    inactiveThumbColor: AppColor.blackColor,
                    inactiveTrackColor: AppColor.whiteColor,
                  )),
                  spacer(),
                  GestureDetector(
                    onTap: (){},
                      child: const Icon(Icons.copy,size: 20,color: AppColor.blackColor)),
                  w(10),
                  GestureDetector(
                      onTap: (){},
                      child: const Icon(Icons.delete,size: 20,color: AppColor.blackColor)
                  ),
                ],
              ),
                h(15),
              ],
            ),
          )
        ),
        h(20),
        Container(
          // height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.lightGreyColor.withOpacity(0.8)
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  h(20),
                  Row(
                    children: [
                      Obx(() => Checkbox(
                        value: controller.inviteReviewer.value,
                        onChanged: (value) {
                          controller.inviteReviewer.value = value ?? false;
                        },
                        activeColor: AppColor.blueColor,
                        checkColor: Colors.white,
                      )),
                      w(5),
                      Text('Invite reviewer to leave a public review',
                          style: AppTextStyle.semiBold12(AppColor.greyColor)),
                    ],
                  ),
                  h(10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Redirect URL',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  h(15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Third Party Review Platform',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  h(15),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.06,
                      width: MediaQuery.of(context).size.width*7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color:AppColor.transparentColor,
                      border: Border.all(color: AppColor.redColor,width: 2.w)
                    ),
                      child: Center(
                        child: Text('+ Add New Public Review Link',
                           style: AppTextStyle.semiBold16(AppColor.redColor)),
                      )
                    ),
                  ),
                  h(15),

                ],
              ),
            )
        ),
        h(15),
      ],
    );
 }

 Widget ThirdScreenWidget(BuildContext context){

    return Column(
      children: [
        Container(
          // height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.lightGreyColor.withOpacity(0.8)
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Obx(() => Checkbox(
                        value: controller.inviteReviewer.value,
                        onChanged: (value) {
                          controller.inviteReviewer.value = value ?? false;
                        },
                        activeColor: AppColor.blueColor,
                        checkColor: Colors.white,
                      )),
                      Text('Remind reviewer to write a review by an email after',
                          style: AppTextStyle.medium10(AppColor.blackColor)),
                    ],
                  ),
                  h(10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Type Here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  h(10),
                  Obx(() {
                    return CommonDropdownButton<String>(
                      hintText: "Select",
                      value: controller.selectList.entries
                          .any((e) => e.value)
                          ? controller.selectList.entries.firstWhere((e) => e.value).key : null,
                      items: controller.selectList.keys.map((role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectList.updateAll((key, _) => false);
                          controller.selectList[value] = true;
                          print("Selected emails: $value");
                        }
                      },
                    );
                  }),
                  h(10),
                ],
              ),
            )
        ),
        h(20),
        Container(
          // height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.lightGreyColor.withOpacity(0.8)
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Obx(() => Checkbox(
                        value: controller.inviteReviewer.value,
                        onChanged: (value) {
                          controller.inviteReviewer.value = value ?? false;
                        },
                        activeColor: AppColor.blueColor,
                        checkColor: Colors.white,
                      )),
                      Text('Request reviewer to take an additional Survey',
                          style: AppTextStyle.medium10(AppColor.blackColor)),
                    ],
                  ),
                  h(10),
                  Obx(() {
                    return CommonDropdownButton<String>(
                      hintText: "Select",
                      value: controller.selectList.entries
                          .any((e) => e.value)
                          ? controller.selectList.entries.firstWhere((e) => e.value).key : null,
                      items: controller.selectList.keys.map((role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectList.updateAll((key, _) => false);
                          controller.selectList[value] = true;
                          print("Selected emails: $value");
                        }
                      },
                    );
                  }),
                  h(10),
                ],
              ),
            )
        ),
      ],
    );

 }
}