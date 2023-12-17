import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firbaseapp/features/Edit%20profile/data/cubit/editProfile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitialState());
  static EditProfileCubit get(context) => BlocProvider.of(context);
  void UploadProfileImage({
    required String?profileImagePath,
    required File?profileImage
}){
  FirebaseStorage.instance.ref()
       .child('users/${Uri.file(profileImagePath!).pathSegments.last}')
       .putFile(profileImage!,SettableMetadata(
    contentDisposition: 'inline', // Set the content disposition to 'inline'
  ),)
       .then((value){
         value.ref.getDownloadURL().then((value) {
           print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
           print(value);
           return value;

         }).catchError((error){});
   })
       .catchError((error){

   });
  }
}
