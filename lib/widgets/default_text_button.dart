import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';

class DefaultTextButton extends StatelessWidget {
  const DefaultTextButton({
    Key? key,
    required this.onPressed,
    required this.colorButton,
    required this.title,
    this.padding,
    this.textColor,
  }) : super(key: key);
  final Function onPressed;
  final String title;
  final Color colorButton;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Container(
        padding: padding,
        child: Text(
          title,
          style: StyleManager.primaryTextStyle(
              fontSize: FontSize.s20,
              fontWeight: FontWeight.w700,
              color: textColor ?? ColorManager.black),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorButton),
      ),
    );
  }
}
