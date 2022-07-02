import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/inspiration.dart';
import 'package:moody_app/presentation/resources/assets_manager.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:moody_app/widgets/cached_network_image.dart';
import 'package:like_button/like_button.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.index,
    required this.inspirationItem,
    required this.onToggleLike,
    this.canViewProfile = true,
  }) : super(key: key);
  final int index;
  final Inspiration inspirationItem;
  final VoidCallback onToggleLike;
  final bool canViewProfile;
  isPostLikedByMe(BuildContext context) {
    final user = AppCubit.get(context).getUser;
    return user.containsInLikes(inspirationItem.id!);
  }

  @override
  Widget build(BuildContext context) {
    log(inspirationItem.userPic!);
    log(isPostLikedByMe(context).toString());
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 3.h),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (canViewProfile) {
                    navigateToProfile(context, inspirationItem.userId);
                  }
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      inspirationItem.userPic == 'userPic'
                          ? AssetsManager.avater
                          : inspirationItem.userPic!),
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
                    (index).toString(),
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
          if (inspirationItem.imagePost != null)
            Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImageWidget(
                    imageUrl: inspirationItem.imagePost!,
                    width: double.maxFinite,
                  ),
                ),
              ],
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
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LikeButton(
                    onTap: ((isLiked) async {
                      onToggleLike();
                      return true;
                    }),
                    // onTap: (_) {
                    //   onToggleLike();
                    //   return isPostLikedByMe(context);
                    // },
                    size: AppSizes.iconSize30,
                    bubblesSize: 100,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    likeCountPadding: EdgeInsets.symmetric(horizontal: 3.w),
                    circleSize: AppSizes.iconSize30,
                    likeCountAnimationType: LikeCountAnimationType.all,
                    circleColor: const CircleColor(
                      start: Color(0xff00ddff),
                      end: Colors.red,
                    ),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Colors.red,
                    ),
                    isLiked: isPostLikedByMe(context),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked ? Icons.favorite : Icons.favorite_outline,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: AppSizes.iconSize30,
                      );
                    },
                    countBuilder: (count, isLiked, text) {
                      return Text(text,
                          style: StyleManager.primaryTextStyle(
                              fontSize: FontSize.s19,
                              fontWeight: FontWeightManager.medium,
                              color: ColorManager.white));
                    },
                    likeCount: inspirationItem.likes,
                  ),

                  // Icon(
                  //   isPostLikedByMe(context)
                  //       ? Icons.favorite
                  //       : Icons.favorite_outline,
                  //   size: 25.sp,
                  //   color: ColorManager.white,
                  // ),

                  // Text(
                  //   inspirationItem.likes.toString(),
                  //   // '30K',
                  //   style: StyleManager.primaryTextStyle(
                  //       fontSize: FontSize.s19,
                  //       fontWeight: FontWeightManager.medium,
                  //       color: ColorManager.white),
                  // ),
                ],
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
        gradient: linearGradient,
        color: ColorManager.blackPosts,
      ),
    );
  }
}
