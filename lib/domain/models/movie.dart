import 'package:moody_app/shared/helper/helper_constants.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/movies_services.dart';

class Movie {
  final String description;
  final String title;
  final String duration;
  final String id;
  final double rate;
  String? firebaseId;
  final String url;
  final String classEmotion;
  final String category;
  final String imageUrl;
  final String year;
  String usersFav;
  int numberOfFav;
  bool isFav = false;

  Movie({
    required this.description,
    required this.title,
    required this.year,
    required this.id,
    required this.rate,
    this.firebaseId,
    this.numberOfFav = 0,
    required this.url,
    required this.classEmotion,
    required this.imageUrl,
    required this.usersFav,
    required this.duration,
    required this.category,
  });
  factory Movie.fromJson(Map<String, dynamic> data) {
    final song = Movie(
        year: data['year'],
        rate: double.parse(data['rate']),
        description: data['description'],
        duration: data['time'] ?? '',
        title: data['title'],
        id: data['id'],
        url: data['trailer_url'] ?? 'amazon',
        classEmotion: data['class'],
        category: data['category'],
        imageUrl: data['imageUrl'],
        usersFav: data['usersFav'] ?? '',
        numberOfFav: data['numberOfFav'] ?? 0);

    song.isFav = song.usersFav.contains('${HelperConstants.userId},');
    return song;
  }
  void addToFavourite() async {
    //1 =>represent my id change to id change it.
    String tempUsersFav = usersFav;
    int tempNumberOfFav = numberOfFav;
    try {
      if (usersFav.contains('${HelperConstants.userId},')) {
        int firstIndex = usersFav.indexOf('${HelperConstants.userId},');
        numberOfFav--;
        usersFav = usersFav.replaceRange(firstIndex, firstIndex + 2, '');
        isFav = false;
      } else {
        usersFav = usersFav + '${HelperConstants.userId},';
        numberOfFav++;
        isFav = true;
      }
      await MoviesServices.instance.updateOnMovie(
          id: firebaseId!, fav: usersFav, numberOfFav: numberOfFav);
    } catch (e) {
      usersFav = tempUsersFav;
      isFav = !isFav;
      numberOfFav = tempNumberOfFav;
      return;
    }
  }
}
