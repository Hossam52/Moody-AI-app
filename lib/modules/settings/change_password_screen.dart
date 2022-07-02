import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_states.dart';
import 'package:moody_app/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:moody_app/widgets/default_text_button.dart';
import 'package:moody_app/widgets/default_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Change Password Screen'), centerTitle: true),
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
            BlocProvider(
              create: (context) => HelperCubit(),
            ),
          ],
          child: SingleChildScrollView(
              child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: BlocBuilder<HelperCubit, HelperState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DefaultTextField(
                        hintText: 'New Passwoed',
                        controller: newPassword,
                        isPassword: HelperCubit.get(context).isPassword,
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
                        validator: (password) {
                          if (password!.isEmpty) {
                            return 'Please Enter Password';
                          } else if (password.length < 6) {
                            return 'Password Very Weak';
                          } else if (newPassword.text !=
                              confirmNewPassword.text) {
                            return 'Password Mismatch';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      DefaultTextField(
                        hintText: 'Confirm New Passwoed',
                        controller: confirmNewPassword,
                        action: TextInputAction.done,
                        isPassword: HelperCubit.get(context).isPassword,
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
                        validator: (password) {
                          if (password!.isEmpty) {
                            return 'Please Enter Password';
                          } else if (password.length < 6) {
                            return 'Password Very Weak';
                          } else if (newPassword.text !=
                              confirmNewPassword.text) {
                            return 'Password Mismatch';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      BlocConsumer<AuthCubit, AuthStates>(
                        listener: (context, state) {
                          if (state is UpdateProfileDataSuccessState) {
                            showSnackBar(
                                context: context,
                                text: 'Password Changed Successfully',
                                backgroundColor: Colors.green);
                            Navigator.pop(context);
                          } else if (state is UpdateProfileDataErrorState) {
                            showSnackBar(
                                context: context,
                                text: state.error,
                                backgroundColor: Colors.red);
                          }
                        },
                        builder: (context, state) {
                          return state is UpdateProfileDataLoadingState
                              ? const LoadingWidget()
                              : DefaultTextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      AuthCubit.instance(context)
                                          .changePassword(newPassword.text);
                                    }
                                  },
                                  colorButton: Colors.white,
                                  title: 'Confirm');
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          )),
        ),
      ),
    );
  }
}
