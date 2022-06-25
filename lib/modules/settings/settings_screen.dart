import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moody_app/modules/auth/login/login_screen.dart';
import 'package:moody_app/modules/detect_mode_screen/detect_mode_screen.dart';
import 'package:moody_app/modules/home/movies_screen/movie_page.dart';
import 'package:moody_app/modules/profiles/my_profile_screen.dart';
import 'package:moody_app/presentation/resources/assets_manager.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/navigation_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/shared/network/firebase_services/services/fire_auth.dart/fire_auth.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.1,
                      backgroundImage: const AssetImage(AssetsManager.avater),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      AppCubit.get(context).getUser.name,
                      style: TextStyle(
                          fontSize: 30.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingItem(
                    title: 'Profile',
                    onPressed: () {
                      navigateTo(context, const MyProfileScreen());
                    },
                    imagePath: 'assets/images/settings/profile.svg'),
                SettingItem(
                    title: 'Edit emergency',
                    onPressed: () {
                      //navigateTo(context, const MoviePage());
                    },
                    imagePath: 'assets/images/settings/edit_emergency.svg'),
                SettingItem(
                    title: 'Detect Your Mood',
                    onPressed: () => navigateTo(context, DetectModeScreen()),
                    imagePath: 'assets/images/settings/edit_emergency.svg'),
                SettingItem(
                    title: 'Profile settings',
                    onPressed: () {},
                    imagePath: 'assets/images/settings/profile_setting.svg'),
                Divider(
                  color: ColorManager.settingItemColor,
                ),
                SettingItem(
                    title: 'Favorite',
                    onPressed: () {},
                    imagePath: 'assets/images/settings/favorite.svg'),
                Divider(
                  color: ColorManager.settingItemColor,
                ),
                SettingItem(
                    title: 'Settings',
                    onPressed: () {},
                    imagePath: 'assets/images/settings/settings.svg'),
                SettingItem(
                    title: 'Call Us',
                    onPressed: () {},
                    imagePath: 'assets/images/settings/call_us.svg'),
                Divider(
                  color: ColorManager.settingItemColor,
                ),
                SettingItem(
                    title: 'Log out',
                    onPressed: () async {
                      await FireAuth.instance.logoutUser();
                      navigateAndFinish(context, LoginScreen());
                    },
                    imagePath: 'assets/images/settings/logout.svg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  const SettingItem(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.imagePath})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      minLeadingWidth: 0,
      title: Text(
        title,
        style: TextStyle(color: ColorManager.settingItemColor),
      ),
      leading: SvgPicture.asset(
        imagePath,
        color: ColorManager.settingItemColor,
      ),
    );
  }
}
