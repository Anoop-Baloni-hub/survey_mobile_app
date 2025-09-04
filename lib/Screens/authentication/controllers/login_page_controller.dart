import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../api/api_services.dart';
import '../../../api/api_url.dart';
import '../../../data/local/shared_preference/shared_preference.dart';
import '../../HomeScreens/view/home_page.dart';
import '../view/login_page_view.dart';

class LoginPageController extends GetxController {
  final DioClient dioClient = ApiUrl.dioClient;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
   // redirectUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void redirectUser() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final bool isLoggedIn = MySharedPref.getBool("isLoggedIn") ?? false;
  //
  //     if (isLoggedIn) {
  //       Get.offAll(() => const HomePageView());
  //     } else {
  //       Get.offAll(() => const LoginPageView());
  //     }
  //   });
  // }

  Future<Map<String, dynamic>?> loginMethod({
      required String email,
      required String password,
    }) async {
      final Map<String, dynamic> requestBody = {
        "email": email,
        "password": password,
      };

      final response = await dioClient.post(
        url: ApiUrl.login,
        requestBody: requestBody,
        isAuthRequired: false,
      );

      if (response != null) {
        Map<String, dynamic> jsonResponse;

        if (response is Map<String, dynamic>) {
          jsonResponse = response;
        } else {
          jsonResponse = jsonDecode(response.toString());
        }
        //print("Login API Response → $jsonResponse");

        final accessToken = jsonResponse["result"]?["accessToken"];
        if (accessToken != null) {
          dioClient.setToken(accessToken);
          print(" Token saved: $accessToken");

          await MySharedPref.setBool("isLoggedIn", true);
          await MySharedPref.setString("accessToken", accessToken);
        } else {
          print(" No accessToken found in response: $jsonResponse");
        }


        return jsonResponse;
      } else {
        return null;
      }
    }

}