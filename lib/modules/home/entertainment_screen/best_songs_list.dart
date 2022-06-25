import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/song.dart';
import 'package:moody_app/modules/home/entertainment_screen/best_song_item.dart';
import 'package:moody_app/presentation/resources/strings_manager.dart';

class BestSongsList extends StatelessWidget {
  const BestSongsList({Key? key, required this.songs}) : super(key: key);
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return songs.isEmpty
        ? Center(
            child: Text(StringsManager.noRecommandedMusic),
          )
        : SizedBox(
            height: 0.3.sh,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => BestSongItem(song: songs[index]),
              separatorBuilder: (context, index) => SizedBox(
                width: 10.w,
              ),
              itemCount: songs.length,
            ),
          );
  }
}
