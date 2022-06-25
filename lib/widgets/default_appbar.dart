import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';

AppBar defultAppBar({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: StyleManager.primaryTextStyle(
          fontSize: FontSize.s18,
          fontWeight: FontWeightManager.semiBold,
          color: ColorManager.white),
    ),
    backgroundColor: ColorManager.black,
  );
}
