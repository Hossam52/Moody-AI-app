import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/network/firebase_services/services/fire_auth.dart/fire_auth.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/fire_firestore.dart';
import 'package:moody_app/shared/network/locale/cache_helper.dart';
import './auth_states.dart';

//Bloc builder and bloc consumer methods
typedef AuthBlocBuilder = BlocBuilder<AuthCubit, AuthStates>;
typedef AuthBlocConsumer = BlocConsumer<AuthCubit, AuthStates>;

//
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(IntitalAuthState());
  static AuthCubit instance(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);
  final auth = FireAuth.instance;
  final _firestoreRepo = FireStoreRepo.instance;
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    final user =
        await auth.signInEmailAndPassword(email: email, password: password);
    final userMap =
        await _firestoreRepo.profileServices.getUserData(uid: user.uid);
    final loggedInUser = UserModel.fromMap(userMap);
    CacheHelper.saveDate(key: 'login', value: true);
    CacheHelper.saveDate(key: 'uid', value: user.uid);
    emit(LoginSuccessState(user: loggedInUser));
    try {} catch (e) {
      log(e.toString());
      emit(LoginErrorState(error: e.toString()));
    }
  }

  Future<void> getMyProfile(BuildContext context) async {
    try 
    {
      emit(GetMyProfileLoadingState());
      final myProfileId = CacheHelper.getDate(key: 'uid');
      final userMap =
          await _firestoreRepo.profileServices.getUserData(uid: myProfileId);
      final loggedInUser = UserModel.fromMap(userMap);
      AppCubit.get(context).setUserAccount = loggedInUser;
      emit(GetMyProfileSuccessState());
    } catch (e) {
      emit(GetMyProfileErrorState(error: e.toString()));
    }
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String date}) async {
    try {
      emit(RegisterLoadingState());
      final user = await auth.registerUser(email: email, password: password);
      final model = UserModel(
          id: user.uid,
          name: name,
          email: email,
          phone: phone,
          dateOfBirth: date,
          usersIdFollowing: [],
          likesPostIds: [],
          followersCount: 0);
      await _firestoreRepo.profileServices
          .addUserData(uid: user.uid, user: model);
      emit(RegisterSuccessState());
    } catch (e) {
      log(e.toString());
      emit(RegisterErrorState(error: e.toString()));
    }
  }
}