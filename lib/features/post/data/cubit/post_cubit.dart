import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbaseapp/features/post/data/cubit/post_states.dart';
import 'package:firbaseapp/features/post/data/model/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Network/Cache_helper.dart';
import '../../../../core/widgets/constants_userData.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostInitialState());
  static PostCubit get(context) => BlocProvider.of(context);

  PostModel ?model;
  String ?postImageUrl;
  Future<void>UploadPostImage({
    required File?profileImage,
    required String ?dateTime,
    required  String?text,
    required String?postImage
  })async{
    emit(PostImageLoadingState());

    Center(child: CircularProgressIndicator());

    await FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(profileImage!.path?? "").pathSegments.last}')
        .putFile(profileImage!,)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
        print(value.toString());
        CreatNewPost(dateTime: dateTime, text: text, postImage: value);
        postImageUrl=value;
        emit(PostImageSuccessState(CacheHelper.getData(key: 'uId'),));
      });
      // .catchError((error){});
      // });
      // .catchError((error){
      //  emit(ProfileImageErrorState(error));
    });

  }
  void CreatNewPost(
      {
        required String ?dateTime,
        required  String?text,
        required String?postImage
      }
      ){
    emit(PostLoadingState());
    PostModel model =
    PostModel(
      name: CacheHelper.getData(key: UserName),
      dateTime: dateTime,
      text: text,
      uId: CacheHelper.getData(key: 'uId'),
      image:  CacheHelper.getData(key:UserImage),
      postImage: postImageUrl??""
    );
    FirebaseFirestore.instance.collection('posts').
    doc("1").set(model.toMap()).then((value){

      print("......................................................");
      emit(PostSuccessState(CacheHelper.getData(key: 'uId')));
    });
  }

//   void UploadPostImage({
//     required String ?dateTime,
//     required  String?text,
//     required String?postImage
// }){
//
//   }
}
