import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/song.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import '../../../widgets/cached_network_image.dart';
import 'package:like_button/like_button.dart';

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
          LikeButton(
            onTap: (_) async {
              song.addToFavourite();
              return true;
            },
            size: AppSizes.iconSize25,
            bubblesSize: 100,
            circleSize: AppSizes.iconSize25,
            likeCountAnimationType: LikeCountAnimationType.all,
            circleColor: const CircleColor(
              start: Color(0xff00ddff),
              end: Colors.red,
            ),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: Color(0xff33b5e5),
              dotSecondaryColor: Colors.red,
            ),
            isLiked: song.isFav,
            likeBuilder: (bool isLiked) {
              return Icon(
                Icons.favorite,
                color: isLiked ? Colors.red : Colors.white,
                size: AppSizes.iconSize25,
              );
            },
            countBuilder: (count, isLiked, text) {
              return const SizedBox();
            },
            likeCount: 0,
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
