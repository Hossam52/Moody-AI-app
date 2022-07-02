part of 'fav_cubit.dart';

@immutable
abstract class FavState {}

class FavInitial extends FavState {}
class FavLoading extends FavState {}
class FavSuccess extends FavState {}
class FavError extends FavState {}

