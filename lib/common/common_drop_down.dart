import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';

class CommonDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final double height;
  final bool? isExpanded;

   const CommonDropdownButton({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = '',
    this.height = 36.0,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.borderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButton<T>(
        isExpanded: isExpanded?? false,
        underline: const SizedBox(),
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: AppColor.primaryColor,
        ),
        hint: Text(
          hintText,
          overflow: TextOverflow.ellipsis,
          style:  AppTextStyle.regular14(AppColor.greyPurpleColor),
        ),
        value: value,
        items: items.map((DropdownMenuItem<T> item) {
          return DropdownMenuItem<T>(
            value: item.value,
            child: Text(
              item.value.toString(),
              style: AppTextStyle.medium14(AppColor.blackColor),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}