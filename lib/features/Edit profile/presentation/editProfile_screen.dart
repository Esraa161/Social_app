import 'dart:io';

import 'package:firbaseapp/core/widgets/constants.dart';
import 'package:firbaseapp/features/Edit%20profile/data/cubit/editProfile_cubit.dart';
import 'package:firbaseapp/features/Edit%20profile/data/cubit/editProfile_states.dart';
import 'package:firbaseapp/features/auth/data/cubit/auth_cubit.dart';
import 'package:firbaseapp/features/auth/data/cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
class EditProfileScreen extends StatefulWidget {

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  var _name = TextEditingController();

  var _email = TextEditingController();

  var _phone = TextEditingController();

  var _bio = TextEditingController();

  String basePhoto =
      "http://148.113.1.230:2060/vansales/Emplyee/getimg?imgpath=c:\\company_data\\circle_2_test";

  File? profileimage;
  File? profileimage2;
  XFile? ImageFileProfile;
String? imagePath;
  final picker = ImagePicker();

  Future<void> getProfileImageByGallery() async {
    XFile? imageFileProfile =
    await picker.pickImage(source: ImageSource.gallery);
    if (imageFileProfile == null) return null;
    setState(() {
      imagePath=imageFileProfile.path;
      profileimage = File(imageFileProfile.path);
      ImageFileProfile = imageFileProfile;

    });
  }
  Future<void> getProfileImageByCam() async {
    XFile? imageFileProfile =
    await picker.pickImage(source: ImageSource.camera);
    if (imageFileProfile == null) return;
    setState(() {
      imagePath=imageFileProfile.path;
      profileimage = File(imageFileProfile.path);
      ImageFileProfile = imageFileProfile ;
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
      listener:(context,state){},
    builder: (context,state){
        var model =AuthCubit.get(context).model;
        if(state is UpdateUserLoadingState){
          return Center(child: CircularProgressIndicator());
        }else{
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Profile'),
              leading: Icon(Icons.arrow_back_ios,color: KPinck,),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///EditProfileImage///////////////////////////////////////////////////
                      Center(
                        child: Stack(

                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child:  Image(
                                      image:profileimage==null?NetworkImage("${model?.image}"):FileImage(profileimage!) as ImageProvider,
                                      fit: BoxFit.cover)),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 5,

                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:KPinck,
                                    border: Border.all(
                                        color: Colors.white
                                    )),
                                //Color.fromARGB(255, 248, 153, 163)),
                                child: InkWell(
                                  onTap: (){
                                    showModalBottomSheet<void>(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),),
                                        backgroundColor:Colors.white,
                                        context: context,
                                        builder: (BuildContext context)
                                        {
                                          return SizedBox(
                                            height: 200,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    "Select Photo",
                                                    style: TextStyle(
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          InkWell(
                                                            onTap:()async{
                                                              await getProfileImageByGallery();

                                                              await ImageFileProfile == null ? null : Image.asset("assets/images/profileImage.png");
                                                              Navigator.pop(context);
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 30,
                                                              backgroundColor:
                                                              Colors.white,
                                                              child: Icon(Icons.image_outlined,
                                                                color:KPrimaryColor,),
                                                            ),
                                                          ),
                                                          Text(
                                                            "Gallery",
                                                            style: TextStyle(
                                                                fontSize: 18
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: ()async{
                                                              await getProfileImageByCam();

                                                              await ImageFileProfile == null ? null :Image.asset("assets/images/profileImage.png");
                                                              Navigator.pop(context);
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 30,
                                                              backgroundColor:
                                                              Colors.white,
                                                              child: Icon(Icons.camera,
                                                                color:KPrimaryColor,),
                                                            ),
                                                          ),
                                                          Text(
                                                            "Camira",
                                                            style: TextStyle(
                                                                fontSize: 18
                                                            ),
                                                          ),
                                                        ],
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      ),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Edit Data///////////////////////////////////////////////////////
                      Container(
                        height: MediaQuery.sizeOf(context).height/2,
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: _name,
                              // style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
                              keyboardType: TextInputType.name,
                              autofocus: false,
                              decoration: InputDecoration(

                                // isDense: true,
                                suffixIcon: Icon(Icons.person_outlined,color: KPinck,),
                                hintText: 'Name',
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: KPrimaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: .5, color: Gray), //<-- SEE HERE
                                ),
                                errorBorder: OutlineInputBorder( //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent),
                                ),
                                focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: KPinck),
                                ),
                              ),

                              validator: (String? value) {
                                if (value!
                                    .isEmpty ) {
                                  return "Enter your name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              controller: _bio,
                              maxLines: 3,
                              // style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
                              keyboardType: TextInputType.name,
                              autofocus: false,
                              decoration: InputDecoration(
                                // isDense: true,
                                suffixIcon: Icon(Icons.contact_support_outlined,color: KPinck,),
                                hintText: 'Bio',
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: KPrimaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: .5, color: Gray), //<-- SEE HERE
                                ),
                                errorBorder: OutlineInputBorder( //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent),
                                ),
                                focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: KPinck),
                                ),
                              ),

                              validator: (String? value) {
                                if (value!
                                    .isEmpty ) {
                                  return "Enter your name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.email_outlined,color: KPinck,),
                                hintText: 'Email',
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: KPrimaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: .5, color: Gray), //<-- SEE HERE
                                ),
                                errorBorder: OutlineInputBorder( //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent),
                                ),
                                focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: KPinck),
                                ),
                              ),

                              validator: (String? value) {
                                if (value!
                                    .isEmpty||!RegExp(r'^[\w-\.]+@gmail.com')
                                    .hasMatch(value) ) {
                                  return "Enter your name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              controller: _phone,
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.phone_outlined,color: KPinck,),
                                hintText: 'Phone number',
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: KPrimaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: .5, color: Gray), //<-- SEE HERE
                                ),
                                errorBorder: OutlineInputBorder( //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.redAccent),
                                ),
                                focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1, color: KPinck),
                                ),
                              ),

                              validator: (String? value) {
                                if (value!
                                    .isEmpty ) {
                                  return "Enter your name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),


                           ElevatedButton(
                            style:  ElevatedButton.styleFrom(
                                onPrimary: Colors.black87,
                                //primary: Colors.grey[300],
                                minimumSize: Size(88, 36),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                backgroundColor: KPinck.withOpacity(0.8)
                            ),

                            onPressed: () {

                              // EditProfileCubit.get(context).UploadProfileImage(
                              //     profileImage:profileimage );
                              AuthCubit.get(context).UpdateUser(
                                  name: _name.text,
                                  phone: _phone.text,
                                  email: _email.text,
                                  bio: _bio.text,
                                  profileImage: profileimage );
                              print("pppppppppppppppppppppppppppppppppppp");
                              // EditProfileCubit.get(context).uploadProfileImage(
                              //     profileImage:profileimage );
                              print(imagePath);
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit,color: Colors.white,size: 20,),
                                SizedBox(width: 10,height: 40,),
                                Text('Save',style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),

                      SizedBox(

                      ),


                    ],
                  ),
                ),
              ),
            ),


          );
        }

    },);
  }

}