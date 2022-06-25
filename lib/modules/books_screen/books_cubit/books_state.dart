part of 'books_cubit.dart';

@immutable
abstract class BooksState {}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksSuccess extends BooksState {
 
}
class BooksToggleFav extends BooksState {
}

class BooksError extends BooksState {}
