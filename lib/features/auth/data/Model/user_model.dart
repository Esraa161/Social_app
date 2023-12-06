import 'package:flutter/cupertino.dart';

class SocialUserModel{
   String ?name;
   String ?email;
   String ?phone;
   String?image;
   String ?uId;
    bool ?isEmailVerified;
  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.image,
    this.uId,
    this.isEmailVerified
});
  SocialUserModel.fromJson(Map<String,dynamic>json){
email=json['email'];
name=json['name'];
phone=json['phone'];
image=json['image'];
uId=json['uId'];
isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'image': image,
      'uId':uId,
      'isEmailVerified':isEmailVerified
    };

  }
}