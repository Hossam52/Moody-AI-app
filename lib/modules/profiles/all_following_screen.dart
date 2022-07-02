import 'package:flutter/material.dart';
import 'package:moody_app/modules/profiles/profile_common_widgets/profile_following_item.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';

class AllFollowingScreen extends StatelessWidget {
  const AllFollowingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final followingPreviews = AppCubit.get(context).getUser.usersIdFollowing;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All following list'),
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: followingPreviews.length,
                itemBuilder: (context, index) =>
                    FollowingListItem(user: followingPreviews[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
