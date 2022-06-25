import 'package:flutter/material.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/modules/home/inspiration_screen/post_item.dart';
import 'package:moody_app/modules/profiles/all_following_screen.dart';
import 'package:moody_app/modules/profiles/profile_common_widgets/profile_following_item.dart';
import 'package:moody_app/modules/profiles/profile_common_widgets/profile_picture.dart';
import 'package:moody_app/modules/profiles/profile_common_widgets/profile_posts.dart';
import 'package:moody_app/modules/settings/settings_screen.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/navigation_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/shared/cubits/profile_cubit/profile_cubit.dart';
import 'package:moody_app/shared/cubits/profile_cubit/profile_states.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/widgets/default_appbar.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  final divider = const Divider(thickness: 1);
  final sizedBox = const SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    final user = AppCubit.get(context).getUser;
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: defultAppBar(title: 'Profile'),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ProfileCubit()..getPosts(user.id),
          lazy: false,
          child: ProfileBlocConsumer(
            listener: (context, state) {
              if (state is GetPostsErrorState) {
                showSnackBar(context: context, text: state.error);
              }
            },
            builder: (context, state) {
              return Builder(builder: (context) {
                final followingusers = user.usersIdFollowing;
                return Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ProfilePicture(),
                          sizedBox,
                          Text(
                            user.name,
                            style: TextStyle(
                                fontSize: 28.sp, fontWeight: FontWeight.bold),
                          ),
                          sizedBox,
                          Container(
                            padding: EdgeInsets.all(15.r),
                            decoration: BoxDecoration(
                                color: ColorManager.grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              '${user.followersCount} Followers',
                              style: TextStyle(
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.sp),
                            ),
                          ),
                          sizedBox,
                          divider,
                          sizedBox,
                          SettingItem(
                              title: 'Edit Emergency',
                              onPressed: () {},
                              imagePath:
                                  'assets/images/settings/edit_emergency.svg'),
                          SettingItem(
                              title: 'Profile settings',
                              onPressed: () {},
                              imagePath:
                                  'assets/images/settings/profile_setting.svg'),
                          divider,
                          sizedBox,
                          if (followingusers.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Following',
                                      style: TextStyle(
                                          color: ColorManager.blackPosts),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        navigateTo(context,
                                            const AllFollowingScreen());
                                      },
                                      child: const Text('All'),
                                    ),
                                  ],
                                ),
                                sizedBox,
                                SizedBox(
                                  height: getHeightFraction(context, 0.15),
                                  child: ListView.separated(
                                    separatorBuilder: (_, index) => SizedBox(
                                      width: 10.w,
                                    ),
                                    itemBuilder: (_, index) =>
                                        FollowingListItem(
                                            user: followingusers[index]),
                                    itemCount: followingusers.length,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                                divider,
                              ],
                            ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'My Posts',
                              style: StyleManager.primaryTextStyle(
                                  fontSize: FontSize.s18,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: ColorManager.black),
                            ),
                          ),
                          sizedBox,
                          const ProfilePosts(),
                        ],
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
