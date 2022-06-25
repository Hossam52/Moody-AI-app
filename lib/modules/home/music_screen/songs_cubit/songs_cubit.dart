import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/domain/models/song.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/songs_services.dart';

part 'songs_state.dart';

class SongsCubit extends Cubit<SongsState> {
  SongsCubit() : super(SongsInitial());
  static SongsCubit get(context) => BlocProvider.of(context);
  late final StreamSubscription songsStream;
  final SongsServices _songsServices = SongsServices.instance;
  List<Song> songs = [];
  Map<String, List<Song>> songsWithCategories = {};

  Future<void> getAllSongs() async {
    emit(SongsLoading());
    try {
      songsStream = _songsServices.getAllSongs().listen((event) {
        songs = [];
        songsWithCategories = {};
        for (var book in event.docs) {
          Song songItem = Song.fromJson(book.data());
          songItem.firebaseId = book.id;
          songs.add(songItem);
          if (songsWithCategories.containsKey(songItem.category)) {
            songsWithCategories.update(songItem.category, (value) {
              value.add(songItem);
              return value;
            });
          } else {
            songsWithCategories.putIfAbsent(songItem.category, () {
              return [songItem];
            });
          }
        }
        songs.removeWhere((e)=>e.numberOfFav>4);
        emit(SongsSuccess());
      });
    } catch (e) {
      emit(SongsEror());
      return;
    }
  }

  @override
  Future<void> close() async {
    // TODO: implement close
    await songsStream.cancel();
    return super.close();
  }
}
