import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/domain/models/book.dart';
import 'package:moody_app/modules/home/entertainment_cubit/entertainment_cubit.dart';

import 'good_book_item.dart';

class GoodBookItems extends StatelessWidget {
  const GoodBookItems({Key? key, required this.books}) : super(key: key);
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.25.sh,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => GoodBookItem(
                book: books[index],
              )),
          separatorBuilder: (context, index) => SizedBox(
                width: 10.w,
              ),
          itemCount: books.length),
    );
  }
}
