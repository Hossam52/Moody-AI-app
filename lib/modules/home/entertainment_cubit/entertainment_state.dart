part of 'entertainment_cubit.dart';

@immutable
abstract class EntertainmentState {}

class EntertainmentInitial extends EntertainmentState {}
class EntertainmentLoading extends EntertainmentState {}
class EntertainmentSuccess extends EntertainmentState {}
class EntertainmentError extends EntertainmentState {}

