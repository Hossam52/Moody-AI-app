import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:moody_app/shared/network/firebase_services/models/auth.dart';

import '../../models/social_user.dart';
part '../fire_auth.dart/social_auth/social_auth_providers.dart';

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static late FireAuth instance = FireAuth._();
  final SocialAuth socialAuth = SocialAuth();

  FireAuth._();
  Future<User> signInEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      } else if (e.code == 'user-disabled') {
        throw 'User is disabled by adminstrator.';
      } else {
        throw 'Error happened: ${e.toString()}';
      }
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  Future<User> registerUser(
      {required String email, required String password}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else {
        throw 'Error happened: ${e.toString()}';
      }
    }
  }

  Future<User> _signInWithCredintial(AuthCredential credential) async {
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) throw 'User is equal to null';
    if (user.isAnonymous) throw 'Cannot be annonymous';
    return user;
  }
}
