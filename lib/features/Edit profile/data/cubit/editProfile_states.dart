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
class ProfileImageLoadingState extends EditProfileState{}

class ProfileImageSuccessState extends EditProfileState{

}

class ProfileImageErrorState extends EditProfileState{
  final String error;
  ProfileImageErrorState(this.error);
}