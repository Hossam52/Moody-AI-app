import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'helper_state.dart';

class HelperCubit extends Cubit<HelperState> {
  HelperCubit() : super(HelperInitial());
  bool isPassword = true;
  bool rememberMe = false;
  static HelperCubit get(context) => BlocProvider.of(context);
  void togglePassword() {
    isPassword = !isPassword;
    emit(HelperRebuild());
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
    emit(HelperRebuild());
  }

  void rebuild() {
    emit(HelperRebuild());
  }
}
