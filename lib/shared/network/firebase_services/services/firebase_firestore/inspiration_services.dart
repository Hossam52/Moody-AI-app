import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moody_app/domain/enums/emotions.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';

import 'fire_firestore.dart';

int paginationSize = 10;

class InspirationServices {
  InspirationServices._();
  static InspirationServices get instance => InspirationServices._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createInpirationItem(Inspiration inspirationModel) async {
    final doc = _firestore
        .collection(FireStorePaths.inspirationPath)
        .doc(inspirationModel.id);
    inspirationModel.id = doc.id;
    await doc.set(inspirationModel.toMap());
    return doc.id;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRecentInspirations() async {
    final allData = await _firestore
        .collection(FireStorePaths.inspirationPath)
        .orderBy('date', descending: true)
        .limit(paginationSize)
        .get();
    return allData;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMoreRecentInspirations(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
    final allData = await _firestore
        .collection(FireStorePaths.inspirationPath)
        .orderBy('date', descending: true)
        .startAfterDocument(doc)
        .limit(paginationSize)
        .get();
    return allData;
  }

//Top inspirations
  Future<QuerySnapshot<Map<String, dynamic>>> getTopInspirations() async {
    final allData = await _firestore
        .collection(FireStorePaths.inspirationPath)
        .orderBy('likes', descending: true)
        .limit(paginationSize)
        .get();
    return allData;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTopPost() {
    if (myMood == emotions.fear.name ||
        myMood == emotions.sad.name ||
        myMood == emotions.angry.name) {
      return _firestore
          .collection(FireStorePaths.inspirationPath)
          .where(
            'class',
            isEqualTo:
                myMood == emotions.sad.name ? emotions.happy.name : myMood,
          )
          .orderBy('likes', descending: true)
          .limit(1)
          .snapshots();
    }
    return _firestore
        .collection(FireStorePaths.inspirationPath)
        .orderBy('likes', descending: true)
        .limit(paginationSize)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMoreTopInspirations(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
    final allData = await _firestore
        .collection(FireStorePaths.inspirationPath)
        .orderBy('likes', descending: true)
        .startAfterDocument(doc)
        .limit(paginationSize)
        .get();
    return allData;
  }

//following inspirations
  Future<QuerySnapshot<Map<String, dynamic>>> getFollowingInspirations(
      List<String> followingIds) async {
    final allData = await _firestore
        .collection(FireStorePaths.inspirationPath)
        .where('userId', whereIn: followingIds)
        .limit(paginationSize)
        .get();
    return allData;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMoreFollowingInspirations(
      QueryDocumentSnapshot<Map<String, dynamic>> doc,
      List<String> followingIds) async {
    final allData = await _firestore
        .collection(FireStorePaths.inspirationPath)
        .where('userId', whereIn: followingIds)
        .startAfterDocument(doc)
        .limit(paginationSize)
        .get();
    return allData;
  }

  //Toggle like
  Future<void> addLike(String userId, String postId) async {
    await _firestore
        .collection(FireStorePaths.inspirationPath)
        .doc(postId)
        .update({'likes': FieldValue.increment(1)});
    await _firestore.collection(FireStorePaths.usersPath).doc(userId).update({
      'likesPostIds': FieldValue.arrayUnion([postId])
    });
  }

  Future<void> removeLike(String userId, String postId) async {
    await _firestore
        .collection(FireStorePaths.inspirationPath)
        .doc(postId)
        .update({'likes': FieldValue.increment(-1)});
    await _firestore.collection(FireStorePaths.usersPath).doc(userId).update({
      'likesPostIds': FieldValue.arrayRemove([postId])
    });
  }
}
