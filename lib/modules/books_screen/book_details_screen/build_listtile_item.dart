import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';

class BuildListTileItem extends StatelessWidget {
  const BuildListTileItem(
      {Key? key, required this.authorName, required this.iconData})
      : super(key: key);
  final String authorName;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: AppSizes.iconSize25,
          color: ColorManager.grey,
        ),
        SizedBox(
          width: AppSizes.sizew20,
        ),
        Text(
          authorName,
          style: StyleManager.primaryTextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.grey),
        ),
      ],
    );
  }
}
