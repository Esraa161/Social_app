abstract class EditProfileState{}

class EditProfileInitialState extends EditProfileState{}

class EditProfileLoadingState extends EditProfileState{}

class EditProfileSuccessState extends EditProfileState{
  final String uId;
  EditProfileSuccessState(this.uId);
}

class EditProfileErrorState extends EditProfileState{
  final String error;
  EditProfileErrorState(this.error);
}