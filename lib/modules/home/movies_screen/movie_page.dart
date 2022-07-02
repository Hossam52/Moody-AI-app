import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/movie.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';

import '../../../presentation/resources/color_manager.dart';
import '../../../presentation/resources/font_manager.dart';
import '../../../widgets/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:like_button/like_button.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movie details'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 400.h,
                    child: CachedNetworkImageWidget(
                      imageUrl: widget.movie.imageUrl,
                      //'https://media.elcinema.com/uploads/_315x420_c11f861557d3541d4470ac9541725ddde9c9469b68ae739affa1ec44d1967230.jpg',
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    height: 400.h,
                    width: double.infinity,
                    color: ColorManager.blackPosts.withOpacity(0.5),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    height: 400.h,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 25.h,
                          width: 85.w,
                          padding: EdgeInsets.all(3.r),
                          margin: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                              color: const Color(0xffFFC700),
                              borderRadius: BorderRadius.circular(15.r)),
                          child: FittedBox(
                            child: Text(
                              'IMDB ${widget.movie.rate}',
                              style: const TextStyle(
                                  fontWeight: FontWeightManager.medium),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              '(${widget.movie.year})',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 22.sp),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100.w,
                          height: 35.h,
                          padding: EdgeInsets.all(3.r),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.grey),
                              color: ColorManager.blackPosts),
                          child: FittedBox(
                            child: Text(
                              widget.movie.category,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),

                        LikeButton(
                          onTap: (isLiked) async {
                            widget.movie.addToFavourite();
                            setState(() {});

                            return true;
                          },
                          size: AppSizes.iconSize25,
                          bubblesSize: 100,
                          circleSize: AppSizes.iconSize25,
                          likeCountAnimationType: LikeCountAnimationType.all,
                          circleColor: const CircleColor(
                            start: Color(0xff00ddff),
                            end: Colors.red,
                          ),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Colors.red,
                          ),
                          isLiked: widget.movie.isFav,
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.white,
                              size: AppSizes.iconSize25,
                            );
                          },
                          countBuilder: (count, isLiked, text) {
                            return const SizedBox();
                          },
                          likeCount: 0,
                        ),

                        // Icon(
                        //   Icons.favorite,
                        //   color: widget.movie.isFav
                        //       ? Colors.red
                        //       : ColorManager.white,
                        //   size: 40.r,
                        // )),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.grey[600],
                          size: 25.r,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          widget.movie.duration,
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 18.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      color: Colors.grey[700],
                      width: double.infinity,
                      height: 1.h,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                    ),
                    TextButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse(widget.movie.url));
                        },
                        child: Text(
                          'Trailer'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      color: Colors.grey[700],
                      width: double.infinity,
                      height: 1.h,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      widget.movie.description,
                      //'This is supposed to show a rounded-edged container with a green left border 3px wide, and the child Text "This is a Container". However, it just shows a rounded-edged container with an invisible child and an invisible left border.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
