import 'package:flutter/material.dart';
import 'package:moody_app/modules/home/inspiration_screen/post_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:moody_app/shared/cubits/home_cubit/home_states.dart';
import 'package:moody_app/widgets/load_more_data.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class FollowingInspirationPosts extends StatefulWidget {
  const FollowingInspirationPosts({Key? key, required this.categoryIndex})
      : super(key: key);
  final int categoryIndex;

  @override
  State<FollowingInspirationPosts> createState() =>
      _FollowingInspirationPostsState();
}

class _FollowingInspirationPostsState extends State<FollowingInspirationPosts> {
  @override
  void initState() {
    super.initState();
    final homeCubit = HomeCubit.instance(context);
    if (homeCubit.getFollowing.inspirationItems.isEmpty) {
      homeCubit.getFollowingInspirations(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeBlocBuilder(
      builder: (context, state) {
        if (state is RecentInspirationLoadingState) {
          return const LoadingWidget();
        }
        final followingInspirationList =
            HomeCubit.instance(context).getFollowing.inspirationItems;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.separated(
                itemCount: followingInspirationList.length,
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemBuilder: (context, index) => PostItem(
                  index: index,
                  onToggleLike: () => HomeCubit.instance(context)
                      .toggleLike(context, followingInspirationList[index].id!),
                  inspirationItem: followingInspirationList[index],
                ),
              ),
              Visibility(
                visible: !HomeCubit.instance(context).getFollowing.isLastPage,
                child: LoadMoreData(
                  onLoadingMore: () {
                    HomeCubit.instance(context).getMoreFollowingInspiration();
                  },
                  isLoading: state is MoreFollowingInspirationLoadingState,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
