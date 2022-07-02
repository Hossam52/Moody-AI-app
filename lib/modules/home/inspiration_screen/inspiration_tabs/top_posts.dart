import 'package:flutter/material.dart';
import 'package:moody_app/modules/home/inspiration_screen/post_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:moody_app/shared/cubits/home_cubit/home_states.dart';
import 'package:moody_app/widgets/load_more_data.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class TopInspirationPosts extends StatefulWidget {
  const TopInspirationPosts({Key? key, required this.categoryIndex})
      : super(key: key);
  final int categoryIndex;

  @override
  State<TopInspirationPosts> createState() => _TopInspirationPostsState();
}

class _TopInspirationPostsState extends State<TopInspirationPosts> {
  @override
  void initState() {
    super.initState();
    final homeCubit = HomeCubit.instance(context);
    if (homeCubit.getTop.inspirationItems.isEmpty) {
      homeCubit.getTopInspiration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeBlocBuilder(
      builder: (context, state) {
        if (state is RecentInspirationLoadingState) {
          return const LoadingWidget();
        }
        final topInspirationList =
            HomeCubit.instance(context).getTop.inspirationItems;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.separated(
                itemCount: topInspirationList.length,
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemBuilder: (context, index) => PostItem(
                  index: index + 1,
                  onToggleLike: () => HomeCubit.instance(context)
                      .toggleLike(context, topInspirationList[index].id!),
                  inspirationItem: topInspirationList[index],
                ),
              ),
              Visibility(
                visible: !HomeCubit.instance(context).getTop.isLastPage,
                child: LoadMoreData(
                  onLoadingMore: () {
                    HomeCubit.instance(context).getMoreTopInspiration();
                  },
                  isLoading: state is MoreTopInspirationLoadingState,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
