
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
            DrawerItem(label: 'Question Bank', leading: Image.asset(AppImage.group),route: Routes.home),
            DrawerItem(label: 'Campaign', leading: Image.asset(AppImage.check)),
            DrawerItem(label: 'Users', leading: Image.asset(AppImage.profileCircle)),
          ],
          onLogout: () {},
        ),
        appBar: const CommonAppbar(),
      body:const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       Text('demo')
        ],
      ) ,
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

