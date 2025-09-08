import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:survey_app/Screens/Campaign/Views/camaign_screen.dart';
import 'package:survey_app/Screens/Campaign/Views/create_new_survey_screen.dart';
import 'package:survey_app/Screens/Campaign/bindings/campaign_binding.dart';
import 'package:survey_app/Screens/Campaign/bindings/survey_binding.dart';
import 'package:survey_app/Screens/HomeScreens/bindings/home_binding.dart';
import 'package:survey_app/Screens/HomeScreens/view/home_page.dart';
import 'package:survey_app/Screens/QuestionBank/bindings/question_bank_binding.dart';
import 'package:survey_app/Screens/QuestionBank/view/question_bank.dart';
import 'package:survey_app/Screens/Users/Views/user_screen.dart';
import 'package:survey_app/Screens/Users/bindings/users_binding.dart';

import '../Screens/Campaign/Views/campaign_dashboard.dart';
import '../Screens/authentication/bindings/login_page_bindings.dart';
import '../Screens/authentication/view/login_page_view.dart';
import '../data/local/shared_preference/shared_preference.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => const LoginPageView(),
      binding: LoginPageBindings(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.questionBank,
      page: () => const QuestionBank(),
      binding: QuestionBankBinding(),
    ),

    GetPage(
      name: _Paths.campaign,
      page: () => const CampaignScreen(),
      binding: CampaignBinding(),
    ),
    GetPage(
      name: _Paths.users,
      page: () => const UserScreen(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: _Paths.campaignDashBoard,
      page: () => const CampaignDashboard(),
      binding: CampaignBinding(),
    ),
    GetPage(
      name: _Paths.surveyScreen,
      page: () => const CreateNewSurveyScreen(),
      binding: SurveyBinding(),
    ),
  ];
}


class AuthGuard extends GetMiddleware {
  @override
  int? priority = 0;

  @override
  RouteSettings? redirect(String? route) {
    bool? isLoggedIn = MySharedPref.getBool("isLoggedIn") ?? false;

    if (isLoggedIn && route == Routes.login) {
      return const RouteSettings(name: Routes.home);
    }

    if (!isLoggedIn && (route == Routes.home || route == Routes.dashboard)) {
      return const RouteSettings(name: Routes.login);
    }

    return null;
  }
}