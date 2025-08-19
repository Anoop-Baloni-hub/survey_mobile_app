import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/common_flex.dart';
import '../../../common/common_textfield.dart';
import '../../../common/common_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text_style.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Forgot Password",
                      style: AppTextStyle.semiBold32(AppColor.blackColor,),
                    ),
                    h(12.h),
                    Text(
                      "Email address",
                      style:
                      AppTextStyle.medium12(AppColor.darkPurpleColor),
                    ),
                    h(4),
                    CustomTextInput(
                      textEditController: emailController,
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
                    fillButton(
                      title: "Send Email",
                      buttonBackgroundColor: AppColor.primaryColor,
                      titleColor: AppColor.whiteColor,
                      onPressed: () {
                      },
                    ),
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
