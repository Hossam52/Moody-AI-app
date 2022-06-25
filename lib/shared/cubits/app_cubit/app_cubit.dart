import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/domain/models/user_model.dart';
import 'package:moody_app/modules/home/entertainment_screen/entertainment_screen.dart';
import 'package:moody_app/modules/home/inspiration_screen/inspiration_screen.dart';
import 'package:moody_app/modules/home/movies_screen/movies_screen.dart';
import 'package:moody_app/modules/settings/settings_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  UserModel _user = UserModel.empty();
  //Set active user
  set setUserAccount(UserModel userModel) => _user = userModel;
  UserModel get getUser => _user;
  List<Widget> screens = [
    const EntertainmentScreen(),
    const InspirationScreen(),
    const MoviesScreen(),
    const SettingScreen(),
  ];
  int initialScreen = 0;
  Widget getSelectedScreen() => screens[initialScreen];

  void changeCurrentScreen(int screenIndex) {
    initialScreen = screenIndex;
    emit(AppRebuild());
  }
}
