import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../presentation/resources/color_manager.dart';

class StoreCategoryItem extends StatelessWidget {
  const StoreCategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: 130.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/tools.jpg',
            fit: BoxFit.cover,
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.grey.withOpacity(0.7),
            colorBlendMode: BlendMode.modulate,
          ),
          Text('Clothes',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.white))
        ],
      ),
    );
  }
}
