import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/song.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:moody_app/widgets/cached_network_image.dart';

class BestSongItem extends StatelessWidget {
  const BestSongItem({Key? key, required this.song}) : super(key: key);
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.4.sw,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: ColorManager.blackPosts,
      ),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CachedNetworkImageWidget(
                      imageUrl: song.imageUrl,
                      width: double.infinity,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  song.singer,
                  style: StyleManager.primaryTextStyle(
                      fontSize: FontSize.s18,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.white),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  song.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: StyleManager.primaryTextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.grey),
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: ColorManager.blackPosts,
            radius: 20.r,
            child: InkWell(
                onTap: () => song.addToFavourite(),
                child: Icon(Icons.favorite,
                    size: AppSizes.iconSize25,
                    color: song.isFav ? Colors.red : ColorManager.white)),
          )
        ],
      ),
    );
  }
}
