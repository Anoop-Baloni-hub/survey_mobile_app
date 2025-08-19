//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../nav/app_pages.dart';
// import 'common_appbar.dart';
// import 'common_drawer.dart';
// import '../utils/app_image.dart';
// import '../utils/app_color.dart';
//
// class AppShell extends StatelessWidget {
//   final Widget child;
//   const AppShell({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     final scaffoldKey = GlobalKey<ScaffoldState>();
//
//     return Scaffold(
//       backgroundColor: AppColor.offWhite,
//       key: scaffoldKey,
//
//       // Drawer is defined ONCE here
//       drawer: CommonDrawer(
//         selectedRoute: ModalRoute.of(context)?.settings.name, // for highlight
//         header: SizedBox(
//           height: 50,
//           child: Image.asset(AppImage.appLogo, fit: BoxFit.contain),
//         ),
//         items: _drawerItems(),
//         onLogout: () { },
//       ),
//
//       // Reuse your custom appbar on every page
//       appBar: CommonAppbar(
//         backgroundColor: AppColor.offWhite,
//         onMenuTap: () => scaffoldKey.currentState?.openDrawer(),
//         title: SizedBox(height: 47.h,
//             child: Image.asset(AppImage.appLogo, fit: BoxFit.contain)),
//       ),
//
//       body: child,
//     );
//   }
//
//   // define drawer items ONCE
//   List<DrawerItem> _drawerItems() => [
//     DrawerItem(label: 'DashBoard',
//         leading: Image.asset(AppImage.vector), route: Routes.home),
//     DrawerItem(label: 'Question Bank',
//         leading: Image.asset(AppImage.group), route: Routes.questionBank),
//     DrawerItem(label: 'Campaign',
//         leading: Image.asset(AppImage.check), route: Routes.home),
//     DrawerItem(label: 'Users',
//         leading: Image.asset(AppImage.profileCircle), route: Routes.home),
//   ];
// }
