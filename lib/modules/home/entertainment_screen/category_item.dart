import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/modules/home/entertainment_screen/category_model.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.categoryModel}) : super(key: key);
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 137.h,
      width: 167.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
              offset: Offset(0.5, 0.5),
            )
          ]),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            categoryModel.imagePath,
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: ColorManager.blackPosts.withOpacity(0.25),
          ),
          Text(
            categoryModel.name,
            style: StyleManager.primaryTextStyle(
                fontSize: FontSize.s27,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.white),
          ),
        ],
      ),
    );
  }
}
