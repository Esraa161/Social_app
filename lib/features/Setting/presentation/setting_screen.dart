import 'package:firbaseapp/core/widgets/constants.dart';
import 'package:firbaseapp/features/Edit%20profile/presentation/editProfile_screen.dart';
import 'package:firbaseapp/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/data/cubit/auth_cubit.dart';
import '../../auth/data/cubit/auth_states.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}
bool isLoading=false;
class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthCubit.get(context).GetUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if(state is GetUserLoadingState){
            setState(() {
              isLoading=true;
            });

          }else{
            setState(() {
              isLoading=false;
            });
          }
        },
        builder: (context, state) {
          if(state is GetUserLoadingState){
           return Center(
              child: CircularProgressIndicator(
                color:  KPinck,
              ));
          }else{
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:  Image(
                                image: NetworkImage(
                                    '${AuthCubit.get(context).model?.image }'),
                                fit: BoxFit.cover,)),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AuthCubit.get(context).model?.name ?? "nulll",
                                style: TextStyle(
                                    color: KPrimaryColor, fontSize: 17),
                              ),
                            ),
                            Text(
                              AuthCubit.get(context).model?.bio ?? "nulll",
                              style: TextStyle(
                                  color: Gray, fontSize: 12),
                            ),

                          ],
                        )
                      ],
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfileScreen()),

                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit,color: Colors.white,size: 20,),
                          SizedBox(width: 10,),
                          Text('Edit profile',style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow:[BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),]


                      ),
                      child:Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.email,color: Color.fromARGB(255, 248, 153, 163),size: 18,),
                                maxRadius: 15,
                                backgroundColor: Color.fromARGB(255, 248, 153, 163).withOpacity(0.2),),
                              Text( AuthCubit.get(context).model?.email ?? "nulll",)
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.phone,color: Color.fromARGB(255, 248, 153, 163),size: 18,),
                                maxRadius: 15,
                                backgroundColor: Color.fromARGB(255, 248, 153, 163).withOpacity(0.2),),
                              Text( AuthCubit.get(context).model?.phone ?? "nulll",)
                            ],
                          )
                        ],
                      ) ,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow:[BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),]


                      ),
                      child:Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircleAvatar(
                              child: Icon(Icons.language,color: Color.fromARGB(255, 248, 153, 163),size: 18,),
                              maxRadius: 15,
                              backgroundColor: Color.fromARGB(255, 248, 153, 163).withOpacity(0.2),),
                          ),
                          Text( "Language",)
                        ],
                      ) ,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () async{
                        await DefaultCacheManager().emptyCache();
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false,
                        );

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow:[BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                maxRadius: 15,
                                backgroundColor: Color.fromARGB(255, 248, 153, 163).withOpacity(0.2),
                                child: Icon(Icons.logout,
                                    size:18,
                                    color: Color.fromARGB(255, 248, 153, 163)),
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

        });
  }
}
