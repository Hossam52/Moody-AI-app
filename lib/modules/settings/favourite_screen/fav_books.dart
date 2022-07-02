import 'package:flutter/material.dart';
import 'package:moody_app/domain/models/book.dart';
import 'package:moody_app/modules/home/entertainment_screen/good_book_item.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavBooks extends StatelessWidget {
  const FavBooks({Key? key,required this.books}) : super(key: key);
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return 
   books.isEmpty? 
  Center(
    child: Text('No favourite books untill now',style: StyleManager.primaryTextStyle(fontSize: FontSize.s16,
     fontWeight: FontWeightManager.medium, color: Colors.white),),
  ) :ListView.separated(
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.sizeh10, horizontal: AppSizes.sizew10),
      itemBuilder: (context, index) => SizedBox(
        height: 200.h,
        child: GoodBookItem(
          book: books[index],
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: AppSizes.sizeh10,
      ),
      itemCount: books.length,
    );
  }
}
