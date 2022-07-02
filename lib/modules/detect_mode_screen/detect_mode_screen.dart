import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moody_app/modules/auth/login/login_screen.dart';
import 'package:moody_app/modules/detect_mode_screen/cubit/detect_mode_cubit.dart';
import 'package:moody_app/modules/home/home_layout/home_layout.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/navigation_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:moody_app/shared/network/locale/cache_helper.dart';
import 'package:moody_app/widgets/default_text_button.dart';
import 'package:moody_app/widgets/loading_widget.dart';

// ignore: must_be_immutable
class DetectModeScreen extends StatelessWidget {
  DetectModeScreen({Key? key, this.isHome = false}) : super(key: key);
  File? image;
  bool isHome;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                CacheHelper.removeData(key: 'login');
                navigateAndFinish(context, const LoginScreen());
              },
              icon: const Icon(Icons.logout_outlined)),
        ],
      ),
      body: BlocProvider(
        create: (context) => HelperCubit(),
        child: BlocBuilder<HelperCubit, HelperState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Let\'s get to know your mode',
                      style: StyleManager.primaryTextStyle(
                          fontSize: FontSize.s20,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      image = await getImage();
                      if (image != null) HelperCubit.get(context).rebuild();
                    },
                    focusColor: Colors.teal,
                    child: SizedBox(
                      width: 170.w,
                      child: Stack(children: [
                        SizedBox(
                          height: 170.h,
                          width: 170.w,
                        ),
                        Container(
                          clipBehavior: Clip.antiAlias,
                          height: 150.h,
                          width: 150.w,
                          child: image != null
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )
                              : Opacity(
                                  opacity: 0.8,
                                  child: Image.asset(
                                    'assets/images/3328841.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        Positioned(
                          bottom: 3.h,
                          right: 3.w,
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorManager.white,
                              ),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: ColorManager.black,
                              size: AppSizes.iconSize25,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: BlocProvider(
                      create: (context) => DetectModeCubit(),
                      child: BlocConsumer<DetectModeCubit, DetectModeState>(
                        listener: (context, state) {
                          if (state is DetectModeSuccess) {
                            showSnackBar(
                              context: context,
                              text: state.mode,
                              backgroundColor: ColorManager.successColor,
                            );

                            //Navigator.pop(context);
                            if (isHome) 
                            {
                              AppCubit.get(context).changeCurrentScreen(0);
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeLayout(),
                                ));
                          }
                        },
                        builder: (context, state) {
                          return state is DetectModeLoading
                              ? const LoadingWidget()
                              : DefaultTextButton(
                                  onPressed: () {
                                    if (image != null) {
                                      DetectModeCubit.get(context)
                                          .detectMode(image!);
                                    } else {
                                      showSnackBar(
                                          context: context,
                                          text:
                                              'Please Enter Your Image To Detct Your Mode',
                                          backgroundColor: Colors.red);
                                    }
                                  },
                                  colorButton: ColorManager.white,
                                  title: 'Go');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
