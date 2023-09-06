import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbaseapp/features/auth/data/Model/user_model.dart';
import 'package:firbaseapp/features/auth/data/cubit/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/Network/cach_helper.dart';
class AuthCubit extends Cubit<AuthState>{
  AuthCubit():super(RegisterInitialState());
  static AuthCubit get (context)=>BlocProvider.of(context);

  void Register(
      {
        required String email,
        required String password,
        required String name,
        required String phone
      }
      ){
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value){
          print(value.user!.email);
          print(value.user!.uid);
          UserCreate(
              name: name,
              email: email,
              phone: phone,
              uId: value.user!.uid);

    }).catchError((error){
      emit(RegisterErrorState(error!));
    });
  }
  SocialUserModel?socialUserModel;
  void UserCreate(
      {
        required String name,
        required String email,
        required String phone,
        required String uId,
      }
      ){
    emit(CreatUserLoadingState());
    SocialUserModel model =SocialUserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId
    );
    FirebaseFirestore.instance
        .collection('users').
    doc(uId).set(
      model.toMap()).then((value){
        emit(RegisterSuccessState());
        emit(CreatUserSuccessState());
    }).catchError((error){
      emit(CreatUserErrorState(error));
    });
    }



  void Login(
      {
        required String email,
        required String password,
      }
      ){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      saveToken(value.user!.uid);
      emit(LoginSuccessState());
    }).catchError((error){
      emit(LoginErrorState(error!));
    });
  }

}


