import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/presentation/resources/assets_manager.dart';
part 'helper_state.dart';

class HelperCubit extends Cubit<HelperState> {
  HelperCubit() : super(HelperInitial());
  bool isPassword = true;
  bool isConfrimPassword = true;

  bool rememberMe = false;
  static HelperCubit get(context) => BlocProvider.of(context);
  void togglePassword() {
    isPassword = !isPassword;
    emit(HelperRebuild());
  }

  void toggleConfirmPassword() {
    isConfrimPassword = !isConfrimPassword;
    emit(HelperRebuild());
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
    emit(HelperRebuild());
  }

  void rebuild() {
    emit(HelperRebuild());
  }

  String selectedAvater='';
  List<String> avaters = [
    assetsPath + '1.png',
    assetsPath + '2.png',
    assetsPath + '3.png',
    assetsPath + '4.png',
    assetsPath + '5.png',
    assetsPath + '6.png',
    assetsPath + '7.png',
    assetsPath + '8.png',
  ];
}
