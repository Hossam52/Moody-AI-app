import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/modules/home/movies_screen/movie_item.dart';
import 'package:moody_app/modules/home/movies_screen/movies_cubit/movies_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/modules/home/movies_screen/movies_cubit/movies_states.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: -10.w,
        leading: BackButton(
          color: ColorManager.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Movies',
          maxLines: 2,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 22.sp),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => MoviesCubit()..getAllMovies(),
        child: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            if (state is MoviesSuccess) {
              var cubit = MoviesCubit.get(context);
              return ListView.separated(
                  padding: EdgeInsets.all(15.0.r),
                  itemBuilder: (context, index) =>
                      MovieItem(movie: cubit.movies[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 15.h),
                  itemCount: cubit.movies.length);
            } else if (state is MoviesLoading) {
              return const LoadingWidget();
            } else {
              return const Center(
                child: Text('Text'),
              );
            }
          },
        ),
      ),
    );
  }
}
