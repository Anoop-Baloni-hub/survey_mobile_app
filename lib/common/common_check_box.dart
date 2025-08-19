import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;
  final Color activeColor;

  const CommonCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label = '',
    this.activeColor = Colors.blue,
  }) : super(key: key);

  @override
  _CommonCheckboxState createState() => _CommonCheckboxState();
}

class _CommonCheckboxState extends State<CommonCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: widget.value,
            onChanged: widget.onChanged,
            activeColor: widget.activeColor,
          ),
          if (widget.label.isNotEmpty)
            Text(widget.label, style: TextStyle(fontSize: 16.sp)),
        ],
      ),
    );
  }
}