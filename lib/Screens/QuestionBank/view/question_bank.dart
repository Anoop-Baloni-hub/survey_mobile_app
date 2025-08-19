



import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:survey_app/Screens/QuestionBank/controllers/questionBank_controller.dart';

import '../../../common/common_appbar.dart';
import '../../../common/common_drawer.dart';
import '../../../nav/app_pages.dart';
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