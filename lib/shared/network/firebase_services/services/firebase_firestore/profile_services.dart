import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/fire_firestore.dart';

class ProfileServices {
  ProfileServices._();
  static ProfileServices get instance => ProfileServices._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addUserData(
      {required String uid, required UserModel user}) async {
    _firestore.collection(FireStorePaths.usersPath).doc(uid).set(user.toMap());
  }

  Future<Map<String, dynamic>> getUserData({required String uid}) async {
    final user =
        await _firestore.collection(FireStorePaths.usersPath).doc(uid).get();
    log('Data User');
    log(user.data().toString());
    //final followingList = (user.data() as Map<String,dynamic>)['usersIdFollowing'];

    final followingList = await _firestore
        .collection(FireStorePaths.usersPath)
        .doc(uid)
        .collection(FireStorePaths.myFollowing)
        .get();

    if (!user.exists) throw 'This user not exist';
    final finalMap = user.data()!;

    //For all my following users
    final listOfMapOfString = followingList.docs.map((e) => e.data()).toList();
    finalMap['usersIdFollowing'] = listOfMapOfString;

    return finalMap;
    // return user.data()!;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProfilePosts(String id) async {
    final allData = await _firestore
        .collection(FireStorePaths.inspirationPath)
        .where('userId', isEqualTo: id)
        .orderBy('date', descending: true)
        .get();
    return allData;
  }

  Future<void> followFriend(
      {required String myProfileId,
      required String friendId,
      required FollowingPreview followingPersonPreview}) async {
    // await _firestore
    //     .collection(FireStorePaths.usersPath)
    //     .doc(myProfileId)
    //     .update({
    //   'usersIdFollowing': FieldValue.arrayUnion([friendId])
    // });
    await _firestore
        .collection(FireStorePaths.usersPath)
        .doc(myProfileId)
        .collection(FireStorePaths.myFollowing)
        .doc(followingPersonPreview.id)
        .set(followingPersonPreview.toMap());
    await _firestore
        .collection(FireStorePaths.usersPath)
        .doc(friendId)
        .update({'followersCount': FieldValue.increment(1)});
  }

  Future<void> unFollowFriend(
      {required String myProfileId, required String friendId}) async {
    // await _firestore
    //     .collection(FireStorePaths.usersPath)
    //     .doc(myProfileId)
    //     .update({
    //   'usersIdFollowing': FieldValue.arrayRemove([friendId])
    // });
    await _firestore
        .collection(FireStorePaths.usersPath)
        .doc(myProfileId)
        .collection(FireStorePaths.myFollowing)
        .doc(friendId)
        .delete();
    await _firestore
        .collection(FireStorePaths.usersPath)
        .doc(friendId)
        .update({'followersCount': FieldValue.increment(-1)});
  }

  Future<QuerySnapshot<Map<String, dynamic>>> followingList(
      List<String> friendIds) async {
    final allData = await _firestore
        .collection(FireStorePaths.usersPath)
        .where('usersIdFollowing', arrayContains: friendIds)
        .get();
    return allData;
  }

  Future<void> updateUserData(String id, {String? email, String? name}) async {
    await _firestore.collection(FireStorePaths.usersPath).doc(id).update({
      if (email != null) 'email': email,
      if (name != null) 'name': name,
    });
  }
}
