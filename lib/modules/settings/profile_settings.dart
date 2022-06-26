import 'package:flutter/material.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:moody_app/shared/cubits/auth_cubit/auth_states.dart';
import 'package:moody_app/widgets/default_text_button.dart';
import 'package:moody_app/widgets/default_text_button_with_icon.dart';
import 'package:moody_app/widgets/default_text_field.dart';
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
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _ProfilePicture(),
                      _buildHeader('Personal info'),
                      const SizedBox(height: 20),
                      DefaultTextField(
                          hintText: 'Name', controller: nameController),
                      const SizedBox(height: 20),
                      DefaultTextField(
                          hintText: 'Email', controller: emailController),
                      const SizedBox(height: 20),
                      DefaultTextField(
                          hintText: 'Phone', controller: phoneController),
                      const SizedBox(height: 20),
                      _saveButton('Update personal info', () {
                        AuthCubit.instance(context).updateProfileData(user.id,
                            email: emailController.text,
                            name: nameController.text);
                      }),
                      const Divider(
                        thickness: 1.2,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      _buildHeader('Password change'),
                      const SizedBox(height: 20),
                      DefaultTextField(
                          hintText: 'Password',
                          controller: newPasswordController),
                      const SizedBox(height: 20),
                      _saveButton('Update password', () {
                        AuthCubit.instance(context).updateProfileData(user.id,
                            password: newPasswordController.text);
                      }),
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
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24));
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
  const _ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
