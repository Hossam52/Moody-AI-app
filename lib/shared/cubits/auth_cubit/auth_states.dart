//
import 'package:moody_app/domain/models/user_model.dart';

abstract class AuthStates {}

class IntitalAuthState extends AuthStates {}
//

//Login online fetch data
class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final UserModel user;

  LoginSuccessState({required this.user});
}

class LoginErrorState extends AuthStates {
  final String error;
  LoginErrorState({required this.error});
}

//Register online fetch data
class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String error;
  RegisterErrorState({required this.error});
}

//GetMyProfile online fetch data
class GetMyProfileLoadingState extends AuthStates {}

class GetMyProfileSuccessState extends AuthStates {}

class GetMyProfileErrorState extends AuthStates {
  final String error;
  GetMyProfileErrorState({required this.error});
}
