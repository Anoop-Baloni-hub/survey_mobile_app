import 'package:get/get.dart';
import 'package:survey_app/Screens/HomeScreens/bindings/home_binding.dart';
import 'package:survey_app/Screens/HomeScreens/view/home_page.dart';
import 'package:survey_app/Screens/QuestionBank/bindings/question_bank_binding.dart';
import 'package:survey_app/Screens/QuestionBank/view/question_bank.dart';

import '../Screens/authentication/bindings/login_page_bindings.dart';
import '../Screens/authentication/view/login_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => const LoginPageView(),
      binding: LoginPageBindings(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.questionBank,
      page: () => const QuestionBank(),
      binding: QuestionBankBinding(),
    ),


    // GetPage(
    //   name: _Paths.home,
    //   page: () => const AppShell(child: HomePageView()),
    //   binding: HomePageBinding(),
    // ),
    // GetPage(
    //   name: _Paths.questionBank,
    //   page:() => const AppShell(child: QuestionBank()),
    //   binding: QuestionBankBinding(),
    // ),
  ];
}
