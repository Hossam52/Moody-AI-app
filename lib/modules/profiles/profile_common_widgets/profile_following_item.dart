import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowingListItem extends StatelessWidget {
  const FollowingListItem({Key? key, required this.user}) : super(key: key);
  final FollowingPreview user;
  @override
  Widget build(BuildContext context) {
    log(user.image);
    return GestureDetector(
      onTap: () => navigateToProfile(context, user.id),
      child: Container(
        width: getWidthFraction(context, 0.3),
        decoration: BoxDecoration(
          color: ColorManager.blackPosts,
          borderRadius: BorderRadius.circular(15.r),
        ),
        padding: EdgeInsets.all(8.r),
        child: Column(
          children: [
            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(user.image == 'image2'
                        ? 'assets/images/defaultuser.png'
                        : user.image))),
            SizedBox(
              height: 3.h,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                user.name,
                style: TextStyle(color: ColorManager.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
