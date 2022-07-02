import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moody_app/domain/enums/emotions.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';
import 'package:moody_app/shared/cubits/bloc_observer.dart';
import 'package:moody_app/shared/network/locale/cache_helper.dart';
import 'app/myapp.dart';
import 'package:bloc/bloc.dart';

import 'shared/helper/helper_constants.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(),
    CacheHelper.init(),
  ]);
  HttpOverrides.global = MyHttpOverrides();
  isLogin = CacheHelper.getDate(key: 'login') ?? false;
  if (isLogin) {
    HelperConstants.userId = CacheHelper.getDate(key: 'uid');
  }
  myMood = CacheHelper.getDate(key: moodKey) ?? emotions.neutral.name;
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: CustomBlocObserver(),
  );
}
