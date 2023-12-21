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
import 'package:url_launcher/url_launcher.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitialState());
  static EditProfileCubit get(context) => BlocProvider.of(context);
String ?profileImageUrl;
 Future<void>UploadProfileImage({

    required File?profileImage,


})async{
    emit(ProfileImageLoadingState());

        Center(child: CircularProgressIndicator());

   await FirebaseStorage.instance
        .ref()
       .child('users/${Uri.file(profileImage!.path?? "").pathSegments.last}')
       .putFile(profileImage!,)
       .then((value){
         value.ref.getDownloadURL().then((value) {
           print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
           print(value.toString());
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
  {
    required String?name,
    required String?phone,
    required String?email,
    required String?bio,
    required File?profileImage
}

      )async{
    if(profileImageUrl!=null){
     await UploadProfileImage(profileImage: profileImage);
      SocialUserModel model =
      SocialUserModel(

        name: name,
        phone: phone,
        email: email,
        bio: bio,
        image: profileImageUrl
        //image: profileImageUrl,
      );
      FirebaseFirestore.instance.collection('users').doc(model!.uId!).update(model.toMap()).then((value){
     //GetUserData();
      }).catchError((error){});
    }else{
      SocialUserModel model =
      SocialUserModel(

        name: name,
        phone: phone,
        email: email,
        bio: bio,
        //image: profileImageUrl,
      );
      FirebaseFirestore.instance.collection('users').doc(model!.uId!).update(model.toMap()).then((value){
        AuthCubit().GetUserData();
      }).catchError((error){});
    }

  }
  var imageUrl;
  // uploadProfileImage({
  //   required File?profileImage,
  //
  // }) async {
  //
  //   Reference reference = FirebaseStorage.instance
  //       .ref()
  //       .child('profileImage/${Uri.file(profileImage!.path).pathSegments.last.toString()}');
  //   UploadTask uploadTask = reference.putFile(profileImage!);
  //   TaskSnapshot snapshot = await uploadTask;
  //   imageUrl = await snapshot.ref.getDownloadURL();
  //   print("11111111111111111111111111111111111111111111");
  //   print(imageUrl.toString());
  // }

  // uploadProfileImage({
  //   required File? profileImage,
  // }) async {
  //   Reference reference = FirebaseStorage.instance
  //       .ref()
  //       .child('profileImage/${Uri.file(profileImage!.path).pathSegments.last}');
  //
  //   UploadTask uploadTask = reference.putFile(profileImage!);
  //   TaskSnapshot snapshot = await uploadTask;
  //   imageUrl = await snapshot.ref.getDownloadURL();
  //
  //   // Print the image URL to the console
  //   print("Image URL: $imageUrl");
  //   debugPrint(imageUrl.toString());
  //   // Future<void> downloadURL() async{
  //   //   downloadurl=await FirebaseFirestore.instance.ref().child("Flutter.png").ge
  //   // }
  //   // Open the image URL in the default web browser
  //   await launch(imageUrl);
  // }

}
