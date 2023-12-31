import '../Model/user_model.dart';
abstract class AuthState{}

class RegisterInitialState extends AuthState{}

class RegisterLoadingState extends AuthState{}

class RegisterSuccessState extends AuthState{
  final String uId;
  RegisterSuccessState(this.uId);
}

class RegisterErrorState extends AuthState{
  final String error;
  RegisterErrorState(this.error);
}

class LoginInitialState extends AuthState{}

class LoginLoadingState extends AuthState{}

class LoginSuccessState extends AuthState{
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends AuthState{
  final String error;
  LoginErrorState(this.error);
}
class CreatUserInitialState extends AuthState{}

class CreatUserLoadingState extends AuthState{}

class CreatUserSuccessState extends AuthState{
  final String uId;

  CreatUserSuccessState(this.uId);
}

class CreatUserErrorState extends AuthState{
  final String error;
  CreatUserErrorState(this.error);
}

class GetUserLoadingState extends AuthState{}

class GetUserSuccessState extends AuthState{
  SocialUserModel? model;
   GetUserSuccessState(this.model);
}

class GetUserErrorState extends AuthState{
  final String error;
  GetUserErrorState(this.error);
}
class ProfileImageLoadingState extends AuthState{}

class ProfileImageSuccessState extends AuthState{

}

class ProfileImageErrorState extends AuthState{
  final String error;
  ProfileImageErrorState(this.error);
}


class UpdateUserLoadingState extends AuthState{}
class UpdateUserSuccessState extends AuthState{

}

class UpdateUserErrorState extends AuthState{
  final String error;
  UpdateUserErrorState(this.error);
}