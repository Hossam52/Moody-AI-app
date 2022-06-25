import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/modules/books_screen/books_screen.dart';
import 'package:moody_app/modules/home/entertainment_screen/category_item.dart';
import 'package:moody_app/modules/home/entertainment_screen/category_model.dart';
import 'package:moody_app/modules/home/movies_screen/movies_screen.dart';
import 'package:moody_app/modules/home/music_screen/music_screen.dart';
import 'package:moody_app/presentation/resources/navigation_manager.dart';

class CategoriesEntertainment extends StatelessWidget {
  const CategoriesEntertainment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.2.sh,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => InkWell(
              onTap: () {
                chooseScreen(index, context);
              },
              child: CategoryItem(
                categoryModel: categories[index],
              ))),
          separatorBuilder: (context, index) => SizedBox(
                width: 10.w,
              ),
          itemCount: categories.length),
    );
  }
}

void chooseScreen(index, BuildContext context) {
  switch (index) {
    case 0:
      navigateTo(context, const MoviesScreen());
      break;
    case 1:
      navigateTo(context, const BooksScreen());
      break;
    case 2:
      navigateTo(context, const MusicScreen());
      break;
    default:
  }
}
