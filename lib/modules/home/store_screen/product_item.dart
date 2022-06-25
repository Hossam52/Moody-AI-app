import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../presentation/resources/color_manager.dart';
import '../../../widgets/cached_network_image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 350.h,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: ColorManager.blackPosts),
      child: Column(
        children: [
          SizedBox(
            height: 200.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: 200.h,
                    child: CachedNetworkImageWidget(
                      imageUrl:
                          'https://mobizil.com/wp-content/uploads/2020/10/Apple-iPhone-12.jpg',
                      width: 150.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onTap: () {
                    print('CCCCCCCCCCCCCCCccc');
                  },
                  child: SizedBox(
                    width: 70.w,
                    height: 50.h,
                    child: Image.asset(
                      'assets/images/zam.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Row(
            children: [
              Container(
                width: 90.w,
                height: 30.h,
                decoration: BoxDecoration(
                    color: Colors.amber[700],
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 65.w,
                      child: const FittedBox(
                        child: Text(
                          '16,796',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      ' EGP',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Icon(
                Icons.star,
                color: Colors.amber[700],
              ),
              Text(
                '4.7',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
          Text(
            'New Apple iPhone 13 with FaceTime (128GB) - Midnight New Apple iPhone 13 with FaceTime (128GB) - Midnight',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
