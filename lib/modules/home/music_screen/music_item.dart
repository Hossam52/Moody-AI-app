import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/song.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import '../../../widgets/cached_network_image.dart';

class MusicItem extends StatelessWidget {
  const MusicItem({Key? key, required this.song}) : super(key: key);
  final Song song;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      width: double.infinity,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 70.h,
              child: CachedNetworkImageWidget(
                imageUrl: song.imageUrl,
                width: 60.w,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  song.singer,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            song.duration,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          InkWell(
              onTap: () => song.addToFavourite(),
              child: Icon(Icons.favorite,
                  size: AppSizes.iconSize25,
                  color: song.isFav ? Colors.red : ColorManager.white)),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
