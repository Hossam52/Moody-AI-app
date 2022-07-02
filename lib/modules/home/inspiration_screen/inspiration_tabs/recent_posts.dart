import 'package:flutter/material.dart';
import 'package:moody_app/modules/home/inspiration_screen/post_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:moody_app/shared/cubits/home_cubit/home_states.dart';
import 'package:moody_app/widgets/load_more_data.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class RecentInspirationPosts extends StatefulWidget {
  const RecentInspirationPosts({Key? key, required this.categoryIndex})
      : super(key: key);
  final int categoryIndex;

  @override
  State<RecentInspirationPosts> createState() => _RecentInspirationPostsState();
}

class _RecentInspirationPostsState extends State<RecentInspirationPosts> {
  @override
  void initState() {
    super.initState();
    final homeCubit = HomeCubit.instance(context);
    if (homeCubit.getRecent.inspirationItems.isEmpty) {
      homeCubit.getRecentInspiration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeBlocBuilder(
      builder: (context, state) {
        if (state is RecentInspirationLoadingState) {
          return const LoadingWidget();
        }
        final recentInspirationList =
            HomeCubit.instance(context).getRecent.inspirationItems;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.separated(
                itemCount: recentInspirationList.length,
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemBuilder: (context, index) => PostItem(
                  index: index+1,
                  onToggleLike: () => HomeCubit.instance(context)
                      .toggleLike(context, recentInspirationList[index].id!),
                  inspirationItem: recentInspirationList[index],
                ),
              ),
              Visibility(
                visible: !HomeCubit.instance(context).getRecent.isLastPage,
                child: LoadMoreData(
                  onLoadingMore: () {
                    HomeCubit.instance(context).getMoreRecentInspiration();
                  },
                  isLoading: state is MoreRecentLoadingState,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
