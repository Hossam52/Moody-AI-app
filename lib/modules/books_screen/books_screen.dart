import 'package:flutter/material.dart';
import 'package:moody_app/modules/books_screen/books_cubit/books_cubit.dart';
import 'package:moody_app/modules/home/entertainment_screen/good_book_item.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: const Text(
          'Books',
        ),
      ),
      body: BlocProvider(
        create: (context) => BooksCubit()..getRelatedBooks(),
        child: BlocBuilder<BooksCubit, BooksState>(
          builder: (context, state) {
            var cubitBooks = BooksCubit.get(context);
            if (state is! BooksError && state is! BooksLoading) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.sizeh10, horizontal: AppSizes.sizew10),
                itemBuilder: (context, index) => SizedBox(
                  height: 200.h,
                  child: GoodBookItem(
                    book: cubitBooks.books[index],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: AppSizes.sizeh10,
                ),
                itemCount: cubitBooks.books.length,
              );
            } else if (state is BooksLoading) {
              return const LoadingWidget();
            } else {
              return const Text('data');
            }
          },
        ),
      ),
    );
  }
}
