import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/modules/settings/favourite_screen/fav_movies.dart';
import 'package:moody_app/modules/settings/favourite_screen/fav_songs.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/widgets/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/fav_cubit.dart';
import 'fav_books.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavCubit()..getAllFav(),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Favourite Items',
            style: StyleManager.primaryTextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.white),
          ),
          centerTitle: true,
          bottom: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                  border: Border.all(color: ColorManager.white),
                  borderRadius: BorderRadius.circular(20.r)),
              labelStyle: StyleManager.primaryTextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.white),
              unselectedLabelStyle: StyleManager.primaryTextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.grey),
              tabs: const [
                Tab(text: 'Movies'),
                Tab(text: 'Books'),
                Tab(text: 'Songs'),
              ]),
        ),
        body: BlocBuilder<FavCubit, FavState>(
          builder: (context, state) {
            var cubit = FavCubit.get(context);
            if (state is FavSuccess) {
              return TabBarView(controller: _tabController, children: [
                FavMovies(movies: cubit.movies),
                FavBooks(books: cubit.books),
                FavSongs(songs: cubit.songs)
              ]);
            } else if (state is FavError) {
              return const Center(child: Text('Error happen when loading'));
            } else {
              return const LoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
