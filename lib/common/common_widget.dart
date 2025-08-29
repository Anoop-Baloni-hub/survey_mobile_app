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
//
// Widget appBar({
//   required String icon,
//   void Function()? onTap,
// }) {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12  .h),
//     color: AppColor.secondaryColor,
//     child: Row(
//       children: [
//         CircleAvatar(
//           backgroundColor: AppColor.primaryColor,
//           radius: 20.r,
//           backgroundImage: const AssetImage(AppImage.profileImage),
//         ),
//         w(10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Good Morning,",
//               style: AppTextStyle.regular10(AppColor.whiteColor),
//             ),
//             h(2),
//             Text(
//               "Shubham",
//               style: AppTextStyle.semiBold16(AppColor.whiteColor),
//             ),
//           ],
//         ),
//         spacer(),
//         IconButton(
//           onPressed: onTap,
//           icon: Image.asset(
//             icon,
//             height: 24.h,
//             width: 24.h,
//             color: AppColor.whiteColor,
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget profileContainer() {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
//     decoration: BoxDecoration(
//       color: AppColor.greyLightColor,
//       borderRadius: BorderRadius.circular(12.r),
//     ),
//     child: InkWell(
//       onTap: () {
//         Get.toNamed(Routes.editProfile);
//       },
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 "Your profile completion is",
//                 style: AppTextStyle.regular14(
//                   AppColor.lightPurpleColor,
//                 ),
//               ),
//               Text(
//                 " 60%",
//                 style: AppTextStyle.regular14(
//                   AppColor.lightPinkColor,
//                 ),
//               ),
//               spacer(),
//               InkWell(
//                 onTap: () {},
//                 child: Row(
//                   children: [
//                     Text(
//                       "Complete profile",
//                       style: AppTextStyle.semiBold10(
//                         AppColor.lightPurpleColor,
//                       ),
//                     ),
//                     w(6),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 10.sp,
//                       color: AppColor.primaryColor,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           h(10),
//           Container(
//             height: 8.h,
//             padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
//             decoration: BoxDecoration(
//               color: AppColor.whiteColor,
//               borderRadius: BorderRadius.circular(4.r),
//             ),
//             child: LinearProgressIndicator(
//               value: 0.6,
//               borderRadius: BorderRadius.circular(4.r),
//               backgroundColor: AppColor.whiteColor,
//               color: AppColor.lightPinkColor,
//               minHeight: 5.h,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
//
//
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
//
// PreferredSizeWidget header({
//    Function()? onTap,
//    required String title,
//    List<Widget>? actions,
//   Color? backgroundColor = AppColor.whiteColor,
//   Color? leadingIconColor = AppColor.blackColor,
//   Color titleColor = AppColor.blackColor,
//
// }) {
//   return AppBar(
//     backgroundColor: backgroundColor,
//     centerTitle: true,
//     leading: Padding(
//       padding:  EdgeInsets.only(left: 6.w),
//       child: IconButton(
//         onPressed:onTap?? () => Get.back(),
//         icon: Image.asset(
//           color: leadingIconColor,
//           AppImage.backArrowIcon,
//           height: 22.h,
//           width: 22.h,
//         ),
//       ),
//     ),
//     title: Text(
//       title,
//       style: AppTextStyle.medium16(
//         titleColor,
//       ),
//     ),
//     actions:actions,
//   );
// }
//
//
// Widget phoneNumberTextField({
//   ValueChanged<PhoneNumber>? onInputChanged,
//   required TextEditingController controller,
//   required String hintText,
//   Widget? suffixIcon,
//    String? isoCode,
// }){
//   return Container(
//     alignment: Alignment.center,
//     padding: EdgeInsets.symmetric(horizontal: 12.w),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: AppColor.borderColor,
//       ),
//       borderRadius: BorderRadius.circular(12.r),
//     ),
//     child: InternationalPhoneNumberInput(
//       spaceBetweenSelectorAndTextField: 0,
//       textAlign: TextAlign.start,
//       onInputChanged: (PhoneNumber number) => onInputChanged!(number),
//       onInputValidated: (bool isValid) {},
//       selectorConfig: const SelectorConfig(
//         selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//         showFlags: true,
//         trailingSpace: false,
//         setSelectorButtonAsPrefixIcon: true,
//       ),
//       errorMessage: "Invalid phone number",
//       validator: (val) {
//         if (val!.isEmpty) {
//           return "Please enter home phone";
//         } else if (val.length <= 10) {
//           return "Please enter valid home phone";
//         }
//         return null;
//       },
//       ignoreBlank: true,
//       autoValidateMode: AutovalidateMode.disabled,
//       selectorTextStyle:  AppTextStyle.medium14(AppColor.blackColor),
//       textStyle: AppTextStyle.regular14(AppColor.blackColor,),
//       initialValue: PhoneNumber(isoCode: isoCode?? 'US'),
//       textFieldController: controller,
//       formatInput: false,
//       keyboardType: const TextInputType.numberWithOptions(
//         signed: true,
//         decimal: true,
//       ),
//       hintText: hintText,
//       inputBorder: InputBorder.none,
//       inputDecoration: InputDecoration(
//         hintText: hintText,
//         suffixIcon: suffixIcon,
//         hintStyle: AppTextStyle.regular14(AppColor.greyPurpleColor),
//         border: InputBorder.none,
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 12.w,
//           vertical: 8.h,
//         ),
//       ),
//       onSaved: (PhoneNumber number) {},
//
//     ),
//   );
// }
//
// Widget retrieveDataButton({
//   required VoidCallback? onPressed,
// }){
//   return Row(
//     children: [
//       Image.asset(
//         AppImage.propertyBgImage,
//         height: 80.h,
//         width: 80.h,
//         fit: BoxFit.cover,
//       ),
//       w(12),
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Welcome Back!",
//               style: AppTextStyle.semiBold14(AppColor.blackColor),
//             ),
//             h(10),
//             Text(
//               "Retrieve your pre-qualification data instantly and get your loan.",
//               style: AppTextStyle.regular10(AppColor.blackColor),
//             ),
//             h(10),
//             fillButton(
//               onPressed: onPressed,
//               height: 30,
//               buttonBackgroundColor: AppColor.primaryColor,
//               title:"Retrieve my pre-qualification data",
//               style: AppTextStyle.medium10(AppColor.whiteColor),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
//
//
// Widget officerCardBox({
//   required String companyLogo,
//   required String officerName,
//   required String officerRole,
//   required String officerPhone,
//   required String officerEmail,
//   required String officerWebsite,
//   required String officerAddress,
//   required String officerImage,
//   required String fbID,
//   required String linkedInID,
//   required String twitterID,
//   required String instagramID,
// }){
//   return Container(
//     height: 180.h,
//     decoration: BoxDecoration(
//       color: AppColor.whiteColor,
//       border: Border.all(
//         color: AppColor.borderColor,
//         width: 1.w,
//       ),
//       borderRadius: BorderRadius.circular(14.r),
//     ),
//     child: Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding:  EdgeInsets.only(left: 12.w, top: 12.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset(
//                       companyLogo,
//                       height: 20.h,
//                       width: 90.w,
//                     ),
//                     h(4),
//                     Text(
//                       officerName,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                       style: AppTextStyle.bold14(
//                         AppColor.blackColor,
//                       ),
//                     ),
//                     h(4),
//                     Text(
//                       officerRole,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                       style: AppTextStyle.medium10(
//                         AppColor.darkPurpleColor,
//                       ),
//                     ),
//                     h(8),
//                     Text(
//                       officerAddress,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                       style: AppTextStyle.regular10(
//                         AppColor.darkPurpleColor,
//                       ),
//                     ),
//                     h(4),
//                     Text(
//                       officerPhone,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                       style: AppTextStyle.regular12(
//                         AppColor.primaryColor,
//                       ),
//                     ),
//                     h(4),
//                     Text(
//                       officerEmail,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                       style: AppTextStyle.regular12(
//                         AppColor.primaryColor,
//                       ),
//                     ),
//                     h(4),
//                     Text(
//                       officerWebsite,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                       style: AppTextStyle.regular12(
//                         AppColor.primaryColor,
//                       ),
//                     ),
//                     h(4),
//                     Text(
//                       "Schedule a meeting",
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                       style: AppTextStyle.regular12(
//                         AppColor.primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               spacer(),
//               ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(12.r),
//                 ),
//                 child: Image.asset(
//                   AppImage.sharingBgImage,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             children: [
//               spacer(),
//               Image.asset(
//                 AppImage.rizeImage,
//                 width: 100.h,
//                 fit: BoxFit.contain,
//               ),
//               h(2),
//               Text(
//                 "1234 MAIN ST., CITY, ST. 00000\nLENDER NMLS 1604663",
//                 textAlign: TextAlign.end,
//                 style: AppTextStyle.regular7(
//                   AppColor.blackColor,
//                 ),
//               ),
//               h(12),
//               Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Padding(
//                     padding:  EdgeInsets.only(top: 20.h),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         bottomRight: Radius.circular(12.r),
//                       ),
//                       child: Image.asset(
//                         AppImage.purpleBgImage,
//
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       w(20),
//                       Container(
//                         height: 54.h,
//                         width: 54.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.r),
//                           image:  DecorationImage(
//                             image: AssetImage(officerImage),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       w(4),
//                       Container(
//                         height: 55.h,
//                         width: 54.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.r),
//                           image: const DecorationImage(
//                             image:AssetImage(AppImage.qrImage),
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
// Widget loOfficerContainer({
//   required String companyName,
//   required String officerName,
//   required String officerRole,
//   required String officerPhone,
//   required String officerEmail,
//   required String officerWebsite,
// }) {
//   return Column(
//     children: [
//       Stack(
//         alignment: Alignment.bottomLeft,
//         children: [
//           Container(
//             height: 180.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12.r),
//               image:  const DecorationImage(
//                 image: AssetImage(AppImage.profileImage),
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: FloatingActionButton(
//               mini: true,
//               elevation: 0,
//               backgroundColor: AppColor.redColor,
//               shape: const CircleBorder(),
//               onPressed: () {},
//               child: Icon(
//                 Icons.play_arrow,
//                 size: 30.sp,
//                 color: AppColor.whiteColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//       h(10),
//       Row(
//         children: [
//           Container(
//             height: 50.h,
//             width: 50.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12.r),
//               image: const DecorationImage(
//                 image: AssetImage(AppImage.profileImage),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           w(10),
//           Expanded(
//             child: Container(
//               width: Get.width,
//               padding: EdgeInsets.symmetric(
//                 horizontal: 8.w,
//                 vertical: 8.h,
//               ),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: AppColor.greyPurpleColor.withOpacity(0.2),
//                 ),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 35.h,
//                     width: 35.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.r),
//                       image: const DecorationImage(
//                         image: AssetImage(AppImage.profileImage),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   w(10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         companyName,
//                         style: AppTextStyle.semiBold16(
//                           AppColor.blackColor,
//                         ),
//                       ),
//                       h(4),
//                       Text(
//                         officerRole,
//                         style: AppTextStyle.regular12(
//                           AppColor.greyPurpleColor.withOpacity(0.8),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       h(10),
//       Row(
//         children: [
//           Text(
//             officerName,
//             style: AppTextStyle.semiBold20(
//               AppColor.blackColor,
//             ),
//           ),
//           w(10),
//           Image.asset(
//             AppImage.verifiedIcon,
//             height: 20.h,
//             width: 20.w,
//           ),
//         ],
//       ),
//       h(10),
//       Row(
//         children: [
//           Image.asset(
//             AppImage.roleIcon,
//             color: AppColor.blackColor,
//             height: 16.h,
//             width: 16.h,
//           ),
//           w(6),
//           Text(
//             officerRole,
//             style: AppTextStyle.regular12(
//               AppColor.greyPurpleColor.withOpacity(0.8),
//             ),
//           ),
//           w(10),
//           Image.asset(
//             AppImage.callIcon,
//             color: AppColor.blackColor,
//             height: 14.h,
//             width: 14.h,
//           ),
//           w(4),
//           Text(
//             officerPhone,
//             style: AppTextStyle.regular12(
//               AppColor.greyPurpleColor.withOpacity(0.8),
//             ),
//           ),
//         ],
//       ),
//       h(10),
//       Row(
//         children: [
//           Image.asset(
//             AppImage.mailIcon,
//             color: AppColor.blackColor,
//             height: 16.h,
//             width: 16.h,
//           ),
//           w(6),
//           Text(
//             officerEmail,
//             style: AppTextStyle.regular12(
//               AppColor.greyPurpleColor.withOpacity(0.8),
//             ),
//           ),
//         ],
//       ),
//       h(10),
//       Row(
//         children: [
//           Image.asset(
//             AppImage.globalIcon,
//             height: 16.h,
//             color: AppColor.blackColor,
//             width: 16.h,
//           ),
//           w(6),
//           Text(
//             officerWebsite,
//             style: AppTextStyle.regular12(
//               AppColor.greyPurpleColor.withOpacity(0.8),
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }
//
// borrowerDetailsContainerBox({
//   required String title,
//   required String count,
//   required Color boxColor,
//   required Color color,
//   required String image,
// }) {
//   return Expanded(
//     child: Container(
//       padding: EdgeInsets.all(12.r),
//       decoration: BoxDecoration(
//         color: boxColor,
//         borderRadius: BorderRadius.circular(14.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 count,
//                 style: AppTextStyle.semiBold24(color),
//               ),
//               Image.asset(
//                 image,
//                 color: color,
//                 height: 20.h,
//                 width: 20.w,
//               ),
//             ],
//           ),
//           h(10),
//           Text(
//             title,
//             overflow: TextOverflow.ellipsis,
//             maxLines: 2,
//             style: AppTextStyle.regular12(color),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
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
            // Expanded details + actions
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