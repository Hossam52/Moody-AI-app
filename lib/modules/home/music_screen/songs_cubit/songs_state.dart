part of 'songs_cubit.dart';

@immutable
abstract class SongsState {}

class SongsInitial extends SongsState {}
class SongsLoading extends SongsState {}
class SongsSuccess extends SongsState {}
class SongsEror extends SongsState {}

