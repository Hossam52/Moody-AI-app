import 'package:flutter/material.dart';
import 'package:moody_app/domain/models/song.dart';
import 'package:moody_app/modules/home/music_screen/music_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class FavSongs extends StatelessWidget {
  const FavSongs({Key? key, required this.songs}) : super(key: key);
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return songs.isEmpty
        ? Center(
            child: Text(
              'No favourite songs untill now',
              style: StyleManager.primaryTextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.medium,
                  color: Colors.white),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
            itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  await launchUrl(Uri.parse(songs[index].url));
                },
                child: MusicItem(
                  song: songs[index],
                )),
            separatorBuilder: (context, index) => Divider(
              height: 16.h,
              color: ColorManager.white,
            ),
            itemCount: songs.length,
          );
  }
}
