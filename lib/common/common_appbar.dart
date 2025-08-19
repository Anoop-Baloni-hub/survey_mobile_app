import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_image.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final bool centerTitle;
  final double extraHeight;
  final Widget? title;
  final bool showMenu;
  final VoidCallback? onMenuTap;
  final VoidCallback? onBackTap;
  final List<Widget>? actions;
  final String? avatarAsset;
  final VoidCallback? onAvatarTap;

  const CommonAppbar({
    super.key,
    this.backgroundColor = Colors.white24,
    this.centerTitle = true,
    this.extraHeight = 15,
    this.title,
    this.showMenu = true,
    this.onMenuTap,
    this.onBackTap,
    this.actions,
    this.avatarAsset,
    this.onAvatarTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + extraHeight);

  @override
  Widget build(BuildContext context) {
    final leading = showMenu
        ? IconButton(
      icon: const Icon(Icons.menu, color: Colors.grey, size: 30),
      onPressed: onMenuTap ?? () => Scaffold.of(context).openDrawer(),
    )
        : IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.grey),
      onPressed: onBackTap ?? () => Navigator.of(context).maybePop(),
    );

    final widgets = <Widget>[
      if (actions != null) ...actions!,
      Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: InkWell(
          onTap: onAvatarTap,
          borderRadius: BorderRadius.circular(22.r),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFE9E9EF),   // light grey
            child: Image.asset(AppImage.profileImage)

          ),
        ),
      ),
    ];


    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      toolbarHeight: kToolbarHeight + extraHeight,
      leading: Builder(builder: (_) => leading),
      title: title ??
          SizedBox(
            height: 47.h,
            // replace with your logo const if available
            child: Image.asset('assets/images/rize_app.png', fit: BoxFit.contain),
          ),
      actions: widgets,
    );
  }
}
