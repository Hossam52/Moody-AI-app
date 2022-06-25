import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/inspiration.dart';
import 'package:moody_app/presentation/resources/assets_manager.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';

class PostItem extends StatelessWidget {
  const PostItem(
      {Key? key,
      required this.index,
      required this.inspirationItem,
      required this.onToggleLike})
      : super(key: key);
  final int index;
  final Inspiration inspirationItem;
  final VoidCallback onToggleLike;
  isPostLikedByMe(BuildContext context) {
    final user = AppCubit.get(context).getUser;
    return user.containsInLikes(inspirationItem.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 3.h),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  navigateToProfile(context, inspirationItem.userId);
                },
                child: CircleAvatar(
                  backgroundImage: const AssetImage(AssetsManager.avater),
                  radius: 25.w,
                  // child: Image.asset(
                  //   AssetsManager.avater,
                  //   height: 120.h,
                  //   width: 120.w,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inspirationItem.userName,
                      style: StyleManager.primaryTextStyle(
                          fontSize: FontSize.s19,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.white),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            formatStringDate(inspirationItem.date),
                            style: StyleManager.primaryTextStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.semiBold,
                                color: ColorManager.textPost),
                          ),
                        ),
                        Text(
                          'feel with ' + inspirationItem.mood,
                          style: StyleManager.primaryTextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.textPost),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(child: Container()),
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.grey.shade900,
                child: FittedBox(
                  child: Text(
                    index.toString(),
                    style: StyleManager.primaryTextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              inspirationItem.text,
              // 'Two things are infinite the universe and human stupidity and I\'m not sure about the universe.',
              textAlign: TextAlign.start,

              style: StyleManager.primaryTextStyle(
                  fontSize: FontSize.s17,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.white),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            height: 1.5.h,
            color: ColorManager.grey,
            thickness: 1.5,
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: InkWell(
              onTap: () {
                onToggleLike();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPostLikedByMe(context)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      size: 25.sp,
                      color: ColorManager.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      inspirationItem.likes.toString(),
                      // '30K',
                      style: StyleManager.primaryTextStyle(
                          fontSize: FontSize.s19,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(
          color: ColorManager.grey,
        ),
        gradient: LinearGradient(
            colors: [ColorManager.black, ColorManager.blackPosts],
            begin: Alignment.topRight,
            end: Alignment.bottomRight),
        color: ColorManager.blackPosts,
      ),
    );
  }
}
