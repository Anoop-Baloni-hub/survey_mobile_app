
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
import '../viewModel/AnswerList.dart';
import '../viewModel/questionList.dart';

class QuestionBank extends GetView<QuestionBankController> {
  const QuestionBank({super.key});

  @override
  Widget build(BuildContext context) {
     final _scaffoldKey = GlobalKey<ScaffoldState>();

    return AppShell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          divider(),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.selectedIndex.value = 0;
                    controller.fetchQuestionGroups();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.selectedIndex.value == 0
                        ? AppColor.rizePurpleColor
                        : AppColor.whiteColor,
                    side: BorderSide(color: AppColor.blackColor, width: 1.w),
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
                w(10),
                ElevatedButton(
                  onPressed: () {
                    controller.selectedIndex.value = 1;
                    controller.fetchAnswerGroups();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.selectedIndex.value == 1
                        ? AppColor.rizePurpleColor
                        : AppColor.whiteColor,
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
                    textEditController: controller.searchController,
                    hintTextString: "Type into Search",
                    borderColor: AppColor.borderColor,
                    inputType: InputType.defaults,
                  ),
                ),
                SizedBox(width: 20.w),
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
          Obx(() {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: GestureDetector(
                onTap: () {
                  if (controller.selectedIndex.value == 0) {
                    showAddQuestionDialog(context, isEdit: false);
                  } else if (controller.selectedIndex.value == 1) {
                    showAddAnswerChoiceDialog(context,isEdit: false);
                  }
                },
                child: Column(
                  children: [
                    Container(
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
                    h(10),
                    // Align(
                    //     alignment: Alignment.centerRight,
                    //     child: InkWell(
                    //     onTap: (){},
                    //     child: Text('Page 1 of 10',style: AppTextStyle.medium12(AppColor.blueColor),)))
                  ],
                ),
              ),
            );
          }),
          h(20),
          Expanded(
            child: Obx(() {
              if (controller.selectedIndex.value == 0) {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.filteredQuestionList.isEmpty) {
                  return const Center(child: Text("No questions found"));
                }

                return ListView.builder(
                  itemCount: controller.filteredQuestionList.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredQuestionList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: ActionItemCard(
                        id: '#ID ${item.questionId}',
                        title: item.questionText ?? '',
                        details: [
                          {"label": "Answer Type", "value": item.answerType ?? "Text"},
                          {"label": "Category", "value": item.categories ?? ""},
                          {"label": "Modified on", "value": item.modifiedOn ?? ""},
                        ],
                        onEdit: () => showAddQuestionDialog(
                          context,
                          isEdit: true,
                          question: item,
                        ),
                        onCopy: () {},
                        onDelete: () => showDeleteDialog(context, item.questionId!),

                      ),
                    );
                  },
                );
              } else {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage.value.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                } else if (controller.answerList.isEmpty) {
                  return const Center(child: Text("No Answer Groups Found"));
                }

                return ListView.builder(
                  itemCount: controller.answerList.length,
                  itemBuilder: (context, index) {
                    final item = controller.answerList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: ActionItemCard(
                        id: '#ID ${item.answerChoiceGroupId ?? ""}',
                        title: item.answerChoiceGroupName ?? "",
                        details: [
                          {"label": "Category", "value": item.categories ?? ""},
                          {"label": "Modified on", "value": item.modifiedOn ?? ""},
                        ],
                        onEdit: () => showAddAnswerChoiceDialog(
                          context,isEdit: true,
                            answer : item),
                        onCopy: () {},
                        onDelete: () => showDeleteDialog(context, item.answerChoiceGroupId!),
                      ),
                    );
                  },
                );
              }
            }),
          ),
          h(10),

        ],
      ),
    );
  }
}

