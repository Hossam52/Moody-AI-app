import 'package:flutter/material.dart';
import 'package:moody_app/domain/enums/emotions.dart';
import 'package:moody_app/modules/home/home_screen/cubit/home_cubit.dart';
import 'package:moody_app/modules/home/home_screen/trand_post_item.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/widgets/cached_network_image.dart';
import 'package:moody_app/widgets/default_appbar.dart';
import 'package:moody_app/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: defultAppBar(
        title: 'Home',
        centerTitle: true,
        color: ColorManager.white,
        colorText: ColorManager.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => HomeCubit()..getHomeData(),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 14.h),
                        child: Text(
                          myMood,
                          style: StyleManager.primaryTextStyle(
                              fontSize: FontSize.s18,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.white),
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.blackPosts,
                          gradient: linearGradient,
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(5.r),
                            bottomEnd: Radius.circular(5.r),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppSizes.sizeh10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          children: [
                            HomeCubit.get(context).inspiration == null
                                ? Container(
                                    // height: 100.h,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: ColorManager.black),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      emotions.angry.name==myMood?'There\'s nothing wrong with anger provided you use it constructively.'
                                      :
                                      emotions.sad.name==
                                    myMood?'Life is too short to be anything but happy'
                                    :'Nothing in life is to be feared. It is only to be understood.',
                                      style: StyleManager.primaryTextStyle(
                                          fontSize: FontSize.s19,
                                          fontWeight: FontWeightManager.medium,
                                          color: ColorManager.blackPosts),
                                    ),
                                  )
                                : Column(
                                    children: 
                                    [
                                      TrendPostItem(
                                        inspiration:
                                            HomeCubit.get(context).inspiration!,
                                      ),
                                      SizedBox(
                                        height: AppSizes.sizeh5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          AppCubit.get(context)
                                              .changeCurrentScreen(2);
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Discover More',
                                                style: StyleManager
                                                    .primaryTextStyle(
                                                        fontSize: FontSize.s16,
                                                        fontWeight:
                                                            FontWeightManager
                                                                .medium,
                                                        color:
                                                            ColorManager.white),
                                              ),
                                              SizedBox(
                                                width: AppSizes.sizew20,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_rounded,
                                                size: 25.sp,
                                                color: ColorManager.white,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            color: ColorManager.blackPosts,
                                            gradient: linearGradient,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20.r),
                                              bottomRight:
                                                  Radius.circular(20.r),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: AppSizes.sizeh20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 45.w),
                              child: Text(
                                'Recommended ',
                                style: StyleManager.primaryTextStyle(
                                    fontSize: FontSize.s20,
                                    fontWeight: FontWeightManager.medium,
                                    color: ColorManager.white),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorManager.blackPosts,
                                  gradient: linearGradient),
                            ),
                            SizedBox(
                              height: AppSizes.sizeh20,
                            ),
                            HomeCubit.get(context).generalData.isEmpty
                                ? const LoadingWidget()
                                : SizedBox(
                                    width: double.maxFinite,
                                    child: CarouselSlider.builder(
                                        options: CarouselOptions(
                                          height: 350.h,
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          enlargeStrategy:
                                              CenterPageEnlargeStrategy.height,
                                          autoPlayCurve: Curves.easeInOutCubic,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 800),
                                          aspectRatio: 0.5,
                                        ),
                                        itemBuilder: (context, index, _) =>
                                            InkWell(
                                              onTap: () async {
                                                await launchUrl(Uri.parse(
                                                    HomeCubit.get(context)
                                                        .generalData
                                                        .elementAt(index)
                                                        .url));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                clipBehavior: Clip.antiAlias,
                                                child: CachedNetworkImageWidget(
                                                  imageUrl:
                                                      HomeCubit.get(context)
                                                          .generalData
                                                          .elementAt(index)
                                                          .image,
                                                  width: 260.w,
                                                ),
                                              ),
                                            ),
                                        itemCount: HomeCubit.get(context)
                                            .generalData
                                            .length),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
