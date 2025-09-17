

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_app/Screens/Campaign/controllers/new_survey_controller.dart';
import 'package:survey_app/common/common_widget.dart';
import '../../../common/common_app_shell.dart';
import '../../../common/common_divider.dart';
import '../../../common/common_drop_down.dart';
import '../../../common/common_flex.dart';
import '../../../common/common_textfield.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text_style.dart';
import '../models/survey_model.dart';

class CreateNewSurveyScreen extends GetView<NewSurveyController>{
  const CreateNewSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                           color: AppColor.cardColor,
                           border: Border.all(
                               color: AppColor.lightGreyColor
                           )
                       ),
                       child: Column(
                         children: [
                           h(20),
                           Obx(() {
                             return Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: List.generate(controller.totalSteps, (index) {
                                 bool isActive = controller.currentStep.value == index + 1;
                                 bool isCompleted = controller.currentStep.value > index + 1;

                                 return Row(
                                   children: [
                                     buildStepCircle("${index + 1}", isActive, isCompleted),
                                     if (index < controller.totalSteps - 1)
                                       buildStepLine(context),
                                   ],
                                 );
                               }),
                             );
                           }),

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
                       final isLastStep = controller.currentStep.value == controller.totalSteps;
                       return Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           OutlinedButton(
                             onPressed: controller.currentStep.value == 1
                                 ? null
                                 : controller.previousStep,
                             style: OutlinedButton.styleFrom(
                               backgroundColor: controller.currentStep.value == 1
                                   ? AppColor.buttonBackgroundColor
                                   : AppColor.blueColor,
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
                       if (isLastStep) {
                       controller.submitForm();
                       } else {
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
                             child: Text(isLastStep ? 'Submit' : 'Next'),
                           ),
                         ],
                       );
                     }),
                     h(20),
                     Obx(() {
                       switch (controller.currentStep.value) {
                         case 1:
                           return firstScreenWidget(context);
                         case 2:
                           return secondScreenWidget(context);
                          case 3:
                            return thirdScreenWidget(context);
                            case 4:
                            return fourthScreenWidget(context);
                         default:
                           return const SizedBox();
                       }
                     }),
                   ],
                 ),
               ),


              ]
          ),
        )
    );
  }

  Widget buildStepCircle(String text, bool isActive, bool isCompleted) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: isCompleted
          ? AppColor.primaryColor
          : isActive
          ? AppColor.primaryColor
          : AppColor.greyColor,
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

 Widget firstScreenWidget(BuildContext context){
    return Column(
      children: [
        TextField(
          controller: controller.surveyNameController,
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
            filled: true,
            fillColor: AppColor.offWhite,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
   borderSide: BorderSide(
   color: AppColor.bordertextFieldColor,
   width: 1.w,

            ),
          ),)),

        h(20),
        CustomTextInput(
          textEditController: controller.surveyDesController,
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
          onTap: () => controller.pickStartDate(context),
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
          onTap: () => controller.pickEndDate(context),
        ),
        h(20),
      ],
    );
 }

 Widget secondScreenWidget(BuildContext context){
    return Column(
      children: [
        Container(
         // height: MediaQuery.of(context).size.height/5,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColor.cardColor,
            border: Border.all(
              color: AppColor.lightGreyColor
            )
          ),
          child: Obx(() {
            return Column(
              children: [
                h(20),
                Text(
                  'Add questions to the survey',
                  style: AppTextStyle.semiBold14(AppColor.blueColor),
                ),
                h(10),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'You can add questions from questionnaire or create new questions',
                    style: AppTextStyle.semiBold12(AppColor.greyColor),
                  ),
                ),
                h(15),

                OutlinedButton(
                  onPressed: () {
                    controller.selectedButtonIndex.value = 0;
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: controller.selectedButtonIndex.value == 0
                        ? AppColor.primaryColor
                        : AppColor.transparentColor,
                    foregroundColor: controller.selectedButtonIndex.value == 0
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                    side: const BorderSide(color: AppColor.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Create New Question',
                    style: AppTextStyle.semiBold14(
                      controller.selectedButtonIndex.value == 0
                          ? AppColor.whiteColor
                          : AppColor.primaryColor,
                    ),
                  ),
                ),

                h(15),
                // Obx(() {
                //   return OutlinedButton(
                //     onPressed: () async {
                //       controller.selectedButtonIndex.value = 1;
                //       await controller.fetchAnswers(1);
                //       final questionsList = controller.questions
                //           .map((q) => q.questionText)
                //           .toList();
                //       showQuestionBankDialog(context, controller, questionsList);
                //     },
                //     style: OutlinedButton.styleFrom(
                //       backgroundColor: controller.selectedButtonIndex.value == 1
                //           ? AppColor.primaryColor
                //           : AppColor.transparentColor,
                //       foregroundColor: controller.selectedButtonIndex.value == 1
                //           ? AppColor.whiteColor
                //           : AppColor.primaryColor,
                //       side: const BorderSide(color: AppColor.primaryColor),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //     ),
                //     child: Text(
                //       'Add From Questionnaire',
                //       style: AppTextStyle.semiBold14(
                //         controller.selectedButtonIndex.value == 1
                //             ? AppColor.whiteColor
                //             : AppColor.primaryColor,
                //       ),
                //     ),
                //   );
                // }),

                Obx(() {
                  return OutlinedButton(
                    onPressed: () async {
                      controller.selectedButtonIndex.value = 1;
                      await controller.fetchQuestions(1);

                      final questionsList =
                      controller.questions.map((q) => q.questionText).toList();

                      showQuestionBankDialog(
                        context,
                        controller,
                        questionsList,
                        onSelected: (selected) {
                          controller.selectedQuestions.assignAll(selected);
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: controller.selectedButtonIndex.value == 1
                          ? AppColor.primaryColor
                          : AppColor.transparentColor,
                      foregroundColor: controller.selectedButtonIndex.value == 1
                          ? AppColor.whiteColor
                          : AppColor.primaryColor,
                      side: const BorderSide(color: AppColor.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Add From Questionnaire',
                      style: AppTextStyle.semiBold14(
                        controller.selectedButtonIndex.value == 1
                            ? AppColor.whiteColor
                            : AppColor.primaryColor,
                      ),
                    ),
                  );
                }),


                h(15),
              ],
            );
          }),

        ),
        h(20),
        Obx(() {
          if (controller.selectedButtonIndex.value == 1 &&
              controller.selectedQuestions.isNotEmpty) {
            return Column(
              children: List.generate(controller.selectedQuestions.length, (index) {
                final question = controller.selectedQuestions[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColor.cardColor,
                    border: Border.all(color: AppColor.lightGreyColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        h(20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Question ${index + 1}',
                              style: AppTextStyle.semiBold14(AppColor.greyColor)),
                        ),
                        h(10),
                        TextField(
                          controller: TextEditingController(text: question),
                          decoration: InputDecoration(
                            labelText: "Enter Question Here *",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                        h(15),

                        Obx(() {
                          if (controller.optionsList.isEmpty && !controller.isLoading.value) {
                            controller.fetchAnswerTypes();
                          }
                          if (controller.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          return CommonDropdownButton<String>(
                            hintText: 'Select Answer Type',
                            value: controller.selectedOption.value.isEmpty
                                ? null
                                : controller.selectedOption.value,
                            items: controller.optionsList
                                .map((option) => DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedOption.value = value;
                              }
                            },
                          );
                        }),


                        h(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Mark as mandatory",
                                style: AppTextStyle.medium14(AppColor.greyColor)),
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
                              onTap: () {
                                // copy logic
                              },
                              child: const Icon(Icons.copy,
                                  size: 20, color: AppColor.blackColor),
                            ),
                            w(10),
                            GestureDetector(
                              onTap: () {
                                controller.selectedQuestions.removeAt(index);
                              },
                              child: const Icon(Icons.delete,
                                  size: 20, color: AppColor.blackColor),
                            ),
                          ],
                        ),
                        h(15),
                      ],
                    ),
                  ),
                );
              }),
            );
          }
          return SizedBox.shrink(); // nothing if no questions
        }),

        h(20),
        Container(
          // height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                 color: AppColor.cardColor,
                border: Border.all(
                    color: AppColor.lightGreyColor
                )
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

 Widget thirdScreenWidget(BuildContext context){

    return Column(
      children: [
        Container(
          // height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.cardColor,
                border: Border.all(
                    color: AppColor.lightGreyColor
                )
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
                color: AppColor.cardColor,
                border: Border.all(
                    color: AppColor.lightGreyColor
                )
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

 Widget fourthScreenWidget(BuildContext context) {
    return Column(
      children: [
        // Top tab buttons
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => controller.selectedTabIndex.value = 0,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(100.w, 30.h),
                  backgroundColor: controller.selectedTabIndex.value == 0
                      ? AppColor.rizePurpleColor
                      : Colors.transparent,
                  side: BorderSide(color: AppColor.blackColor, width: 1.w),
                ),
                child: Text(
                  'Recipient List',
                  style: AppTextStyle.semiBold14(
                    controller.selectedTabIndex.value == 0
                        ? AppColor.whiteColor
                        : AppColor.blackColor.withOpacity(0.4),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () => controller.selectedTabIndex.value = 1,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(100.w, 30.h),
                  backgroundColor: controller.selectedTabIndex.value == 1
                      ? AppColor.rizePurpleColor
                      : Colors.transparent,
                  side: BorderSide(color: AppColor.blackColor.withOpacity(0.4), width: 1),
                ),
                child: Text(
                  'Link survey to Agents',
                  style: AppTextStyle.semiBold14(
                    controller.selectedTabIndex.value == 1
                        ? AppColor.whiteColor
                        : AppColor.blackColor.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          );
        }),
        h(20),
        Obx(() {
          if (controller.selectedTabIndex.value == 0) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () => controller.selectButton(0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: controller.selectedIndex.value == 0
                          ? AppColor.primaryColor
                          : AppColor.transparentColor,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        'Download Sample File',
                        style: AppTextStyle.medium14(
                          controller.selectedIndex.value == 0
                              ? AppColor.whiteColor
                              : AppColor.redColor,
                        ),
                      ),
                    ),
                  ),
                ),
                h(10),
                GestureDetector(
                  onTap: () => controller.selectButton(1),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: controller.selectedIndex.value == 1
                          ? AppColor.primaryColor
                          : AppColor.transparentColor,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        'Create New Question',
                        style: AppTextStyle.medium14(
                          controller.selectedIndex.value == 1
                              ? AppColor.whiteColor
                              : AppColor.redColor,
                        ),
                      ),
                    ),
                  ),
                ),
                h(10),
                GestureDetector(
                  onTap: () => controller.selectButton(2),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: controller.selectedIndex.value == 2
                          ? AppColor.primaryColor
                          : AppColor.transparentColor,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        '+ Add Recipients',
                        style: AppTextStyle.medium14(
                          controller.selectedIndex.value == 2
                              ? AppColor.whiteColor
                              : AppColor.redColor,
                        ),
                      ),
                    ),
                  ),
                ),
                h(10),
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
        h(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomTextInput(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColor.greyPurpleColor,
                  size: 20.sp,
                ),
                textEditController: controller.searchController,
                hintTextString: "Type into Search",
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
        h(10),
        ListView.builder(
          itemCount: controller.users.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final user = controller.users[index];

            return Obx(() {
              final expanded = controller.isExpanded.value == index;

              return CommonActionCard(
                key: ValueKey(index),
                name: user.name,
                gmail: user.email,
                details: user.details.cast<Map<String, String>>(),
                isExpanded: expanded,
                onArrowTap: () => controller.toggleExpand(index),
                onEdit: () => print("Edit ${user.name}"),
                onDelete: () => print("Delete ${user.name}"),
              );
            });
          },
        )

      ],
    );
  }

  void showQuestionBankDialog(
      BuildContext context,
      NewSurveyController controller,
      List<String> answers, {
        void Function(List<String>)? onSelected,
      }) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            // height: MediaQuery.of(context).size.height*4,
            // width: MediaQuery.of(context).size.width*7,
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text("Select from Question Bank",
                  style: AppTextStyle.semiBold14(AppColor.blackColor)),
               h(10),
                divider(),
                SizedBox(
                  height: 300.h,
                  child: ListView.builder(
                    itemCount: answers.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        final isSelected = controller.selectedListIndexes.contains(index);
                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (value) {
                            if (value == true) {
                              controller.selectedListIndexes.add(index);
                            } else {
                              controller.selectedListIndexes.remove(index);
                            }
                          },
                          title: Text(answers[index]),
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      });
                    },
                  ),
                ),
                h(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel",style: AppTextStyle.semiBold14(AppColor.blackColor),),
                    ),
                    w(10),
                    Obx(() {
                      return ElevatedButton(
                        onPressed: controller.selectedListIndexes.isEmpty
                            ? null
                            : () {
                          final selected = controller.selectedListIndexes
                              .map((i) => answers[i])
                              .toList();
                          if (onSelected != null) {
                            onSelected(selected);
                          }

                          Navigator.pop(context);
                        },
                        child: Text("Add",style: AppTextStyle.semiBold14(AppColor.blackColor),),
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}

class CommonActionCard extends StatelessWidget {
  final String? name;
  final String? gmail;
  final List<Map<String, String>>? details;
  final bool isExpanded;
  final VoidCallback? onArrowTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CommonActionCard({
    Key? key,
    this.name,
    this.gmail,
    this.details,
    required this.isExpanded,
    this.onArrowTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        child: Card(
          color: AppColor.cardColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(color: AppColor.lightGreyColor, width: 1.w),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (name != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name!,
                          style:
                          const TextStyle(fontWeight: FontWeight.bold)),
                      if (details != null && details!.isNotEmpty)
                        InkWell(
                          onTap: onArrowTap,
                          child: Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColor.blackColor,
                          ),
                        ),
                    ],
                  ),

                if (gmail != null) Text(gmail!, style: const TextStyle(color: Colors.grey)),

                // Expanded content
                if (isExpanded && details != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    h(8),
                      ...details!.map(
                            (detail) => DetailRow(

                              label: detail["label"] ?? "",
                              value: detail["value"] ?? "",

                        ),
                      ),
                     h(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (onEdit != null)
                            IconButton(
                                icon: const Icon(Icons.edit,
                                    color: AppColor.blackColor),
                                onPressed: onEdit),
                          if (onDelete != null)
                            IconButton(
                                icon: const Icon(Icons.delete,
                                    color: AppColor.blackColor),
                                onPressed: onDelete),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





