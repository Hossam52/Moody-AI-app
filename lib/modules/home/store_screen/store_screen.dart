import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moody_app/modules/home/entertainment_screen/category_item.dart';
import 'package:moody_app/modules/home/entertainment_screen/category_model.dart';
import 'package:moody_app/modules/home/store_screen/store_category_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/modules/home/store_screen/product_item.dart';

class StoreScreen extends StatelessWidget {
  var images = [
    'https://ing.org/wp-content/uploads/2021/09/Calendar_Ramadan-1.png',
    'https://see.news/wp-content/uploads/2022/03/ornamental-arabic-lanterns-with-burning-candles-royalty-free-image-1646329984.jpg',
    'https://islamonline.net/wp-content/uploads/2022/03/ornament-lantern-in-a-moonlight--489x275.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                width: double.infinity,
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              reverse: true,
              height: 270.h,
              viewportFraction: 1,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text('  Category',
              style: TextStyle(color: Colors.black54, fontSize: 22.sp)),
          SizedBox(
            height: 120.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  const StoreCategoryItem(),
                  SizedBox(
                    width: 10.w,
                  ),
                  const StoreCategoryItem(),
                  SizedBox(
                    width: 10.w,
                  ),
                  const StoreCategoryItem(),
                  SizedBox(
                    width: 10.w,
                  ),
                  const StoreCategoryItem(),
                  SizedBox(
                    width: 10.w,
                  ),
                  const StoreCategoryItem()
                ],
              ),
            ),
          ),
          Text('  Best Seller',
              style: TextStyle(color: Colors.black54, fontSize: 22.sp)),
          SizedBox(
              height: 360.h,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(5.0.r),
                  itemBuilder: (context, index) => const ProductItem(),
                  separatorBuilder: (context, index) => SizedBox(width: 15.w),
                  itemCount: 5))
        ],
      ),
    );
  }
}
