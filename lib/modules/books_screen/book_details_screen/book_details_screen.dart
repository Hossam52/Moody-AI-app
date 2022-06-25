import 'package:flutter/material.dart';
import 'package:moody_app/domain/models/book.dart';
import 'package:moody_app/modules/books_screen/book_details_screen/build_listtile_item.dart';
import 'package:moody_app/presentation/resources/assets_manager.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:moody_app/widgets/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/widgets/default_text_button.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(
            left: AppSizes.sizew10,
            right: AppSizes.sizew10,
            bottom: AppSizes.sizeh5,
            top: AppSizes.sizeh10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 0.3.sh,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: ColorManager.white, width: 2),
                ),
                child: CachedNetworkImageWidget(
                    imageUrl: book.imageUrl, width: 0.45.sw),
              ),
              SizedBox(
                height: AppSizes.sizeh10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                height: AppSizes.sizeh10,
              ),
              SizedBox(
                width: 0.45.sw,
                child: DefaultTextButton(
                    onPressed: () async {
                      try {
                        await launch(book.url);
                      } catch (e) {
                        return;
                      }
                    },
                    colorButton: Colors.white,
                    title: 'Read'),
              ),
              SizedBox(
                height: AppSizes.sizeh20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    if (book.author.isNotEmpty)
                      BuildListTileItem(
                        authorName: book.author,
                        iconData: Icons.chrome_reader_mode_outlined,
                      ),
                    SizedBox(
                      height: AppSizes.sizeh10,
                    ),
                    BuildListTileItem(
                      authorName: book.language,
                      iconData: Icons.language,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.sizeh20,
              ),
              Image.asset(
                AssetsManager.bookBackground,
                height: 80.h,
                width: 80.w,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: AppSizes.sizeh10,
              ),
              Divider(
                height: 1.h,
                color: ColorManager.grey,
              ),
              SizedBox(
                height: AppSizes.sizeh10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  book.description,
                  style: StyleManager.primaryTextStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.white)
                      .copyWith(
                    height: 2.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
