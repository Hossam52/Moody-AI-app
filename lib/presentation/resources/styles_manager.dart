// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mimic/presentation/resourses/font_manager.dart';

import 'package:flutter/cupertino.dart';

class StyleManager 
{
 static TextStyle primaryTextStyle(
          {required double fontSize,
          required FontWeight fontWeight,
          required Color color}) =>
      TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        
      );
}

// TextStyle _getTextStyle(
//     double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
//   return TextStyle(
//       fontFamily: fontFamily,
//       fontSize: fontSize.sp,
//       fontWeight: fontWeight,
//       color: color);
// }

// // regular style
// TextStyle getRegularStyle(
//     {double? fontSize, Color color = Colors.black}) {
//   return _getTextStyle(
//       fontSize??FontSize.s12, FontConstants.fontFamily, FontWeightManager.regular, color);
// }

// // light style
// TextStyle getLightStyle(
//     {double? fontSize, Color color = Colors.black}) {
//   return _getTextStyle(
//       fontSize??FontSize.s12, FontConstants.fontFamily, FontWeightManager.light, color);
// }

// // Bold style
// TextStyle getBoldStyle(
//     {double? fontSize , Color color = Colors.black}) {
//   return _getTextStyle(
//       fontSize??FontSize.s12, FontConstants.fontFamily, FontWeightManager.bold, color);
// }

// // Semi Bold style
// TextStyle getSemiBoldStyle(
//     {double? fontSize, Color color = Colors.black}) {
//   return _getTextStyle(
//       fontSize??FontSize.s12, FontConstants.fontFamily, FontWeightManager.semiBold, color);
// }

// // Medium style
// TextStyle getMediumStyle(
//     {double? fontSize , Color color = Colors.black}) {
//   return _getTextStyle(
//       fontSize??FontSize.s12, FontConstants.fontFamily, FontWeightManager.medium, color);
// }