import 'package:flutter/material.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/presentation/resources/validation_manager.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_states.dart';
import 'package:moody_app/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:moody_app/widgets/default_text_button.dart';
import 'package:moody_app/widgets/default_text_button_with_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moody_app/widgets/default_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatelessWidget {
  final BuildContext helperCubitContext;
  RegisterScreen({Key? key, required this.helperCubitContext})
      : super(key: key);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
//  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final birthDataController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<FocusNode> nodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      appBar: AppBar(
        backgroundColor: ColorManager.black,
        title: const Text('New user'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(),
        lazy: false,
        child: Builder(builder: (context) {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
            child: GestureDetector(
              onTap: () {
                closeKeyboard(context);
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: BlocProvider(
                    create: (context) => HelperCubit(),
                    child: BlocBuilder<HelperCubit, HelperState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Welcome',
                              style: StyleManager.primaryTextStyle(
                                  fontSize: FontSize.s24,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.white),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            DefaultTextField(
                              hintText: 'Name',
                              labelText: 'Name',
                              controller: nameController,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Please Enter Your Name';
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
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
                                  ValidationManager.passwordValidation(value),
                              isPassword: HelperCubit.get(context).isPassword,
                              suffix: GestureDetector(
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
                              height: 30.h,
                            ),
                            DefaultTextField(
                              hintText: '0123456789',
                              labelText: 'Phone Number',
                              type: TextInputType.phone,
                              controller: phoneController,
                              action: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Your Phone';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            InkWell(
                              onTap: () async {
                                closeKeyboard(context);
                                final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(1930),
                                    lastDate: DateTime(2012));
                                if (date != null) {
                                  birthDataController.text =
                                      DateFormat('yyyy-MM-dd').format(date);
                                  selectedDate = date;
                                }
                              },
                              child: DefaultTextField(
                                hintText: 'Birthdate',
                                labelText: 'Birth Date',
                                enabled: false,
                                action: TextInputAction.done,
                                type: TextInputType.datetime,
                                controller: birthDataController,
                                onChange: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Birth Date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: HelperCubit.get(context).rememberMe,
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
                                  'I Agree On Privacy Policy',
                                  style: StyleManager.primaryTextStyle(
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.white),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: AuthBlocConsumer(
                                listener: (context, state) {
                                  if (state is RegisterErrorState) {
                                    showSnackBar(
                                        context: context, text: state.error);
                                  }
                                  if (state is RegisterSuccessState) {
                                    showSnackBar(
                                      context: context,
                                      text:
                                          'Register success login to continue',
                                      backgroundColor:
                                          ColorManager.successColor,
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is RegisterLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return DefaultTextButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          AuthCubit.instance(context).register(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text,
                                              date: selectedDate
                                                  .toIso8601String());
                                        }
                                      },
                                      colorButton: ColorManager.white,
                                      title: 'Sign Up');
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Divider(
                                  height: 1.h,
                                  color: ColorManager.white,
                                )),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'OR',
                                  style: StyleManager.primaryTextStyle(
                                      fontSize: FontSize.s16,
                                      fontWeight: FontWeightManager.regular,
                                      color: ColorManager.white),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                    child: Divider(
                                  height: 1.h,
                                  color: ColorManager.white,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DefaultTextButtonWithIcon(
                                onPressed: () {},
                                colorButton: ColorManager.white,
                                title: 'Sign Up With Google',
                                iconData: FontAwesomeIcons.google,
                              ),
                            )
                          ],
                        );
                      },
                    ),
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
