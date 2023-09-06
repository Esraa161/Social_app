abstract class HomeState{}

class RegisterInitialState extends HomeState{}

class RegisterLoadingState extends HomeState{}

class RegisterSuccessState extends HomeState{
}

class RegisterErrorState extends HomeState{
  final String error;
  RegisterErrorState(this.error);
}
