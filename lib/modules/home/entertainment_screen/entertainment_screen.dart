import 'package:flutter/material.dart';
import 'package:moody_app/modules/home/entertainment_cubit/entertainment_cubit.dart';
import 'package:moody_app/modules/home/entertainment_screen/best_songs_list.dart';
import 'package:moody_app/modules/home/entertainment_screen/categories_entertainment.dart';
import 'package:moody_app/modules/home/entertainment_screen/good_book_item.dart';
import 'package:moody_app/modules/home/entertainment_screen/good_books_list.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class EntertainmentScreen extends StatelessWidget {
  const EntertainmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: const Text('Entertainment'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => EntertainmentCubit()..getEntertainmentData(),
            child: BlocBuilder<EntertainmentCubit, EntertainmentState>(
              builder: (context, state) {
                if (EntertainmentCubit.get(context).loadingBooks) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h,),
                      Text(
                        'Categories',
                        style: StyleManager.primaryTextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.black),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const CategoriesEntertainment(),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Good Books to Read',
                        style: StyleManager.primaryTextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.black),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      //TODO: remember return goodBookItem
                      GoodBookItems(
                          books: EntertainmentCubit.get(context).books),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Best Songs',
                        style: StyleManager.primaryTextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.black),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                       BestSongsList(songs: EntertainmentCubit.get(context).songs,)
                    ],
                  );
                } else if (state is EntertainmentLoading) {
                  return const LoadingWidget();
                } else {
                  return const Text('data');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
