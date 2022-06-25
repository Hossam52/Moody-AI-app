//
abstract class ProfileStates {}

class IntitalProfileState extends ProfileStates {}
//

//GetPosts online fetch data
class GetPostsLoadingState extends ProfileStates {}

class GetPostsSuccessState extends ProfileStates {}

class GetPostsErrorState extends ProfileStates {
  final String error;
  GetPostsErrorState({required this.error});
}

//ProfilePostToggleLike online fetch data
class ProfilePostToggleLikeLoadingState extends ProfileStates {}

class ProfilePostToggleLikeSuccessState extends ProfileStates {}

class ProfilePostToggleLikeErrorState extends ProfileStates {
  final String error;
  ProfilePostToggleLikeErrorState({required this.error});
}

//GetProfile online fetch data
class GetProfileLoadingState extends ProfileStates {}

class GetProfileSuccessState extends ProfileStates {}

class GetProfileErrorState extends ProfileStates {
  final String error;
  GetProfileErrorState({required this.error});
}

//FollowFriend online fetch data
class FollowFriendLoadingState extends ProfileStates {}

class FollowFriendSuccessState extends ProfileStates {}

class FollowFriendErrorState extends ProfileStates {
  final String error;
  FollowFriendErrorState({required this.error});
}

//UnFollow online fetch data
class UnFollowLoadingState extends ProfileStates {}

class UnFollowSuccessState extends ProfileStates {}

class UnFollowErrorState extends ProfileStates {
  final String error;
  UnFollowErrorState({required this.error});
}

//GetFollowingFriends online fetch data
class GetFollowingFriendsLoadingState extends ProfileStates {}

class GetFollowingFriendsSuccessState extends ProfileStates {}

class GetFollowingFriendsErrorState extends ProfileStates {
  final String error;
  GetFollowingFriendsErrorState({required this.error});
}
