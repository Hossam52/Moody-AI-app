import 'package:flutter/material.dart';
import 'package:moody_app/modules/home/inspiration_screen/post_item.dart';
import 'package:moody_app/shared/cubits/profile_cubit/profile_cubit.dart';
import 'package:moody_app/shared/cubits/profile_cubit/profile_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class ProfilePosts extends StatelessWidget {
  const ProfilePosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileBlocBuilder(
      builder: (_, state) {
        final profileCubit = ProfileCubit.instance(context);
        final posts = profileCubit.posts.inspirationItems;
        if (state is GetPostsLoadingState) {
          return const LoadingWidget();
        }
        if (posts.isEmpty) {
          return  Center(
            child: Text(
              'No posts',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (_, index) =>  SizedBox(
              height: 10.h,
            ),
            primary: false,
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (_, index) => PostItem(
              index: 0,
              onToggleLike: () {
                profileCubit.profilePostToggleLike(context, posts[index].id!);
              },
              inspirationItem: posts[index],
            ),
          );
        }
      },
    );
  }
}
