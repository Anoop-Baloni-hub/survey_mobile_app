import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/common_flex.dart';
import '../../../common/common_textfield.dart';
import '../../../common/common_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';
import '../../../utils/app_text_style.dart';
import '../controllers/sign_up_page_controller.dart';

class SignUpPageView extends GetView<SignUpPageController> {
  const SignUpPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
          child:Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Register",
                        style: AppTextStyle.semiBold32(AppColor.blackColor,),
                      ),
                      h(12.h),
                      Row(
                        children: [
                          Text("Already have an account?",
                            style: AppTextStyle.regular12(AppColor.blackColor,),
                          ),
                          w(10.w),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Text("Login",
                              style: AppTextStyle.regular12(AppColor.primaryColor,),
                            ),
                          ),
                        ],
                      ),
                      h(20.h),
                      Text(
                        "Email address",
                        style:
                        AppTextStyle.medium12(AppColor.darkPurpleColor),
                      ),
                      h(4),
                      CustomTextInput(
                        textEditController: controller.emailController,
                        hintTextString: "Email address",
                        inputType: InputType.email,
                        borderColor: AppColor.borderColor,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter email address";
                          } else if (!GetUtils.isEmail(val)) {
                            return "Please enter valid email address";
                          }
                          return null;
                        },
                      ),
                      h(10.h),
                      Text(
                        "Password",
                        style:
                        AppTextStyle.medium12(AppColor.darkPurpleColor),
                      ),
                      h(4),
                      Obx(()=>CustomTextInput(
                        textEditController: controller.passwordController,
                        hintTextString: "Password",
                        inputType: controller.isPasswordVisible.value? InputType.defaults : InputType.password,
                        borderColor: AppColor.borderColor,
                        suffixIcon: InkWell(
                          onTap: ()=>controller.isPasswordVisible.toggle(),
                          child: Ink(
                            padding: EdgeInsets.all(10.r),
                            child: Image.asset(
                              controller.isPasswordVisible.value?   AppImage.eyeOpenIcon: AppImage.eyeClosedIcon,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                      ),
                      ),
                      h(10.h),
                      Text(
                        "Re-enter Password",
                        style:
                        AppTextStyle.medium12(AppColor.darkPurpleColor),
                      ),
                      h(4),
                      Obx(()=>CustomTextInput(
                        textEditController: controller.reEnterPasswordController,
                        hintTextString: "Re-enter Password",
                        inputType: controller.isReEnterPasswordVisible.value? InputType.defaults : InputType.password,
                        borderColor: AppColor.borderColor,
                        suffixIcon: InkWell(
                          onTap: ()=>controller.isReEnterPasswordVisible.toggle(),
                          child: Ink(
                            padding: EdgeInsets.all(10.r),
                            child: Image.asset(
                              controller.isReEnterPasswordVisible.value?   AppImage.eyeOpenIcon: AppImage.eyeClosedIcon,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please re-enter password";
                          } else if (val != controller.passwordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                      ),
                      ),

                      h(20.h),
                      fillButton(
                        title: "Register",
                        buttonBackgroundColor: AppColor.primaryColor,
                        titleColor: AppColor.whiteColor,
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {

                          }
                        },
                      ),
                      h(20.h),
                      Image.asset(AppImage.orIcon),
                      h(16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: fillButtonWithIcon(
                              icon: AppImage.googleIcon,
                              title: "Google",
                              buttonBackgroundColor: AppColor.whiteColor,
                              titleColor: AppColor.blackColor,
                              borderColor: AppColor.borderColor,
                              onPressed: () {
                              },
                            ),
                          ),
                          w(10.w),
                          Expanded(
                            child: fillButtonWithIcon(
                              title: "Facebook",
                              icon: AppImage.fbIcon,
                              buttonBackgroundColor: AppColor.whiteColor,
                              titleColor: AppColor.blackColor,
                              borderColor: AppColor.borderColor,
                              onPressed: () {
                              },
                            ),
                          ),
                        ],
                      ),
                      // h(16.h),
                      // Text("Protected by reCAPTCHA and subject to the",
                      //   style: AppTextStyle.regular12(AppColor.greyPurpleColor,),
                      // ),
                      // Wrap(
                      //   children: [
                      //     Text("SoftwareLynx Privacy Policy",
                      //       style: AppTextStyle.regular12(AppColor.primaryColor,),
                      //     ),
                      //     w(4.w),
                      //     Text("and",
                      //       style: AppTextStyle.regular12(AppColor.greyPurpleColor,),
                      //     ),
                      //     w(4.w),
                      //     Text("Terms of Service.",
                      //       style: AppTextStyle.regular12(AppColor.primaryColor,),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),

      ),
    );
  }
}
