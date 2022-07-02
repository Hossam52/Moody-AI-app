import 'dart:async';
import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/domain/models/inspiration.dart';
import 'package:moody_app/modules/home/home_screen/models/model.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/books_services.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/inspiration_services.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/movies_services.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/songs_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  final InspirationServices _inspirationServices = InspirationServices.instance;
  final SongsServices _songsServices = SongsServices.instance;
  final MoviesServices _moviesServices = MoviesServices.instance;
  final BooksServices _booksServices = BooksServices.instance;
  late StreamSubscription _inspirationStream;
  late StreamSubscription _movieStream;
  late StreamSubscription _songsStream;
  late StreamSubscription _booksStream;

  Inspiration? inspiration;
  Set<SimpleModel> generalData = {};

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      _inspirationStream = _inspirationServices.getTopPost().listen((event) {
        inspiration = Inspiration.fromMap(event.docs.first.data());
        emit(HomeSuccess());
      });
      SimpleModel _simpleModel;
      _songsStream = _songsServices.getBestSongs().listen((event) {
        for (var doc in event.docs) {
          _simpleModel = SimpleModel.fromJson(doc.data());

          generalData.add(_simpleModel);
        }
        emit(HomeSuccess());
      });
      _movieStream = _moviesServices.getBestMovies().listen((event) {
        for (var doc in event.docs) {
          _simpleModel = SimpleModel.fromJson(doc.data());
          generalData.add(_simpleModel);
        }
        emit(HomeSuccess());
      });
      _booksStream = _booksServices.getBestBooks().listen((event) {
        for (var doc in event.docs) {
          _simpleModel = SimpleModel.fromJson(doc.data());
          generalData.add(_simpleModel);
        }
        log(generalData.length.toString());
        emit(HomeSuccess());
      });
    } catch (e) {
      emit(HomeError());
      rethrow;
    }
  }

  @override
  Future<void> close() async{
    await _inspirationStream.cancel();
   await _movieStream.cancel();
   await  _songsStream.cancel();
   await _booksStream.cancel();
    // TODO: implement close
    return super.close();
  }
}
