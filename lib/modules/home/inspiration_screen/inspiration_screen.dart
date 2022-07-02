import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/enums/posts_type.dart';
import 'package:moody_app/modules/home/inspiration_screen/inspiration_tabs/recent_posts.dart';
import 'package:moody_app/modules/home/inspiration_screen/inspiration_tabs/following_posts.dart';
import 'package:moody_app/modules/home/inspiration_screen/inspiration_tabs/top_posts.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/cubits/helper_cubit/helper_cubit.dart';
import 'package:moody_app/shared/cubits/home_cubit/home_cubit.dart';
import 'package:moody_app/shared/cubits/home_cubit/home_states.dart';
import 'package:moody_app/shared/helper/helper_methods.dart';
import 'package:moody_app/widgets/default_text_button_with_icon.dart';
import 'package:moody_app/widgets/default_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class InspirationScreen extends StatelessWidget {
  const InspirationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(AppCubit.get(context).getUser.likesPostIds.toString());
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          title: const Text('Inspiration'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // showBottomSheet(context: context, builder: builder)
            showBottomSheet(
                context: context,
                builder: (ctx) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: BlocProvider<HomeCubit>.value(
                      value: HomeCubit.instance(context),
                      child: const AddPostWidget(),
                    ),
                  );
                });
          },
          child: CircleAvatar(
            minRadius: 1,
            child: Image.asset(
              'assets/images/inspiration.png',
              fit: BoxFit.fill,
            ),
            backgroundColor: Colors.red,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Column(
          children: [
            Container(
              color: ColorManager.white,
              child: TabBar(
                  indicator: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.grey,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r),
                      ),
                      color: ColorManager.white),
                  labelColor: ColorManager.black,
                  labelStyle: StyleManager.primaryTextStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.black,
                  ),
                  unselectedLabelStyle: StyleManager.primaryTextStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.black.withOpacity(0.6),
                  ),
                  tabs: [
                    Tab(
                      text: PostType.recent.name,
                    ),
                    Tab(
                      text: PostType.top.name,
                    ),
                    Tab(
                      text: PostType.following.name,
                    ),
                  ]),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Column(
                children: [
                  // TextButton(
                  //     onPressed: () async {
                  // await FireStoreRepo.instance.inspirationServices
                  //     .createInpirationItem(Inspiration(
                  //         id: '21',
                  //         text: 'This is text' * 8,
                  //         date: DateTime.now()
                  //             .subtract(
                  //                 Duration(days: Random().nextInt(60)))
                  //             .toIso8601String(),
                  //         userName: 'Hossam Hassan 21',
                  //         userId: '21',
                  //         userPic: 'userPic',
                  //         mood: 'Happy',
                  //         likes: Random.secure().nextInt(1000)));
                  // },
                  // child: Text('Add post')),
                  Expanded(
                    child: TabBarView(children: [
                      RecentInspirationPosts(
                          categoryIndex: PostType.recent.index),
                      TopInspirationPosts(categoryIndex: PostType.top.index),
                      FollowingInspirationPosts(
                          categoryIndex: PostType.following.index),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPostWidget extends StatefulWidget {
  const AddPostWidget({Key? key}) : super(key: key);

  @override
  State<AddPostWidget> createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends State<AddPostWidget> {
  final postController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;
  @override
  Widget build(BuildContext context) {
    return HomeBlocConsumer(
      listener: (_, state) {
        if (state is AddPostSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (_, state) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0.r),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ColorManager.black,
                height: 4.h,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Add post',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeightManager.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 18.h),
              Form(
                key: formKey,
                child: DefaultTextField(
                  textColor: ColorManager.black,
                  action: TextInputAction.done,
                  hintText: '',
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Field post can not be empty';
                    }
                    if (text.length >= 200) {
                      return 'Post is long must be less than 200 character';
                    }
                    return null;
                  },
                  maxLines: 5,
                  controller: postController,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocProvider(
                create: (context) => HelperCubit(),
                child: BlocBuilder<HelperCubit, HelperState>(
                  builder: (context, state) {
                    return SizedBox(
                      //  width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultTextButtonWithIcon(
                                  onPressed: () async {
                                    final file = await getImage();
                                    if (file != null) {
                                      image = file;
                                      HelperCubit.get(context).rebuild();
                                    }
                                  },
                                  colorButton: Colors.green,
                                  title: image == null
                                      ? 'Add Image'
                                      : 'Edit Image',
                                  textColor: ColorManager.white,
                                  iconData: Icons.add_a_photo),
                              SizedBox(
                                width: 10.w,
                              ),
                              if (image != null)
                                InkWell(
                                  onTap: () {
                                    image = null;
                                    HelperCubit.get(context).rebuild();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6.r),
                                    child: Icon(
                                      Icons.delete,
                                      color: ColorManager.white,
                                      size: AppSizes.iconSize25,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorManager.errorColor,
                                    ),
                                  ),
                                )
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          if (image != null)
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.file(
                                  image!,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    state is AddPostLoadingState
                        ? const LoadingWidget()
                        : DefaultTextButtonWithIcon(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                HomeCubit.instance(context).addPost(
                                    context, postController.text, myMood,
                                    image: image);
                              }
                            },
                            colorButton: Colors.green,
                            title: 'Add post',
                            textColor: Colors.white,
                            iconData: Icons.add),
                    DefaultTextButtonWithIcon(
                        onPressed: () {
                          postController.clear();
                        },
                        colorButton: Colors.red,
                        title: 'Clear text',
                        textColor: Colors.white,
                        iconData: Icons.close),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
