import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';

class DefaultSnackbar extends StatelessWidget {
  const DefaultSnackbar({Key? key,required this.text,required this.snackColor}) : super(key: key);
  final String text;
  final Color snackColor;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(text,style: StyleManager.primaryTextStyle(fontSize: FontSize.s16,
       fontWeight: FontWeightManager.medium, color: ColorManager.white),),
       backgroundColor: snackColor,
    
    );
  }
}
