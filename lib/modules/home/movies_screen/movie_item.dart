import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/movie.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';

import '../../../presentation/resources/color_manager.dart';
import '../../../presentation/resources/navigation_manager.dart';
import '../../../widgets/cached_network_image.dart';
import 'movie_page.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            MoviePage(
              movie: movie,
            ));
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15.w),
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
            width: double.infinity,
            height: 190.h,
            decoration: BoxDecoration(
                color: ColorManager.blackPosts,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: double.maxFinite,
                    child: CachedNetworkImageWidget(
                      imageUrl: movie.imageUrl,
                      //moviesCubit.Movies[movieIndex].imageUrl,
                      width: 0.27.sw,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.category,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      '(${movie.year})',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 18.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () => movie.addToFavourite(),
                                child: Icon(Icons.favorite,
                                    size: AppSizes.iconSize25,
                                    color: movie.isFav
                                        ? Colors.red
                                        : ColorManager.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          Container(
            height: 25.h,
            width: 85.w,
            padding: EdgeInsets.all(3.r),
            margin: EdgeInsets.only(bottom: 15.h),
            decoration: BoxDecoration(
                color: const Color(0xffFFC700),
                borderRadius: BorderRadius.circular(15.r)),
            child: FittedBox(
              child: Text(
                'IMDB ${movie.rate.toStringAsFixed(1)}',
                style: const TextStyle(fontWeight: FontWeightManager.medium),
              ),
            ),
          )
        ],
      ),
    );
  }
}
