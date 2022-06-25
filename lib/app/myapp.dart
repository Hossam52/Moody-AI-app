import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/app/chosse_screen.dart';
import 'package:moody_app/modules/auth/login/login_screen.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:device_preview/device_preview.dart';

class MyApp extends StatelessWidget {
//named constructor
  MyApp._internal();
  static final MyApp _app = MyApp._internal();
  factory MyApp() => _app;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => BlocProvider(
        create: (context) => AppCubit(),
        child: MaterialApp(
         
          debugShowCheckedModeBanner: false,
          title: 'Moody',
          theme: ThemeData(
            scaffoldBackgroundColor: ColorManager.black,
            appBarTheme: AppBarTheme(
              backgroundColor: ColorManager.black,
            ),
            primarySwatch: Colors.blue,
          ),
          home: chooseScreen(),
        ),
      ),
    );
  }
}
