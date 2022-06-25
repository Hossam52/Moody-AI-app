import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/song.dart';
import 'package:moody_app/modules/home/entertainment_screen/best_song_item.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';

class BuildCategorySongsItem extends StatelessWidget {
  const BuildCategorySongsItem(
      {Key? key, required this.category, required this.songs})
      : super(key: key);
  final String category;
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 15.w),
          child: Text(
            category,
            style: TextStyle(color: Colors.black54, fontSize: FontSize.s22),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 5.w),
          width: double.infinity,
          height: 190.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => BestSongItem(
              song: songs[index],
            ),
            separatorBuilder: (context, index) => SizedBox(width: 15.w),
            itemCount: songs.length,
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
