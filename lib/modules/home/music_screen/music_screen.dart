import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/modules/home/entertainment_screen/best_song_item.dart';
import 'package:moody_app/modules/home/music_screen/build_category_songs_item.dart';
import 'package:moody_app/modules/home/music_screen/music_item.dart';
import 'package:moody_app/modules/home/music_screen/songs_cubit/songs_cubit.dart';

import '../../../presentation/resources/color_manager.dart';
import '../../../widgets/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: -10.w,
        title: Text(
          'Music',
          maxLines: 2,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 32.sp),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: ColorManager.black,
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => SongsCubit()..getAllSongs(),
        child: BlocBuilder<SongsCubit, SongsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: SongsCubit.get(context)
                        .songsWithCategories
                        .entries
                        .map((e) => BuildCategorySongsItem(
                              category: e.key,
                              songs: e.value,
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Mix',
                      style: TextStyle(color: Colors.black54, fontSize: 22.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.r),
                      constraints:
                          BoxConstraints(maxHeight: 0.3.sh, minHeight: 0.1.sh),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorManager.blackPosts,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17.r),
                              topRight: Radius.circular(17.r))),
                      child: ListView.separated(
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {},
                            child: MusicItem(
                              song: SongsCubit.get(context).songs[index],
                            )),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8.h,
                        ),
                        itemCount: SongsCubit.get(context).songs.length,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
