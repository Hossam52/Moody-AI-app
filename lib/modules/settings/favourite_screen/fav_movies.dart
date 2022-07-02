import 'package:flutter/material.dart';
import 'package:moody_app/domain/models/movie.dart';
import 'package:moody_app/modules/home/movies_screen/movie_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';

class FavMovies extends StatelessWidget {
  const FavMovies({Key? key,required this.movies}) : super(key: key);
 final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return
    movies.isEmpty? 
  Center(
    child: Text('No favourite movies untill now',style: StyleManager.primaryTextStyle(fontSize: FontSize.s16,
     fontWeight: FontWeightManager.medium, color: Colors.white),),
  ) :ListView.separated(
        padding: EdgeInsets.all(15.0.r),
        itemBuilder: (context, index) => MovieItem(movie: movies[index]),
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
        itemCount: movies.length);
  }
}
