import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';

class CommonDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final bool? isExpanded;

  const CommonDropdownButton({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = '',
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: isExpanded ?? true,
      value: items.any((item) => item.value == value) ? value : null,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: AppTextStyle.regular14(AppColor.greyPurpleColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColor.blackColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: AppColor.blackColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: AppColor.blackColor,
      ),
      dropdownColor: Colors.white,
    );
  }
}

