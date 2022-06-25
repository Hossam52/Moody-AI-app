import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moody_app/modules/auth/register/register_screen.dart';
import 'package:moody_app/modules/detect_mode_screen/detect_mode_screen.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/navigation_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/presentation/resources/validation_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_states.dart';
import 'package:moody_app/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:moody_app/widgets/default_text_button.dart';
import 'package:moody_app/widgets/default_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: Builder(builder: (context) {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.only(top: 15.h, left: 24.w, right: 24.w),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: StyleManager.primaryTextStyle(
                                fontSize: FontSize.s24,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Let’s Sign you in.',
                            style: StyleManager.primaryTextStyle(
                                fontSize: FontSize.s20,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      BlocProvider(
                        create: (context) => HelperCubit(),
                        child: BlocBuilder<HelperCubit, HelperState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                DefaultTextField(
                                  hintText: 'user@example.com',
                                  labelText: 'E-mail',
                                  type: TextInputType.emailAddress,
                                  controller: emailController,
                                  validator: (value) =>
                                      ValidationManager.emailValidation(value),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                DefaultTextField(
                                  hintText: 'Password',
                                  type: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  validator: (value) =>
                                      ValidationManager.passwordValidation(
                                          value),
                                  isPassword:
                                      HelperCubit.get(context).isPassword,
                                  action: TextInputAction.done,
                                  suffix: InkWell(
                                    onTap: () {
                                      HelperCubit.get(context).togglePassword();
                                    },
                                    child: Icon(
                                      HelperCubit.get(context).isPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value:
                                          HelperCubit.get(context).rememberMe,
                                      onChanged: (value) {
                                        HelperCubit.get(context)
                                            .toggleRememberMe(value!);
                                      },
                                      fillColor: MaterialStateProperty.all(
                                          ColorManager.grey),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'Remember Me',
                                      style: StyleManager.primaryTextStyle(
                                          fontSize: FontSize.s14,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.white),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 0.2.sh,
                      ),
                      Row(
                        children: [
                          Text(
                            'Don\'t have an account',
                            style: StyleManager.primaryTextStyle(
                                fontSize: FontSize.s18,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.grey),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(
                                  context,
                                  RegisterScreen(
                                    helperCubitContext: context,
                                  ));
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: FontSize.s19,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  color: ColorManager.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: AuthBlocConsumer(
                          listener: (old, state) {
                            if (state is LoginErrorState) {
                              showSnackBar(context: context, text: state.error);
                            }
                            if (state is LoginSuccessState) {
                              showSnackBar(
                                context: context,
                                text: 'Login success',
                                backgroundColor: ColorManager.successColor,
                              );
                              AppCubit.get(context).setUserAccount = state.user;
                              navigateAndFinish(context, DetectModeScreen());
                            }
                          },
                          builder: (_, state) {
                            if (state is LoginLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return DefaultTextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit.instance(context).login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                colorButton: ColorManager.white,
                                title: 'Login');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        }),
      ),
    );
  }
}
