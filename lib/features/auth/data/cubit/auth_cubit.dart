import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbaseapp/core/Network/Cache_helper.dart';
import 'package:firbaseapp/features/auth/data/Model/user_model.dart';
import 'package:firbaseapp/features/auth/data/cubit/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(RegisterInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  void Register(
      {required String email,
      required String password,
      required String name,
      required String phone,
      }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      UserCreate(name: name, email: email, phone: phone, uId: value.user!.uid,Image: "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg");
      // print("11111111111111111111111111111111111111111111111");
      // print(value.user!.displayName);
      CacheHelper.saveData(key: 'name', value: socialUserModel!.name);
      print("22222222222222222222222222222222222222222222");
      print(socialUserModel!.name);
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  SocialUserModel? socialUserModel;
  void UserCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String? Image,
  }) {
    emit(CreatUserLoadingState());
    SocialUserModel model =
        SocialUserModel(
            name: name,
            phone: phone,
            email: email,
            bio: "Write your bio..................",
            uId: uId,image: 'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(RegisterSuccessState(uId));
      emit(CreatUserSuccessState(uId));
      CacheHelper.saveData(key: 'name', value: socialUserModel!.name);
      print(CacheHelper.getData(key: name));
    }).catchError((error) {
      emit(CreatUserErrorState(error.toString()));
    });
  }

  void Login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.saveData(key: "uId", value: value.user!.uid);
      print("??????????????????????????????????????");
      print(CacheHelper.getData(key: 'uId'));

      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error!.toString()));
    });
  }


  SocialUserModel? model;

  void GetUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
          print("{{{{{{{{{{{{{{{{{{{{{object}}}}}}}}}}}}}}}}}}}}}");
      print(value.data());

      model = SocialUserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: "uId", value: model!.uId);

      emit(GetUserSuccessState(model!));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }
  String ?profileImageUrl;
  UploadProfileImageWithData({
    required File?profileImage,
    required String?name,
    required String?phone,
    required String?email,
    required String?bio,
  })async{
    emit(ProfileImageLoadingState());
     FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path?? "").pathSegments.last}')
        .putFile(profileImage,)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
        print(value.toString());
        profileImageUrl=  value;
        SocialUserModel model =
        SocialUserModel(
          name: name,
          phone: phone,
          email: email,
          bio: bio,
          uId: CacheHelper.getData(key: 'uId'),
          image:  profileImageUrl,
        );
        FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'uId')).update(model.toMap()).then((value){
          GetUserData();
          print("......................................................");
          emit(UpdateUserSuccessState());
        }).catchError((error){
          emit(UpdateUserErrorState(error));
        });
        emit(ProfileImageSuccessState());
      });
      // .catchError((error){});
      // });
      // .catchError((error){
      //  emit(ProfileImageErrorState(error));
    });

  }
 // SocialUserModel ?model;
  void UpdateUser(
      {
        required String?name,
        required String?phone,
        required String?email,
        required String?bio,
        required File?profileImage
      }

      )async{
    // if(profileImageUrl!=null){
    //   UploadProfileImage(profileImage: profileImage);
    //   SocialUserModel model =
    //   SocialUserModel(
    //
    //       name: name,
    //       phone: phone,
    //       email: email,
    //       bio: bio,
    //       uId: CacheHelper.getData(key: 'uId'),
    //       image: profileImageUrl
    //     //image: profileImageUrl,
    //   );
    //   FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'uId')).update(model.toMap()).then((value){
    //     GetUserData();
    //     print("1111111111111111111111111111111111111111111111111111");
    //   }).catchError((error){});
    // }else{
    emit(UpdateUserLoadingState());
   // UploadProfileImage(profileImage: profileImage);
      SocialUserModel model =
       SocialUserModel(
        name: name,
        phone: phone,
        email: email,
        bio: bio,
        uId: CacheHelper.getData(key: 'uId'),
        image:  profileImageUrl,
      );
      FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key: 'uId')).update(model.toMap()).then((value){
        GetUserData();
        print("......................................................");
        emit(UpdateUserSuccessState());
      }).catchError((error){
        emit(UpdateUserErrorState(error));
      });
    }

  }
//}
