import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/common_flex.dart';
import '../../../common/common_textfield.dart';
import '../../../common/common_widget.dart';
import '../../../nav/app_pages.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';
import '../../../utils/app_text_style.dart';
import '../controllers/login_page_controller.dart';
import 'forgot_password_page.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      body: SafeArea(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 47.h,width: 53.w,
                    child: Image.asset('assets/images/rize_app.png')),
                h(10),
                Container(
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
                          Text("Sign In",
                            style: AppTextStyle.semiBold32(AppColor.blackColor,),
                          ),
                          // h(12.h),
                          // Row(
                          //   children: [
                          //     Text("New user?",
                          //       style: AppTextStyle.regular12(AppColor.blackColor,),
                          //     ),
                          //     w(10.w),
                          //     InkWell(
                          //       onTap: () => Get.toNamed(Routes.signUp),
                          //       child: Text("Create an account",
                          //         style: AppTextStyle.regular12(AppColor.primaryColor,),
                          //       ),
                          //     ),
                          //   ],
                          // ),
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
                          ),),
                          h(10.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () => Get.to(()=>const ForgotPasswordPage()),
                              child: Text("Forgot password?",
                                style: AppTextStyle.regular12(AppColor.blackColor,),
                              ),
                            ),
                          ),

                          h(10.h),
                          fillButton(
                            title: "Login",
                            buttonBackgroundColor: AppColor.primaryColor,
                            titleColor: AppColor.whiteColor,
                            onPressed: () {
                              // if (controller.formKey.currentState!.validate()) {
                                Get.offAllNamed(Routes.home);
                              // }z
                            },
                          ),
                          // h(20.h),
                          // Image.asset(AppImage.orIcon),
                          // h(10.h),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Expanded(
                          //       child: fillButtonWithIcon(
                          //         icon: AppImage.googleIcon,
                          //         title: "Google",
                          //         buttonBackgroundColor: AppColor.whiteColor,
                          //         titleColor: AppColor.blackColor,
                          //         borderColor: AppColor.borderColor,
                          //         onPressed: () {
                          //         },
                          //       ),
                          //     ),
                          //     w(10.w),
                          //     Expanded(
                          //       child: fillButtonWithIcon(
                          //         title: "Facebook",
                          //         icon: AppImage.fbIcon,
                          //         buttonBackgroundColor: AppColor.whiteColor,
                          //         titleColor: AppColor.blackColor,
                          //         borderColor: AppColor.borderColor,
                          //         onPressed: () {
                          //         },
                          //       ),
                          //     ),
                          //   ],
                          // ),
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
              ],
            ),
          ),

      ),
    );
  }
}
