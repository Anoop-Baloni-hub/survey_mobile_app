import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';
import 'common_flex.dart';

class CommonRadioButton<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String label;
  final Color activeColor;

  const CommonRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label = '',
    this.activeColor = Colors.blue,
  });

  @override
  _CommonRadioButtonState<T> createState() => _CommonRadioButtonState<T>();
}

class _CommonRadioButtonState<T> extends State<CommonRadioButton<T>> {
  @override
  Widget build(BuildContext context) {
    return sizedBox(
      height: 30.h,
      child: GestureDetector(
        onTap: () {
          widget.onChanged(widget.value);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<T>(
              value: widget.value,
              groupValue: widget.groupValue,
              onChanged: (T? newValue) {
                widget.onChanged(newValue as T);
              },
              activeColor: AppColor.primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity(
                horizontal: VisualDensity.compact.horizontal,
                vertical: VisualDensity.minimumDensity,
              ),
            ),
            if (widget.label.isNotEmpty)
              Text(widget.label, style: AppTextStyle.regular14(AppColor.blackColor)),
          ],
        ),
      ),
    );
  }
}