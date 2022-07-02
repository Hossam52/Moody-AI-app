import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moody_app/domain/enums/emotions.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';

import 'fire_firestore.dart';

class MoviesServices {
  MoviesServices._();
  static MoviesServices get instance => MoviesServices._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllRelatedMovies() {
    //class represent my mood
    if(myMood==emotions.happy.name||myMood==emotions.sad.name||myMood==emotions.angry.name) {
      return _firestore
        .collection(FireStorePaths.mediaPath)
        .where(
          'class',
          isEqualTo: myMood,
        )
        .snapshots();
    }
    return _firestore
        .collection(FireStorePaths.mediaPath)
        .snapshots();
  }

Stream<QuerySnapshot<Map<String, dynamic>>> getAllMoviesFav()
{
  return _firestore
        .collection(FireStorePaths.mediaPath)
        .snapshots();
}
  Future<void> updateOnMovie(
      {required String id,
      required String fav,
      required int numberOfFav}) async {
    await _firestore
        .collection(FireStorePaths.mediaPath)
        .doc(id)
        .update({'usersFav': fav, 'numberOfFav': numberOfFav});
  }

  //songs
  Stream<QuerySnapshot<Map<String, dynamic>>> getBestMovies() {
    switch (myMood) {
      case 'angry': //get rid of angry
      case 'disgust': //disgust
      case 'fear':
      case 'neutral':
      case 'surprise':
        return _firestore
            .collection(FireStorePaths.mediaPath)
            .where(
              'rate',
              isGreaterThan: 6.5,
            )
            .snapshots();
      default:
        //happy
        //sad
        //angry will be added
        return _firestore
            .collection(FireStorePaths.mediaPath)
            .where('class', isEqualTo: myMood)
            .where(
              'rate',
              isGreaterThan: 6.5,
            )
            .snapshots();
    }
  }
}
