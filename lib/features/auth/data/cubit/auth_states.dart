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