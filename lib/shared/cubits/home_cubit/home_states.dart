//
abstract class HomeStates {}

class IntitalHomeState extends HomeStates {}

//
//RecentInspiration online fetch data
class RecentInspirationLoadingState extends HomeStates {}

class RecentInspirationSuccessState extends HomeStates {}

class RecentInspirationErrorState extends HomeStates {
  final String error;
  RecentInspirationErrorState({required this.error});
}

//MoreRecent online fetch data
class MoreRecentLoadingState extends HomeStates {}

class MoreRecentSuccessState extends HomeStates {}

class MoreRecentErrorState extends HomeStates {
  final String error;
  MoreRecentErrorState({required this.error});
}

//TopInspiration online fetch data
class TopInspirationLoadingState extends HomeStates {}

class TopInspirationSuccessState extends HomeStates {}

class TopInspirationErrorState extends HomeStates {
  final String error;
  TopInspirationErrorState({required this.error});
}

//MoreTopInspiration online fetch data
class MoreTopInspirationLoadingState extends HomeStates {}

class MoreTopInspirationSuccessState extends HomeStates {}

class MoreTopInspirationErrorState extends HomeStates {
  final String error;
  MoreTopInspirationErrorState({required this.error});
}

//FollowingInspirations online fetch data
class FollowingInspirationsLoadingState extends HomeStates {}

class FollowingInspirationsSuccessState extends HomeStates {}

class FollowingInspirationsErrorState extends HomeStates {
  final String error;
  FollowingInspirationsErrorState({required this.error});
}

//MoreFollowingInspiration online fetch data
class MoreFollowingInspirationLoadingState extends HomeStates {}

class MoreFollowingInspirationSuccessState extends HomeStates {}

class MoreFollowingInspirationErrorState extends HomeStates {
  final String error;
  MoreFollowingInspirationErrorState({required this.error});
}

//ToggleLike online fetch data
class ToggleLikeLoadingState extends HomeStates {}

class ToggleLikeSuccessState extends HomeStates {}

class ToggleLikeErrorState extends HomeStates {
  final String error;
  ToggleLikeErrorState({required this.error});
}

//AddPost online fetch data
class AddPostLoadingState extends HomeStates {}

class AddPostSuccessState extends HomeStates {}

class AddPostErrorState extends HomeStates {
  final String error;
  AddPostErrorState({required this.error});
}
