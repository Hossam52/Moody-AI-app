import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:moody_app/domain/models/inspiration.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:moody_app/shared/cubits/home_cubit/inspiration_data_class.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/fire_firestore.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/profile_services.dart';
import './profile_states.dart';

//Bloc builder and bloc consumer methods
typedef ProfileBlocBuilder = BlocBuilder<ProfileCubit, ProfileStates>;
typedef ProfileBlocConsumer = BlocConsumer<ProfileCubit, ProfileStates>;

//
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(IntitalProfileState());
  static ProfileCubit instance(BuildContext context) =>
      BlocProvider.of<ProfileCubit>(context);

  FollowingPersonData followingPersonData = FollowingPersonData();
  final _firestore = FireStoreRepo.instance;

  final InspirationData _postsData = InspirationData();
  InspirationData get posts => _postsData;
  //
  UserModel? userModel;
  Future<void> getPosts(String userId) async {
    try {
      emit(GetPostsLoadingState());
      final allData = await _firestore.profileServices.getProfilePosts(userId);
      _postsData.setData(allData);
      emit(GetPostsSuccessState());
    } catch (e) {
      emit(GetPostsErrorState(error: e.toString()));
    }
  }

  Future<void> profilePostToggleLike(
      BuildContext context, String postId) async {
    try {
      emit(ProfilePostToggleLikeLoadingState());
      final user = AppCubit.get(context).getUser;
      bool isLiked = user.containsInLikes(postId);
      if (isLiked) {
        user.removeLike(postId);
        _updateLikesCount(postId, false);
        await _firestore.inspirationServices.removeLike(user.id, postId);
      } else {
        user.addLike(postId);

        _updateLikesCount(postId, true);
        await _firestore.inspirationServices.addLike(user.id, postId);
      }
      emit(ProfilePostToggleLikeSuccessState());
    } catch (e) {
      emit(ProfilePostToggleLikeErrorState(error: e.toString()));
    }
  }

  void _updateLikesCount(String postId, bool isIncrease) {
    final postIndex = posts.inspirationItems.indexWhere((e) => e.id == postId);
    if (postIndex != -1) {
      posts.inspirationItems[postIndex].toggleLike(isIncrease);
    }
  }

  Future<void> getProfile(String userId) async {
    try {
      emit(GetProfileLoadingState());
      final data = await _firestore.profileServices.getUserData(uid: userId);
      userModel = UserModel.fromMap(data);
      emit(GetProfileSuccessState());
    } catch (e) {
      emit(GetProfileErrorState(error: e.toString()));
    }
  }

  Future<void> followFriend(BuildContext context, String friendId) async {
    try {
      final user = AppCubit.get(context).getUser;
      emit(FollowFriendLoadingState());
      final friendPreview =
          FollowingPreview(id: friendId, name: 'name2', image: 'image2');
      await _firestore.profileServices.followFriend(
          myProfileId: user.id,
          friendId: friendId,
          followingPersonPreview: friendPreview);

      user.usersIdFollowing.add(friendPreview);
      emit(FollowFriendSuccessState());
    } catch (e) {
      emit(FollowFriendErrorState(error: e.toString()));
    }
  }

  Future<void> unfollwFriend(BuildContext context, String friendId) async {
    try {
      final user = AppCubit.get(context).getUser;

      emit(UnFollowLoadingState());
      await _firestore.profileServices
          .unFollowFriend(myProfileId: user.id, friendId: friendId);
      user.usersIdFollowing.removeWhere((e) => e.id == friendId);

      emit(UnFollowSuccessState());
    } catch (e) {
      emit(UnFollowErrorState(error: e.toString()));
    }
  }

  Future<void> getFollowingFriends(BuildContext context) async {
    try {
      final user = AppCubit.get(context).getUser;
      followingPersonData.setFollowingList = user.getFollowingFriendsIds;
      if (user.usersIdFollowing.isEmpty) {
        followingPersonData.setFollowingList = user.getFollowingFriendsIds;
        return;
      }
      log(user.usersIdFollowing.toString());
      emit(GetFollowingFriendsLoadingState());

      final allData = await _firestore.profileServices
          .followingList(user.getFollowingFriendsIds);
      print(allData.docs.length);
      followingPersonData.setData(allData);
      emit(GetFollowingFriendsSuccessState());
    } catch (e) {
      emit(GetFollowingFriendsErrorState(error: e.toString()));
    }
  }
}

//////////////////////////////////////////////////////////
class FollowingPersons {
  List<UserModel>? users;
  QueryDocumentSnapshot<Map<String, dynamic>>?
      _lasttUser; //To get the next posts

  List<UserModel> get followingPersons => users ?? [];
  QueryDocumentSnapshot<Map<String, dynamic>>? get lastItem => _lasttUser;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;
  void setData(QuerySnapshot<Map<String, dynamic>> allData) {
    final allDocs = allData.docs.map((e) {
      return UserModel.fromMap(e.data());
    }).toList();
    if (allDocs.length != paginationSize) _isLastPage = true;
    if (users == null) {
      users = allDocs;
    } else {
      users!.addAll(allDocs);
    }
    //For saving last item and use in pagination
    _lasttUser = allData.docs.last;
  }

  void insertItem(UserModel user, int position) {
    users?.insert(position, user);
  }
}

class FollowingPersonData extends FollowingPersons {
  final int _maxFilterElements = 10;
  int _partitionNumber = 1;
  List<String>? _followingItems;
  set setFollowingList(List<String> items) {
    _followingItems ??= items;
  }

  int _from = 0;
  bool get fetchNewList {
    return _isLastPostsPage;
  }

  int get to {
    if (_from + _maxFilterElements > _followingItems!.length) {
      return _followingItems!.length;
    }
    return _from + _maxFilterElements;
  }

  List<String> get getCurrentSubList {
    return _followingItems!.sublist(_from, to);
  }

  bool _isLastPostsPage = false;
  @override
  bool get isLastPage {
    if (_followingItems != null &&
        (_followingItems!.isEmpty ||
            _isLastPostsPage && _from >= _followingItems!.length)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void setData(QuerySnapshot<Map<String, dynamic>> allData) {
    if (allData.docs.length < paginationSize) {
      _partitionNumber++;
      _from = to;
      _isLastPostsPage = true;
    } else {
      _isLastPostsPage = false;
    }
    super.setData(allData);
  }
}
