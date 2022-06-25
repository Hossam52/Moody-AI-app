import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/book.dart';
import 'package:moody_app/modules/books_screen/book_details_screen/book_details_screen.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/navigation_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:moody_app/widgets/cached_network_image.dart';

class GoodBookItem extends StatelessWidget {
  const GoodBookItem({Key? key, required this.book}) : super(key: key);

  final Book book;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateTo(context, BookDetailsScreen(book: book)),
      child: Container(
        height: double.maxFinite,
        width: 0.9.sw,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorManager.blackPosts,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: double.maxFinite,
                child: CachedNetworkImageWidget(
                  imageUrl: book.imageUrl,
                  width: 0.3.sw,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: AppSizes.sizeh10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    book.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: StyleManager.primaryTextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    book.author,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: FontSize.s18,
                                      fontWeight: FontWeightManager.regular,
                                      color: ColorManager.grey,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: AppSizes.iconSize25,
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    book.rate.toStringAsFixed(1),
                                    style: StyleManager.primaryTextStyle(
                                        fontSize: FontSize.s16,
                                        fontWeight: FontWeightManager.regular,
                                        color: ColorManager.white),
                                  )
                                ],
                              ),
                              Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.h, horizontal: 8.w),
                                  child: Text(
                                    book.language,
                                    style: StyleManager.primaryTextStyle(
                                        fontSize: FontSize.s20,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        book.addToFavourite();
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: AppSizes.iconSize25,
                        color: book.isFav ? Colors.red : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
