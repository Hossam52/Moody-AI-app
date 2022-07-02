import 'package:flutter/material.dart';
import 'package:moody_app/modules/settings/change_password_screen.dart';
import 'package:moody_app/presentation/resources/navigation_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_states.dart';
import 'package:moody_app/widgets/default_text_button_with_icon.dart';
import 'package:moody_app/widgets/default_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final newPasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final user = AppCubit.get(context).getUser;
    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone;
  }

  @override
  Widget build(BuildContext context) {
    final user = AppCubit.get(context).getUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit profile'), centerTitle: true),
      body: Form(
        key: formKey,
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: BlocBuilder<AuthCubit, AuthStates>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(16.0.r),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProfilePicture(imageUrl: user.imagePath),
                      SizedBox(
                        height: 20.h,
                      ),
                      _buildHeader('Personal info'),
                      SizedBox(height: 20.h),
                      DefaultTextField(
                          hintText: 'Name', controller: nameController),
                      SizedBox(height: 20.h),
                      DefaultTextField(
                          hintText: 'Email', controller: emailController),
                      SizedBox(height: 20.h),
                      DefaultTextField(
                          hintText: 'Phone', controller: phoneController),
                      SizedBox(height: 20.h),

                      _saveButton('Update personal info', () {
                        AuthCubit.instance(context).updateProfileData(user.id,
                            email: emailController.text,
                            name: nameController.text);
                      }),
                      const Divider(
                        thickness: 1.2,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20.h),
                      _buildHeader('Other Options'),
                      const Divider(
                        thickness: 1.2,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20.h),
                      DefaultTextButtonWithIcon(
                        onPressed: () {
                          navigateTo(context, ChangePasswordScreen());
                        },
                        colorButton: Colors.white,
                        title: 'Change Password',
                        iconData: Icons.security,
                        iconColor: Colors.black,
                      ),
                      // DefaultTextField(
                      //     hintText: 'Change Password',
                      //     controller: newPasswordController),
                      // SizedBox(height: 20.h),

                      // _saveButton('Update password', () {
                      //   AuthCubit.instance(context).updateProfileData(user.id,
                      //       password: newPasswordController.text);
                      // }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Text(text,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.sp));
  }

  Widget _saveButton(String text, VoidCallback updateAttributes) {
    return Builder(builder: (context) {
      return Center(
        child: DefaultTextButtonWithIcon(
            iconData: Icons.save,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                updateAttributes();
              }
            },
            colorButton: Colors.green,
            title: text,
            textColor: Colors.white),
      );
    });
  }
}

class _ProfilePicture extends StatelessWidget {
  _ProfilePicture({Key? key, this.imageUrl}) : super(key: key);
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Center(
        child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          Container(
              height: 200.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.asset(
                imageUrl ?? 'assets/images/avater.jpg',
                fit: BoxFit.contain,
              )
              // : CachedNetworkImageWidget(
              //     imageUrl: imageUrl!, width: double.maxFinite),
              ),
          // IconButton(
          //     onPressed: () async {
          //       final file = await getImage();
          //       if (file != null) {
          //         FirebaseHelper.uploadFileTofireStorage(file);
          //       } else {}
          //     },
          //     icon: const Icon(
          //       Icons.add_a_photo,
          //     )),
        ]),
      ),
    );
  }
}
