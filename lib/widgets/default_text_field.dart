import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation/resources/color_manager.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.passwordWidget,
    this.icon,
    this.iconColor,
    this.maxLines = 1,
    this.prefixIcon,
    this.marginAfterEnd,
    this.labelText,
    this.enabled = true,
    this.borderRadius,
    this.type = TextInputType.text,
    this.onChange,
    this.onTap,
    this.action = TextInputAction.next,
    this.suffix,
    this.prefix,
    this.node,
    this.fillColor,
    this.textColor,
  }) : super(key: key);
  final String hintText;
  final bool isPassword;
  final TextInputAction action;
  final TextInputType type;
  final TextEditingController controller;
  final FocusNode? node;
  final String? Function(String?)? validator;
  final Widget? passwordWidget;
  final IconData? icon;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Color? iconColor;
  final int maxLines;
  final double? marginAfterEnd;
  final String? labelText;
  final bool enabled;
  final double? borderRadius;
  final Widget? suffix;
  final Color? fillColor;
  final Function? onChange;
  final Function? onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
      borderSide: BorderSide(color: ColorManager.grey),
    );
    return TextFormField(
      enabled: enabled,
      minLines: 1,
      focusNode: node,
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        }
      },
      textInputAction: action,
      keyboardType: type,
      textAlign: TextAlign.start,
      maxLines: maxLines,
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      style: TextStyle(color: textColor ?? ColorManager.white),
      decoration: InputDecoration(
        // filled: true,
        fillColor: fillColor ?? ColorManager.black,

        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        iconColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(color: ColorManager.white),

        hintText: hintText,
        //suffix: suffix,
        suffixIcon: suffix,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        errorBorder: border,
        label: _labelWidget(),
      ),
    );
  }

  Widget _labelWidget() {
    return Text(
      labelText ?? hintText,
      style: TextStyle(color: ColorManager.white),
    );
  }
}
