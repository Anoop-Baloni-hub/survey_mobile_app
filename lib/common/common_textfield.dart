import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';


class CustomTextInput extends StatefulWidget {
  const CustomTextInput({
    super.key,
    required this.textEditController,
    this.hintTextString,
    this.inputType,
    this.enableBorder = true,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.maxLines = 1,
    this.borderColor,
    this.cursorColor,
    this.cornerRadius,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.autoValidateMode,
    this.borderType,
    this.validator,
    this.textColor,
    this.contentPadding,
    this.isDense,
    this.errorMessage,
    this.prefix,
    this.suffix,
    this.fillColor,
    this.filled,
    this.labelText,
    this.enabled,
    this.prefixIconColor,
    this.suffixIconColor,
    this.onTap,
    this.onEditingComplete,
    this.onChanged,
  });

  // ignore: prefer_typing_uninitialized_variables
  final String? hintTextString;
  final TextEditingController textEditController;
  final InputType? inputType;
  final BorderType? borderType;
  final bool enableBorder;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final double? cornerRadius;
  final bool readOnly;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enabled;
  final TextAlign textAlign;
  final Color? textColor;
  final String? errorMessage;
  final AutovalidateMode? autoValidateMode;
  final Color? cursorColor;
  final bool? filled;
  final Color? prefixIconColor;
  final Widget? prefix;
  final Widget? suffix;
  final Color? fillColor;
  final Color? suffixIconColor;
  final String? labelText;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool _isValidate = true;
  String validationMessage = '';
  bool visibility = false;
  int oldTextSize = 0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditController,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      cursorColor: widget.cursorColor,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      decoration: InputDecoration(
        hintText: widget.hintTextString,
        hintStyle: AppTextStyle.regular14(AppColor.greyColor,),
        isDense: widget.isDense ?? false,
        contentPadding: widget.contentPadding,
        prefixIconColor: widget.prefixIconColor,
        suffixIconColor: widget.suffixIconColor,
        fillColor: widget.fillColor,
        filled: widget.filled,
        prefix: widget.prefix,
        suffix: widget.suffix,
        errorText: _isValidate ? null : validationMessage,
        counterText: '',
        border: widget.enableBorder
            ? widget.borderType == BorderType.underline
                ? underlineInputBorder()
                : outlineInputBorder()
            : InputBorder.none,
        disabledBorder: widget.enableBorder
            ? widget.borderType == BorderType.underline
                ? underlineInputBorder()
                : outlineInputBorder()
            : InputBorder.none,
        enabledBorder: widget.enableBorder
            ? widget.borderType == BorderType.underline
                ? underlineInputBorder()
                : outlineInputBorder()
            : InputBorder.none,
        errorBorder: widget.enableBorder
            ? widget.borderType == BorderType.underline
                ? underlineInputBorder()
                : outlineInputBorder()
            : InputBorder.none,
        focusedBorder: widget.enableBorder
            ? widget.borderType == BorderType.underline
                ? underlineInputBorder()
                : outlineInputBorder()
            : InputBorder.none,
        labelText: widget.labelText,
        labelStyle: getTextStyle(),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
      onChanged: widget.onChanged,
      keyboardType: getInputType(),
      obscureText: widget.inputType == InputType.password && !visibility,
      maxLength: widget.maxLength ?? getMaxLength(),
      style: AppTextStyle.medium14(AppColor.blackColor),
      inputFormatters: [
        getFormatter(),
      ],
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(widget.cornerRadius ?? 8.r)),
      borderSide: BorderSide(
        color: widget.borderColor ?? Theme.of(context).primaryColor,
      ),
    );
  }

  UnderlineInputBorder underlineInputBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: widget.borderColor ?? Theme.of(context).primaryColor,
      ),
    );
  }

  TextInputFormatter getFormatter() {
    return FilteringTextInputFormatter.singleLineFormatter;
  }

  TextStyle getTextStyle() {
    return TextStyle(
        color: widget.borderColor ?? Theme.of(context).primaryColor,
    );
  }

  void checkValidation(String textFieldValue) {
    if (widget.inputType == InputType.defaults) {
      //default
      _isValidate = textFieldValue.isNotEmpty;
      validationMessage = widget.errorMessage ?? 'Filed cannot be empty';
    } else if (widget.inputType == InputType.email) {
      //email validation
      _isValidate = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(textFieldValue);
      validationMessage = widget.errorMessage ?? 'Email is not valid';
    } else if (widget.inputType == InputType.number) {
      //contact number validation
      _isValidate = textFieldValue.length == widget.maxLength;
      validationMessage = widget.errorMessage ?? 'Contact Number is not valid';
    } else if (widget.inputType == InputType.password) {
      //password validation
      _isValidate = RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(textFieldValue);
      validationMessage = widget.errorMessage ?? 'Password is not valid';
    }
    oldTextSize = textFieldValue.length;
    //change value in state
    setState(() {});
  }

  // return input type for setting keyboard
  TextInputType getInputType() {
    switch (widget.inputType) {
      case InputType.defaults:
        return TextInputType.text;

      case InputType.email:
        return TextInputType.emailAddress;

      case InputType.number:
        return TextInputType.number;

      default:
        return TextInputType.text;
    }
  }

  // get max length of text
  int getMaxLength() {
    switch (widget.inputType) {
      case InputType.defaults:
        return 36;

      case InputType.email:
        return 36;

      case InputType.number:
        return 10;

      case InputType.password:
        return 24;

      default:
        return 36;
    }
  }
}

//input types
enum InputType { defaults, email, number, password }

//border types
enum BorderType { underline, outLine }
