import 'dart:async';

import 'package:meta/meta.dart';
import 'package:moody_app/domain/models/book.dart';
import 'package:moody_app/domain/models/movie.dart';
import 'package:moody_app/domain/models/song.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/books_services.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/movies_services.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/songs_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());
  static FavCubit get(context) => BlocProvider.of(context);
  final BooksServices _booksServices = BooksServices.instance;
  final SongsServices _songsServices = SongsServices.instance;
  final MoviesServices _moviesServices = MoviesServices.instance;
  late StreamSubscription _booksStream;
  late StreamSubscription _songsStream;
  late StreamSubscription _moviesStream;

  List<Book> books = [];
  List<Song> songs = [];
  List<Movie> movies = [];

  Future<void> getAllFav() async {
    emit(FavLoading());
    try {
      _booksStream = _booksServices.getAllBooksFav().listen((event) {
        books = [];
        for (var book in event.docs) {
          Book bookItem = Book.fromJson(book.data());
          bookItem.firebaseId = book.id;
          if (bookItem.isFav) {
            books.add(bookItem);
          }
        }
        emit(FavSuccess());
      });
      _songsStream = _songsServices.getAllSongsFav().listen((event) {
        songs = [];
        for (var song in event.docs) {
          Song _song = Song.fromJson(song.data());
          _song.firebaseId = song.id;
          if (_song.isFav) {
            songs.add(_song);
          }
        }
        emit(FavSuccess());
      });
      _moviesStream = _moviesServices.getAllMoviesFav().listen((event) {
        movies = [];
        for (var movie in event.docs) {
          Movie _movie = Movie.fromJson(movie.data());
          _movie.firebaseId = movie.id;
          if (_movie.isFav) {
            movies.add(_movie);
          }
        }
        emit(FavSuccess());
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> close() async {
    await _moviesStream.cancel();
    await _booksStream.cancel();
    await _songsStream.cancel();
    return super.close();
  }
}
