import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moody_app/modules/profiles/profile_common_widgets/profile_picture.dart';
import 'package:moody_app/modules/profiles/profile_common_widgets/profile_posts.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/cubits/profile_cubit/profile_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/shared/cubits/profile_cubit/profile_states.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:moody_app/widgets/default_text_button.dart';
import 'package:moody_app/widgets/default_text_button_with_icon.dart';

class FriendProfile extends StatefulWidget {
  FriendProfile({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  @override
  void initState() {
    isFollowed =
        AppCubit.get(context).getUser.containsInFollowing(widget.userId);
    super.initState();
  }

  final sizedBox = const SizedBox(
    height: 10,
  );

  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    log('$isFollowed');
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: BlocProvider(
            create: (context) {
              return ProfileCubit()..getProfile(widget.userId);
            },
            lazy: false,
            child: ProfileBlocConsumer(
              listener: (context, state) {
                if (state is GetProfileSuccessState) {
                  ProfileCubit.instance(context).getPosts(widget.userId);
                }
                if (state is FollowFriendSuccessState) {
                  showSnackBar(
                      context: context,
                      text: 'Success add this user',
                      backgroundColor: ColorManager.successColor);
                }
                if (state is UnFollowSuccessState) {
                  showSnackBar(
                      context: context,
                      text: 'Success remove this user from following list',
                      backgroundColor: ColorManager.successColor);
                }

                if (state is GetProfileErrorState) {
                  showSnackBar(context: context, text: state.error);
                }
                if (state is GetPostsErrorState) {
                  showSnackBar(context: context, text: state.error);
                }
              },
              builder: (context, state) {
                isFollowed = AppCubit.get(context)
                    .getUser
                    .containsInFollowing(widget.userId);
                final profileCubit = ProfileCubit.instance(context);
                if (state is GetProfileLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetProfileErrorState ||
                    profileCubit.userModel == null) {
                  return const Text('Error happened when get profile');
                }
                final user = profileCubit.userModel;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ProfilePicture(),
                          sizedBox,
                          Text(
                            user!.name,
                            style: TextStyle(
                                fontSize: 28.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${user.followersCount} Followers',
                            style: TextStyle(
                              color: ColorManager.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          sizedBox,
                          if (isFollowed)
                            DefaultTextButtonWithIcon(
                              onPressed: () async {
                                await profileCubit.unfollwFriend(
                                    context, widget.userId);
                              },
                              iconData: Icons.done,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              colorButton: ColorManager.blackPosts,
                              title: 'Followed',
                              textColor: ColorManager.white,
                            )
                          else
                            DefaultTextButton(
                              onPressed: () async {
                                await profileCubit.followFriend(
                                    context, widget.userId);
                              },
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              colorButton: ColorManager.blackPosts,
                              title: 'Follow',
                              textColor: ColorManager.white,
                            ),
                          sizedBox,
                          Divider(
                            thickness: 1,
                            color: ColorManager.blackPosts.withOpacity(0.5),
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Posts',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          sizedBox,
                          const ProfilePosts(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
