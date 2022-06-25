part of 'detect_mode_cubit.dart';

@immutable
abstract class DetectModeState {}

class DetectModeInitial extends DetectModeState {}
class DetectModeLoading extends DetectModeState {}
class DetectModeError extends DetectModeState {}

class DetectModeSuccess extends DetectModeState {}

