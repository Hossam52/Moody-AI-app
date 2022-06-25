import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/domain/models/book.dart';
import 'package:moody_app/domain/models/movie.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/movies_services.dart';

import 'movies_states.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesInitial());
  static MoviesCubit get(context) => BlocProvider.of(context);
  List<Movie> movies = [];
  final MoviesServices _moviesServices = MoviesServices.instance;
  late final StreamSubscription moviesStream;
  void getAllMovies() {
    emit(MoviesLoading());
    try {
      moviesStream = _moviesServices.getAllRelatedMovies().listen((event) {
        movies = [];
        for (var movieMap in event.docs) {
          Movie movie = Movie.fromJson(movieMap.data());
          movie.firebaseId = movieMap.id;
          movies.add(movie);
        }
        emit(MoviesSuccess());
      });
    } catch (e) {
      emit(MoviesError());
      return;
    }
  }

  @override
  Future<void> close() async {
    if (moviesStream != null) {
      await moviesStream.cancel();
    }
    return super.close();
  }
//
}
