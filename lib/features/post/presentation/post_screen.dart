import 'dart:io';

import 'package:firbaseapp/core/widgets/constants.dart';
import 'package:firbaseapp/features/post/data/cubit/post_cubit.dart';
import 'package:firbaseapp/features/post/data/cubit/post_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/data/cubit/auth_cubit.dart';
import '../../auth/data/cubit/auth_states.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var _text = TextEditingController();
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
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context).GetUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {},
        builder: (context, state) {
          if(state is GetUserLoadingState)
            {
              return Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: KPinck,
                  ),
                ),
              ),
            );}else{
            return Scaffold(
              appBar: AppBar(
                title: Text("Create Post",style: TextStyle(color: KPrimaryColor),),
                leading: Icon(Icons.arrow_back_ios_new_outlined,color: KPinck,),
                actions: [
                BlocConsumer<PostCubit, PostStates>(
                listener: (context, state) async {},
                 builder: (context, state) {
                  return  TextButton(onPressed: (){
                    PostCubit.get(context).UploadPostImage(
                        dateTime: "20:1",
                        text: _text.text,
                        postImage:  profileimage );
                  },
                      child: Text("Post",style: TextStyle(color: KPinck,fontSize: 17),));
                 })]
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:  Image(
                                  image: NetworkImage(
                                      '${AuthCubit.get(context).model?.image }'),
                                  fit: BoxFit.cover,)),
                          ),
                          Column(
                            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AuthCubit.get(context).model?.name ?? "nulll",
                                  style: TextStyle(
                                      color: KPrimaryColor, fontSize: 17,height: 1),
                                ),
                              ),
                              Text(
                                AuthCubit.get(context).model?.bio ?? "nulll",
                                style: TextStyle(
                                    color: Gray, fontSize: 12,height: .5),
                              ),

                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLines: 6,
                          controller:_text,
                          decoration: InputDecoration(
                            hintText: "What is in your mind ......",
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
                            border: InputBorder.none,
                          ),

                        ),
                      ),
                      profileimage==null?Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height/2.5,
                      ):
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height/2.5,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child:  Image(
                                          image:FileImage(profileimage!) as ImageProvider,
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.red.shade900,
                                maxRadius: 20,
                                child: IconButton(onPressed:(){
                                  setState(() {
                                    profileimage=null;
                                  });
                                },
                                  icon: Icon(Icons.delete,color:Colors.white,),),
                              ),
                            ],
                          ),


                      Row(
                        children: [
                          Expanded(
                            child: TextButton(onPressed: (){
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

                                                       // await ImageFileProfile == null ? null : Image.asset("assets/images/profileImage.png");
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

                                                       // await ImageFileProfile == null ? null :Image.asset("assets/images/profileImage.png");
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
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined,color: KPinck,),
                                    SizedBox(width: 5,),
                                    Text("Add photo",style: TextStyle(color: KPinck),)
                                  ],
                                )),
                          ),
                          Expanded(
                            child: TextButton(onPressed: (){},
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.tag,color: KPinck,),
                                    SizedBox(width: 5,),
                                    Text("Tags",style: TextStyle(color: KPinck),)
                                  ],
                                )),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            );
          }


        });

  }
}
