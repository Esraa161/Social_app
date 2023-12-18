import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbaseapp/features/auth/data/Model/user_model.dart';
import 'package:firbaseapp/features/auth/data/cubit/auth_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firbaseapp/features/Edit%20profile/data/cubit/editProfile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:firebase_storage/firebase_storage.dart'as firbaseStorage;
import 'package:image_picker/image_picker.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitialState());
  static EditProfileCubit get(context) => BlocProvider.of(context);
String profileImageUrl='';
  void UploadProfileImage({
    required String?profileImagePath,
    required File?profileImage,


}){
    emit(ProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
       .child('users/${Uri.file(profileImagePath?? "").pathSegments.last}')
       .putFile(profileImage!,)
       .then((value){
         value.ref.getDownloadURL().then((value) {
           print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
           print(value);
           profileImageUrl=value;
           emit(ProfileImageSuccessState());
         });
            // .catchError((error){});
   // });
      // .catchError((error){
       //  emit(ProfileImageErrorState(error));
   });

  }
SocialUserModel ?model;
  void UpdateUser(
      String?name,
      String?phone,
      String?email,
      String?bio
      ){
    SocialUserModel model =
    SocialUserModel(
        name: name,
        phone: phone,
        email: email,
        bio: bio,
        image: profileImageUrl,);
    FirebaseFirestore.instance.collection('users').doc(model!.uId!).update(model.toMap()).then((value){
      AuthCubit().GetUserData();
    }).catchError((error){});
  }
}
