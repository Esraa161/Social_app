import '../Model/user_model.dart';
abstract class AuthState{}

class RegisterInitialState extends AuthState{}

class RegisterLoadingState extends AuthState{}

class RegisterSuccessState extends AuthState{
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