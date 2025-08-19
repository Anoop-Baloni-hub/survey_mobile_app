import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_app/utils/app_color.dart';
import 'package:survey_app/utils/app_text_style.dart';

import 'common_flex.dart';

class DrawerItem {
  final String label;
  final Widget leading;
  final String? route;
  final VoidCallback? onTap;

  const DrawerItem({
    required this.label,
    required this.leading,
    this.route,
    this.onTap,
  });
}

class CommonDrawer extends StatelessWidget {
  final List<DrawerItem> items;
  final String? selectedRoute;
  final int defaultSelectedIndex;
  final Widget? header;
  final VoidCallback? onLogout;
  final double width;

  const CommonDrawer({
    super.key,
    required this.items,
    this.selectedRoute,
    this.defaultSelectedIndex = 0,
    this.header,
    this.onLogout,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context) {
    const pill = AppColor.secondaryColor;
    return Drawer(
      width: width,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            if (header != null)
              Padding(
                padding:  EdgeInsets.only(top: 20.h, bottom: 12.h),
                child: header!,
              ),
             Divider(height: 1.h, color: AppColor.darkBlueColor),

            Expanded(
           child: ListView.builder(
    padding: EdgeInsets.symmetric(vertical: 16.h),
    itemCount: items.length,
    itemBuilder: (context, i) {
    final e = items[i];

    final byRoute = (e.route != null && e.route == selectedRoute);
    final byIndex = (selectedRoute == null && i == defaultSelectedIndex);
    final selected = byRoute || byIndex;
    final bg = selected ? pill : AppColor.transparentColor;
    final fg = selected ? Colors.white : Colors.black87;

    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    child: InkWell(
    borderRadius: BorderRadius.circular(12.r),
    onTap: () {
   // Navigator.of(context).maybePop();
      Navigator.of(context).pop();
      if (e.onTap != null) {
        e.onTap!();
        return;
      }
      if (e.route != null && e.route!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(e.route!);
          // or:
          // Navigator.of(context).pushReplacementNamed(e.route!);
          // Navigator.of(context).pushNamedAndRemoveUntil(e.route!, (r) => false);
        });
      }
    },
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
    decoration: BoxDecoration(
    color: bg,
    borderRadius: BorderRadius.circular(12.r),
    ),
    child: Row(
    children: [
    IconTheme.merge(
    data: IconThemeData(color: fg),
    child: e.leading,
    ),
      w(12),
    Text(e.label, style: AppTextStyle.medium14(fg)),
    ]))),
        );})
            ),

            if (onLogout != null)
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 30.w),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.of(context).maybePop();
                    onLogout!.call();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.logout_outlined, color: Colors.black54),
                      w(12),
                       Text('Logout', style: TextStyle(fontSize: 16.sp)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
