import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/domain/models/book.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/books_services.dart';
part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(BooksInitial());
  static BooksCubit get(context) => BlocProvider.of(context);
  final BooksServices _booksServices = BooksServices.instance;
  List<Book> books = [];
  late final StreamSubscription booksStream;
  Future<void> getRelatedBooks() async {
    emit(BooksLoading());
    try {
      booksStream = _booksServices.getAllBooks().listen((event) {
        books = [];
        //log(event.docs);
        for (var book in event.docs) {
          Book bookItem = Book.fromJson(book.data());
          bookItem.firebaseId = book.id;
          books.add(bookItem);
        }
        emit(BooksSuccess());
      });
    } catch (e) {
      emit(BooksError());
      return;
    }
  }

  @override
  Future<void> close() async {
    await booksStream.cancel();
    return super.close();
  }
  // Future<void> toggleFav(String bookId, int indexBook) async {
  //   try {
  //     books[indexBook].addToFavourite();
  //     log(books[indexBook].usersFav);
  //     //_booksServices.updateOnBook(bookId, books[indexBook].usersFav);
  //     //  emit(BooksToggleFav());
  //   } catch (e)
  //   {
  //     books[indexBook].addToFavourite();
  //     //books[indexBook]
  //     //emit(BooksToggleFav());
  //     return;
  //   }
  // }
}