void showAddQuestionDialog(
    BuildContext context, {
      bool isEdit = false,
      QuestionResponseModel? question,
    }) {
  final controller = Get.find<QuestionBankController>();

  if (isEdit && question != null) {
    controller.textController.text = question.questionText ?? "";
    controller.selectedOption.value =
        controller.mapAnswerTypeIdToName(question.answerTypeId ?? 0);

    controller.categoryList.updateAll((key, value) => false);
    if (question.categories != null && question.categories!.isNotEmpty) {
      final selectedCats =
      question.categories!.split(",").map((e) => e.trim()).toList();

      for (var key in controller.categoryList.keys) {
        controller.categoryList[key] = selectedCats.contains(key);
      }

      controller.categoryController.text = selectedCats.join(", ");
    } else {
      controller.categoryController.clear();
    }
    controller.minController.text =
        question.minimumCharacter?.toString() ?? "";
    controller.maxController.text =
        question.maximumCharacter?.toString() ?? "";
  } else {
    controller.textController.clear();
    controller.selectedOption.value = "";
    controller.categoryController.clear();
    controller.minController.clear();
    controller.maxController.clear();
    controller.categoryList.updateAll((key, value) => false);
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        title: Text(
          isEdit ? "Edit Question" : "Add Question",
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
                hintText: 'Select Answer Type',
                items: controller.optionsList
                    .map((option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ))
                    .toList(),
                value: controller.selectedOption.value.isEmpty
                    ? null
                    : controller.selectedOption.value,
                onChanged: (value) {
                  controller.selectedOption.value = value!;
                },
              )),
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
                          children:
                          controller.categoryList.keys.map((category) {
                            return CheckboxListTile(
                              title: Text(category),
                              value: controller.categoryList[category],
                              onChanged: (val) {
                                controller.categoryList[category] =
                                    val ?? false;
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

                            controller.categoryController.text =
                                selected.join(", ");
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
              if (isEdit)
                Row(
                  children: [
                    Expanded(
                      child: CustomTextInput(
                        textEditController: controller.minController,
                        hintTextString: 'Min Character',
                      ),
                    ),
                    w(6),
                    Expanded(
                      child: CustomTextInput(
                        textEditController: controller.maxController,
                        hintTextString: 'Max Character',
                      ),
                    ),
                  ],
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
            onPressed: () async {
              print(
                  "Question submitted: ${controller.textController.text} | Edit: $isEdit");

              final success = await controller.submitQuestion(
                isEdit: isEdit,
                questionId: question?.questionId,
              );

              if (success && context.mounted) {
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor),
            child: Text(
              isEdit ? "Update" : "Submit",
              style: AppTextStyle.semiBold12(AppColor.whiteColor),
            ),
          ),
        ],
      );
    },
  );
}

void showDeleteDialog(BuildContext context, int questionId) {
  final controller = Get.find<QuestionBankController>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        title: Text(
          "Delete Campaign",
          style: AppTextStyle.bold14(AppColor.blackColor),
        ),
        content: Text(
          "Are you sure you want to delete this Campaign? This process can't be undone",
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
              controller.deleteQuestion(questionId);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}

void showAddAnswerChoiceDialog(BuildContext context , {
bool isEdit = false,
  AnswerGroupResponseModel? answer,
}) {
  final controller = Get.find<QuestionBankController>();

  if (isEdit && answer != null) {
    controller.answerTextController.text = answer.answerChoiceGroupName ?? "";
    controller.categoryList.updateAll((key, value) => false);
    if (answer.categories != null && answer.categories!.isNotEmpty) {
      final selectedCats =
      answer.categories!.split(",").map((e) => e.trim()).toList();
      for (var key in controller.categoryList.keys) {
        controller.categoryList[key] = selectedCats.contains(key);
      }
      controller.categoryController.text = selectedCats.join(", ");
    } else {
      controller.categoryController.clear();
    }
  } else {
    controller.answerTextController.clear();
    controller.categoryController.clear();
    controller.categoryList.updateAll((key, value) => false);
  }
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextInput(
                  textEditController: controller.answerTextController,
                  hintTextString: 'Enter Answer Choice Group Name',
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
                h(20),
                Obx(() {
                  final optionCount = controller.answerOptionsControllers.length;
                  final children = controller.answerOptionsControllers
                      .asMap().entries.map((entry) {
                    final index = entry.key;
                    final answerTextController = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: answerTextController,
                              decoration: InputDecoration(
                                hintText: 'Option ${index + 1}',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                          w(8),
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: AppColor.primaryColor),
                            onPressed: () {
                              controller.answerOptionsControllers.removeAt(index);
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList();

                  if (optionCount <= 3) {
                    return Column(children: children);
                  } else {
                    return SizedBox(
                      height: 250.h,
                      child: ListView(children: children),
                    );
                  }
                }),
                GestureDetector(
                  onTap: (){
                    controller.answerOptionsControllers.add(TextEditingController());
                  },
                  child: Text('+ Add New Option',
                  style: AppTextStyle.semiBold12(AppColor.primaryColor)),
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: ()async {
              print("Answer choice group submitted: ${controller.answerTextController.text}");
                 final success = await controller.submitAnswerChoiceGroup(
               isEdit: isEdit,
            groupId: answer?.answerChoiceGroupId,
             );
            if (success && context.mounted) {
           Navigator.pop(context);
              }
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

