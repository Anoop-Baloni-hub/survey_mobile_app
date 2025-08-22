
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:survey_app/Screens/QuestionBank/controllers/questionBank_controller.dart';
import 'package:get/get.dart';
import 'package:survey_app/common/common_app_shell.dart';
import '../../../common/common_appbar.dart';
import '../../../common/common_drawer.dart';
import '../../../common/common_divider.dart';
import '../../../common/common_drop_down.dart';
import '../../../common/common_widget.dart';
import '../../../utils/app_text_style.dart';
import '../../../nav/app_pages.dart';
import '../../../common/common_flex.dart';
import '../../../common/common_textfield.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';

class QuestionBank extends GetView<QuestionBankController> {
  const QuestionBank({super.key});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return AppShell(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            divider(),
            // Tab Buttons
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.selectedIndex.value = 0; // Question
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedIndex.value == 0
                          ? AppColor.rizePurpleColor
                          : Colors.transparent,
                      side: BorderSide(
                          color: AppColor.blackColor.withOpacity(0.4), width: 1),
                    ),
                    child: Text(
                      "List of Question",
                      style: AppTextStyle.semiBold13(
                        controller.selectedIndex.value == 0
                            ? AppColor.whiteColor
                            : AppColor.blackColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () {
                      controller.selectedIndex.value = 1; // Answer Choice
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedIndex.value == 1
                          ? AppColor.rizePurpleColor
                          : Colors.transparent,
                      side: BorderSide(
                          color: AppColor.blackColor.withOpacity(0.4), width: 1),
                    ),
                    child: Text(
                      "Answer Choice Groups",
                      style: AppTextStyle.semiBold13(
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
              padding: EdgeInsets.only(left: 15.w, right: 10.w),
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
                      hintTextString: "Type into Search",
                      borderColor: AppColor.borderColor,
                      inputType: InputType.defaults,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
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
                            "Short By",
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
                ],
              ),
            ),
            h(20),

            Obx(() {
              return Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: GestureDetector(
                  onTap: () {
                    if (controller.selectedIndex.value == 0) {
                      showAddQuestionDialog(context);
                    } else if (controller.selectedIndex.value == 1) {
                      showAddAnswerChoiceDialog(context);
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColor.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        controller.selectedIndex.value == 0
                            ? '+ Add Question'
                            : '+ Add Answer Choice Group',
                        style: AppTextStyle.semiBold15(AppColor.whiteColor),
                      ),
                    ),
                  ),
                ),
              );
            }),

            h(20),

            // List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ActionItemCard(
                    id: '#ID ${index + 10}',
                    title: 'If you are 18+ now you can take a loan',
                    details: [
                      {
                        "label": "Answer Type",
                        "value": index == 0 ? "Date" : "Text"
                      },
                      {
                        "label": "Category",
                        "value": index == 1 ? "Loan" : "Mortgage"
                      },
                      const {
                        "label": "Modified on",
                        "value": "30/07/2025"
                      },
                    ],
                    onEdit: () {},
                    onCopy: () {},
                    onDelete: () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showAddQuestionDialog(BuildContext context) {
  final controller = Get.find<QuestionBankController>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        title: Text(
          "Add Question",
          style: AppTextStyle.bold14(AppColor.blackColor),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 1.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextInput(
                textEditController: controller.textController,
                hintTextString: 'Enter Question here',
              ),
              h(20),
              Obx(() => CommonDropdownButton(
                hintText: 'Select Options',
                items: controller.optionsList
                    .map((option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ))
                    .toList(),
                value: controller.selectedOption.value,
                onChanged: (value) {
                  controller.selectedOption.value = value!;
                },
              )),
              h(20),
              CustomTextInput(
                textEditController: controller.choice1Controller,
                labelText: 'Choice 1',
              ),
              h(10),
              CustomTextInput(
                textEditController: controller.choice2Controller,
                labelText: 'Choice 2',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              print("Question submitted: ${controller.textController.text}");
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
            child: Text(
              "Submit",
              style: AppTextStyle.semiBold12(AppColor.whiteColor),
            ),
          ),
        ],
      );
    },
  );
}

void showAddAnswerChoiceDialog(BuildContext context) {
  final controller = Get.find<QuestionBankController>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        title: Text(
          "Add Answer Choice Group",
          style: AppTextStyle.bold14(AppColor.blackColor),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 1.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextInput(
                textEditController: controller.textController,
                hintTextString: 'Enter Group Name',
              ),
              h(20),
              CustomTextInput(
                textEditController: controller.choice1Controller,
                labelText: 'Choice 1',
              ),
              h(10),
              CustomTextInput(
                textEditController: controller.choice2Controller,
                labelText: 'Choice 2',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              print("Answer choice group submitted: ${controller.textController.text}");
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
            child: Text(
              "Submit",
              style: AppTextStyle.semiBold12(AppColor.whiteColor),
            ),
          ),
        ],
      );
    },
  );
}

