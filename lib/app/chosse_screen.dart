import 'package:flutter/material.dart';
import 'package:moody_app/modules/auth/login/login_screen.dart';
import 'package:moody_app/modules/home/home_layout/home_layout.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';

Widget chooseScreen() {
  //return const HomeLayout();
  if (isLogin) {
    return const HomeLayout();
  } else {
    return const LoginScreen();
  }
}
