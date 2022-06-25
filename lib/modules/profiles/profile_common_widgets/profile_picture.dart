import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/assets_manager.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(),
          borderRadius: BorderRadius.circular(15.r)),
      child: Image.asset(
        AssetsManager.avater,
        fit: BoxFit.contain,
        width: getWidthFraction(context, 0.4),
        height: getHeightFraction(context, 0.15),
      ),
    );
  }
}
