import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:moody_app/shared/cubits/home_cubit/home_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit()..getMyProfile(context),
          lazy: false,
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            body: AppCubit.get(context).getSelectedScreen(),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: ColorManager.white,
                onTap: (index) =>
                    AppCubit.get(context).changeCurrentScreen(index),
                selectedItemColor: ColorManager.black,
                unselectedItemColor: ColorManager.grey,
                showSelectedLabels: false,
                currentIndex: AppCubit.get(context).initialScreen,
                items: [
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        Icons.home,
                        size: 30.sp,
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        Icons.feed_outlined,
                        size: 30.sp,
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        FontAwesomeIcons.film,
                        size: 30.sp,
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        Icons.menu,
                        size: 30.sp,
                      )),
                ]),
          );
        },
      ),
    );
  }
}
