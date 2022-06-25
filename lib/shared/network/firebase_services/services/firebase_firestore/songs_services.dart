import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moody_app/domain/enums/emotions.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';

import 'fire_firestore.dart';

class SongsServices {
  SongsServices._();
  static SongsServices get instance => SongsServices._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSongs() {
    //class represent my mood
    if (myMood == emotions.happy.name || myMood == emotions.sad.name) {
      return _firestore
          .collection(FireStorePaths.songsPath)
          .where(
            'class',
            isEqualTo: myMood,
          )
          .snapshots();
    }
   return _firestore
          .collection(FireStorePaths.songsPath)
          
          .snapshots();
  }

  Future<void> updateOnSong(
      {required String id,
      required String fav,
      required int numberOfFav}) async {
    await _firestore
        .collection(FireStorePaths.songsPath)
        .doc(id)
        .update({'usersFav': fav, 'numberOfFav': numberOfFav});
  }

  //songs
  Stream<QuerySnapshot<Map<String, dynamic>>> getBestSongs() {
    switch (myMood) {
      case 'angry': //get rid of angry
      case 'disgust': //disgust
      case 'fear':
      case 'neutral':
      case 'surprise':
        return _firestore
            .collection(FireStorePaths.songsPath)
            .where(
              'numberOfFav',
              isGreaterThanOrEqualTo: 1,
            )
            .snapshots();
      default:
        //happy
        //sad
        //angry will be added
        return _firestore
            .collection(FireStorePaths.songsPath)
            .where('class', isEqualTo: myMood)
            .where(
              'numberOfFav',
              isGreaterThanOrEqualTo: 1,
            )
            .snapshots();
    }
  }
}
