import 'package:flutter/material.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';

class FollowingListItem extends StatelessWidget {
  const FollowingListItem({Key? key, required this.user}) : super(key: key);
  final FollowingPreview user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToProfile(context, user.id),
      child: Container(
        width: getWidthFraction(context, 0.3),
        decoration: BoxDecoration(
          color: ColorManager.blackPosts,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/defaultuser.png'))),
            Text(
              user.name,
              style: TextStyle(color: ColorManager.white),
            )
          ],
        ),
      ),
    );
  }
}
