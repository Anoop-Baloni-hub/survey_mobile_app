
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:survey_app/Screens/Users/controllers/userController.dart';
import 'package:survey_app/common/common_app_shell.dart';
import '../../../common/common_divider.dart';
import '../../../common/common_drop_down.dart';
import '../../../common/common_flex.dart';
import '../../../common/common_textfield.dart';
import '../../../common/common_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text_style.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final formKey1 = GlobalKey<FormState>();
    return AppShell(
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
                            :AppColor.transparentColor,
                        side: BorderSide(color: AppColor.blackColor, width: 1.w),
                      ),
                      child: Text(
                        'Invited User',
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
                            : Colors.transparent,
                        side: BorderSide(color: AppColor.blackColor.withOpacity(0.4), width: 1),
                      ),
                      child: Text(
                        'Onboard Users',
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
              ),
              h(20),
              Obx(() {
                if (controller.selectedIndex.value != 0) {
                  return const SizedBox.shrink();
                }
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              title: Text("Invite User",style: AppTextStyle.bold14(AppColor.blackColor),),
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width * 1.w,
                                child: Form(
                                  key: formKey1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomTextInput(
                                        textEditController: controller.firstNameController,
                                        labelText: 'First Name',
                                        validator: (value) =>
                                        value == null || value.isEmpty ? "First Name required" : null,
                                      ),
                                      h(10),
                                      CustomTextInput(
                                        textEditController: controller.lastNameController,
                                        labelText: 'Last Name',
                                        validator: (value) =>
                                        value == null || value.isEmpty ? "Last Name required" : null,
                                      ),
                                      h(10),
                                      CustomTextInput(
                                        textEditController: controller.emailController,
                                        hintTextString: 'Email Id',
                                        validator: (value) =>
                                        value == null || value.isEmpty ? "Email Id is required" : null,
                                      ),
                                      h(20),
                                      CustomTextInput(
                                        textEditController: controller.phoneController,
                                        hintTextString: 'Contact Number',
                                        inputType: InputType.number,
                                        validator: (value) =>
                                        value == null || value.isEmpty ? "Mobile Number is required" : null,
                                      ),
                                      h(20),
                                      Obx(() {
                                        return CommonDropdownButton<String>(
                                          hintText: "Select Role",
                                          value: controller.roleList.entries
                                              .any((e) => e.value)
                                              ? controller.roleList.entries.firstWhere((e) => e.value).key : null,
                                          items: controller.roleList.keys.map((role) {
                                            return DropdownMenuItem<String>(
                                              value: role,
                                              child: Text(role),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.roleList.updateAll((key, _) => false);
                                              controller.roleList[value] = true;
                                              print("Selected role: $value");
                                            }
                                          },
                                        );
                                      }),
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
                                        return CommonDropdownButton<String>(
                                          hintText: "Location",
                                          value: controller.selectedLocation.value,
                                          items: controller.locationList.map((loc) {
                                            return DropdownMenuItem<String>(
                                              value: loc,
                                              child: Text(loc),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.selectedLocation.value = value;
                                          },
                                        );
                                      }),
                                      h(20),
                                      CustomTextInput(
                                        textEditController: controller.phoneController,
                                        hintTextString: 'Default Survey',
                                      ),
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
                                    if (formKey1.currentState!.validate()) {

                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(color:AppColor.blackColor.withOpacity(0.4), width: 1.w),
                                      backgroundColor: AppColor.primaryColor
                                  ),
                                  child:  Text("Invite",
                                    style: AppTextStyle.semiBold12(AppColor.whiteColor),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20.w),
                        height: MediaQuery.of(context).size.height * 0.04.h,
                        width: MediaQuery.of(context).size.width * 0.4.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColor.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            '+ Invite User',
                            style: AppTextStyle.semiBold15(AppColor.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              h(20),
              Expanded(
                child: Obx(() {
                  final users = controller.selectedIndex.value == 0
                      ? controller.invitedUsers
                      : controller.onboardUsers;

                  final isRefreshScreen = controller.selectedIndex.value != 1;

                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.errorMessage.value.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  }
                  if (users.isEmpty) {
                    return Center(
                      child: Text(isRefreshScreen ? "No Invited Users found" : "No Onboard Users found"),
                    );
                  }
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      print("userLength are : ${users.length}");
                      final user = users[index];
                      return ActionItemCard(
                        name: user.userName,
                        gmail: user.email,
                        details:[
                          {"label": "Role", "value": user.roleName ?? "Text"},
                          {"label": "Location", "value": user.categories ?? ""},
                          {"label": "Category", "value": user.categories ?? ""},
                        ] ,
                        isRefreshScreen: isRefreshScreen,
                        onRefresh: isRefreshScreen ? () {
                          print("Refresh tapped for ${user.userName}");
                        } : null,
                        onEdit: !isRefreshScreen ? () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                title: Text("Edit User",style: AppTextStyle.bold14(AppColor.blackColor),),
                                content: SizedBox(
                                  width: MediaQuery.of(context).size.width * 1.w,
                                  child: Form(
                                    key: formKey1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomTextInput(
                                          textEditController: controller.firstNameController,
                                          labelText: 'First Name',
                                          validator: (value) =>
                                          value == null || value.isEmpty ? "First Name required" : null,
                                        ),
                                        h(10),
                                        CustomTextInput(
                                          textEditController: controller.lastNameController,
                                          labelText: 'Last Name',
                                          validator: (value) =>
                                          value == null || value.isEmpty ? "Last Name required" : null,
                                        ),
                                        h(10),
                                        CustomTextInput(
                                          textEditController: controller.emailController,
                                          hintTextString: 'Email Id',
                                          validator: (value) =>
                                          value == null || value.isEmpty ? "Email Id is required" : null,
                                        ),
                                        h(20),
                                        CustomTextInput(
                                          textEditController: controller.phoneController,
                                          hintTextString: 'Contact Number',
                                          inputType: InputType.number,
                                          validator: (value) =>
                                          value == null || value.isEmpty ? "Mobile Number is required" : null,
                                        ),
                                        h(20),
                                        Obx(() {
                                          return CommonDropdownButton<String>(
                                            hintText: "Select Role",
                                            value: controller.roleList.entries
                                                .any((e) => e.value)
                                                ? controller.roleList.entries.firstWhere((e) => e.value).key : null,
                                            items: controller.roleList.keys.map((role) {
                                              return DropdownMenuItem<String>(
                                                value: role,
                                                child: Text(role),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              if (value != null) {
                                                controller.roleList.updateAll((key, _) => false);
                                                controller.roleList[value] = true;
                                                print("Selected role: $value");
                                              }
                                            },
                                          );
                                        }),
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
                                          return CommonDropdownButton<String>(
                                            hintText: "Location",
                                            value: controller.selectedLocation.value,
                                            items: controller.locationList.map((loc) {
                                              return DropdownMenuItem<String>(
                                                value: loc,
                                                child: Text(loc),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              controller.selectedLocation.value = value;
                                            },
                                          );
                                        }),
                                        h(20),
                                        CustomTextInput(
                                          textEditController: controller.phoneController,
                                          hintTextString: 'Default Survey',
                                        ),
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
                                      if (formKey1.currentState!.validate()) {

                                        Navigator.pop(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        side: BorderSide(color:AppColor.blackColor.withOpacity(0.4), width: 1.w),
                                        backgroundColor: AppColor.primaryColor
                                    ),
                                    child:  Text("Edit",
                                      style: AppTextStyle.semiBold12(AppColor.whiteColor),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } : null,
                        // onCopy: !isRefreshScreen ? () {
                        //   print("Copy tapped for ${user.userName}");
                        // } : null,
                        onDelete: !isRefreshScreen ? () {
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

                        } : null,
                      );
                    },
                  );
                }),
              )
            ]
        )
    );
  }

}