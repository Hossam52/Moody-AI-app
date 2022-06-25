import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moody_app/domain/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/domain/models/song.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/books_services.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/songs_services.dart';
part 'entertainment_state.dart';

class EntertainmentCubit extends Cubit<EntertainmentState> {
  EntertainmentCubit() : super(EntertainmentInitial());
  static EntertainmentCubit get(context) => BlocProvider.of(context);
  List<Book> books = [];
  List<Song> songs = [];
  final BooksServices _booksServices = BooksServices.instance;
  final SongsServices _songsServices = SongsServices.instance;

  late StreamSubscription bestBooks;
  late StreamSubscription bestsongs;
  bool loadingBooks = false;
  bool loadingSongs = false;
  Future<void> getEntertainmentData() async {
    emit(EntertainmentLoading());
    try {
      bestBooks = _booksServices.getBestBooks().listen((event) {
        log(event.size.toString());
        books = [];
        for (var bookMap in event.docs) {
          Book book = Book.fromJson(bookMap.data());
          book.firebaseId = bookMap.id;
          books.add(book);
        }
        loadingBooks = true;
        emit(EntertainmentSuccess());
      });
      bestsongs = _songsServices.getBestSongs().listen((event) 
      {
        songs = [];
        log('songs');
        for (var songMap in event.docs) 
        {
          Song song = Song.fromJson(songMap.data());
          song.firebaseId = songMap.id;
          songs.add(song);
        }
        loadingSongs = true;
        emit(EntertainmentSuccess());
      });
    } catch (e) {
      emit(EntertainmentError());
      return;
    }
    //load Good books
    //load best songs
  }

  @override
  Future<void> close() async {
    await bestBooks.cancel();
    await bestsongs.cancel();
    return super.close();
  }
}
