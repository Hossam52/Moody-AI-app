import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/app/chosse_screen.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
class MyApp extends StatelessWidget {
//named constructor
  const MyApp._internal();
  static const MyApp _app = MyApp._internal();
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
