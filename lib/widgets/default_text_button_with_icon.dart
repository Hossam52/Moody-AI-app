import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DefaultTextButtonWithIcon extends StatelessWidget {
  DefaultTextButtonWithIcon({
    Key? key,
    required this.onPressed,
    required this.colorButton,
    required this.title,
    required this.iconData,
    this.iconColor,
    this.textColor,
    this.padding,
  }) : super(key: key);
  final Function onPressed;
  final String title;
  final Color colorButton;
  final IconData iconData;
  Color? iconColor;
  Color? textColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => onPressed(),
      icon: Icon(
        iconData,
        size: 25.sp,
        color: iconColor ?? ColorManager.white,
      ),
      label: Text(
        title,
        style: StyleManager.primaryTextStyle(
            fontSize: FontSize.s19,
            fontWeight: FontWeightManager.regular,
            color: textColor ?? ColorManager.black),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colorButton),
          padding: MaterialStateProperty.all(padding)),
    );
  }
}
