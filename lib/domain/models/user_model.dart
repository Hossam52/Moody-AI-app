import 'dart:convert';

import 'dart:developer';

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String dateOfBirth;
  List<FollowingPreview> usersIdFollowing = [];
  List<String> likesPostIds;
  int followersCount;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.dateOfBirth,
      required this.usersIdFollowing,
      required this.likesPostIds,
      required this.followersCount});
  factory UserModel.empty() {
    return UserModel(
        id: 'id',
        name: 'name',
        email: 'email',
        phone: 'phone',
        dateOfBirth: 'dateOfBirth',
        usersIdFollowing: [],
        likesPostIds: [],
        followersCount: 0);
  }
  List<String> get getFollowingFriendsIds {
    return usersIdFollowing.map((e) => e.id).toList();
  }

  //To know if item in likes or not
  bool containsInLikes(String postId) {
    return likesPostIds.contains(postId);
  }

  //To know if item in likes or not
  bool containsInFollowing(String friendId) {
    return getFollowingFriendsIds.contains(friendId);
  }

  //To remove item from likes
  void removeLike(String postId) {
    likesPostIds.removeWhere((element) => element == postId);
  }
  //To add like in list

  void addLike(String postId) {
    likesPostIds.add(postId);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'usersIdFollowing': usersIdFollowing.map((x) => x.toMap()).toList(),
      'likesPostIds': likesPostIds,
      'followersCount': followersCount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      usersIdFollowing:
       List<FollowingPreview>.from(
          map['usersIdFollowing']?.map((x) => FollowingPreview.fromMap(x))
          ),
      likesPostIds: List<String>.from(map['likesPostIds']),
      followersCount: map['followersCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

class FollowingPreview {
  String id;
  String name;
  String image;
  FollowingPreview({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory FollowingPreview.fromMap(Map<String, dynamic> map) {
    return FollowingPreview(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FollowingPreview.fromJson(String source) =>
      FollowingPreview.fromMap(json.decode(source));
}
