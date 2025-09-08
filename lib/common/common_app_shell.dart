
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:survey_app/Screens/HomeScreens/controllers/home_controller.dart';
import 'package:survey_app/Screens/authentication/controllers/login_page_controller.dart';
import '../nav/app_pages.dart';
import 'common_appbar.dart';
import 'common_drawer.dart';
import '../utils/app_image.dart';
import '../utils/app_color.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final HomePageController controller = Get.find<HomePageController>();
  final LoginPageController logController = Get.put(LoginPageController());
  @override
  void initState() {
    super.initState();
    if (controller.selectedRoute.value.isEmpty) {
      controller.setSelectedRoute(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      key: scaffoldKey,

      // Drawer
      drawer: Obx(
            () => CommonDrawer(
          selectedRoute: controller.selectedRoute.value,
          header: SizedBox(
            height: 50.h,
            child: Image.asset(AppImage.appLogo, fit: BoxFit.contain),
          ),
          items: drawerItems(),
          onItemTap: (route) {
            controller.setSelectedRoute(route);
            Navigator.of(context).pop();

            if (Get.currentRoute != route) {
              Get.offNamed(route);
            }
          },
          onLogout: () {
            Get.put(LoginPageController()).logout();
          },
        ),
      ),

      // AppBar
      appBar: CommonAppbar(
        backgroundColor: AppColor.offWhite,
        onMenuTap: () => scaffoldKey.currentState?.openDrawer(),
        title: SizedBox(
          height: 47.h,
          child: Image.asset(AppImage.appLogo, fit: BoxFit.contain),
        ),
      ),

      // Body
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: widget.child,
      ),
    );
  }

  List<DrawerItem> drawerItems() => [
    DrawerItem(
      label: 'Dashboard',
      leading: Image.asset(AppImage.vector),
      route: Routes.home,
    ),
    DrawerItem(
      label: 'Question Bank',
      leading: Image.asset(AppImage.group),
      route: Routes.questionBank,
    ),
    DrawerItem(
      label: 'Campaign',
      leading: Image.asset(AppImage.check),
      route: Routes.campaign,
    ),
    DrawerItem(
      label: 'Users',
      leading: Image.asset(AppImage.profileCircle),
      route: Routes.users,
    ),
  ];
}



