import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../nav/app_pages.dart';
import '../utils/app_color.dart';
import '../utils/app_image.dart';
import '../utils/app_text_style.dart';
import 'common_flex.dart';
import 'package:flutter/material.dart';
Widget fillButtonWithIcon({
  required String icon,
  required String title,
  bool isExpand = true,
  double? height,
  double? width,
  Color? buttonBackgroundColor,
  Color? iconColor,
  Color? titleColor,
  Color? borderColor,
  bool enabledBorder = false,
  VoidCallback? onPressed,
}) {
  return sizedBox(
    width: isExpand ? double.infinity : width,
    height: height ?? 42,
    child: FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(buttonBackgroundColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        side: enabledBorder
            ? WidgetStateProperty.all(
                BorderSide(
                  color: borderColor ?? AppColor.borderColor,
                  width: 1.w,
                ),
              )
            : null,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 16.h,
            color: iconColor,
            width: 16.h,
          ),
          w(8),
          Text(
            title,
            style: AppTextStyle.medium14(titleColor ?? AppColor.blackColor),
          ),
        ],
      ),
    ),
  );
}

Widget fillButton({
  required String title,
  double? height,
  double? width,
  Color? buttonBackgroundColor,
  Color? titleColor,
  Color? borderColor,
  bool enabledBorder = false,
  bool isExpand = true,
  WidgetStateProperty<EdgeInsetsGeometry?>? padding,
  TextStyle? style,
  VoidCallback? onPressed,
}) {
  return sizedBox(
    width: isExpand? double.infinity: width,
    height: height ?? 42,
    child: FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(buttonBackgroundColor),
          padding: padding,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        side: enabledBorder
            ? WidgetStateProperty.all(
                BorderSide(
                  color: borderColor ?? AppColor.borderColor,
                  width: 1.w,
                ),
              )
            : null,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: style??AppTextStyle.semiBold14(titleColor ?? AppColor.blackColor,),
      ),
    ),
  );
}
Widget detailContainer({
  required String title,
  required String id,
}){
  return  Expanded(
    child: Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColor.lightGreyColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                id,
                style: AppTextStyle.semiBold14( AppColor.darkPurpleColor),
              ),
              w(10),
              Text(
                title,
                style: AppTextStyle.semiBold14(
                  AppColor.greyColor,
                ),
              ),
              h(6),
            ],
          ),
          h(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){},
                child: const Icon(Icons.edit,size: 25,color: AppColor.greyColor,),
              ),
              w(15),
              GestureDetector(
                onTap: (){},
                child: const Icon(Icons.copy,size: 25,color: AppColor.greyColor,),
              ),
              w(15),
              GestureDetector(
                onTap: (){},
                child: const Icon(Icons.delete,size: 25,color: AppColor.greyColor,),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

class ActionItemCard extends StatefulWidget {
  final String? id;
  final String? title;
  final String? text;
  final VoidCallback? onEdit;
  final VoidCallback? onCopy;
  final VoidCallback? onDelete;
  final VoidCallback? onRefresh;
  final bool isRefreshScreen;
  final String? name;
  final String? gmail;
  final List<Map<String, String>>? details;

  const ActionItemCard({
    Key? key,
     this.id,
     this.title,
     this.text,
     this.onEdit,
     this.onCopy,
     this.onDelete,
     this.onRefresh,
    this.name,
    this.gmail,
    this.details,
    this.isRefreshScreen = false
  }) : super(key: key);

  @override
  State<ActionItemCard> createState() => ActionItemCardState();
}
class ActionItemCardState extends State<ActionItemCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> actionButtons() {
      if (widget.isRefreshScreen) {
        return [
          if (widget.onRefresh != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: widget.onRefresh,
            ),
        ];
      } else {
        return [
          if (widget.onEdit != null)
            IconButton(icon: const Icon(Icons.edit), onPressed: widget.onEdit),

          if (widget.onCopy != null)
            IconButton(icon: const Icon(Icons.copy), onPressed: widget.onCopy),
          if (widget.onDelete != null)
            IconButton(icon: const Icon(Icons.delete), onPressed: widget.onDelete),
        ];
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Card(
        color: AppColor.offWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r),
        side:  BorderSide(
          color: AppColor.lightGreyColor,
          width: 1.w,
        )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.name != null) Text(widget.name!),
                  if (widget.gmail != null) Text(widget.gmail!),
                  if (widget.id != null && widget.title != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.id!,
                          style: AppTextStyle.semiBold13(AppColor.blueColor),
                        ),
                       w(8),
                        Expanded(
                          child: Text(
                            widget.title!,
                          //  maxLines: 2,
                           // overflow: TextOverflow.visible,
                            softWrap: true,
                            style: AppTextStyle.semiBold13(AppColor.greyColor),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
            // Collapsed actions
            if (!isExpanded)
              Padding(
                padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
                child: Row(children: actionButtons()),
              ),
            if (isExpanded && widget.details != null) ...[
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.details!
                      .map((detail) => DetailRow(
                    label: detail["label"] ?? "",
                    value: detail["value"] ?? "",
                  ))
                      .toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: actionButtons(),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              "$label : ",
              style:  AppTextStyle.semiBold10(AppColor.blueColor),
            ),
          ),
         spacer(),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}


class UserModel {
  final String name;
  final String email;
  final List<Map<String, String>> details;

  UserModel({
    required this.name,
    required this.email,
    required this.details,
  });
}