import 'package:firbaseapp/core/widgets/constants.dart';
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

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // AuthCubit.get(context).GetUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(
                              image: AssetImage(
                                  "assets/images/User-Avatar-Profile4.png",),
                          fit: BoxFit.cover,)),
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
                  child:Column(
                    children: [
                      Row(
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
                      ),
                    ],
                  ) ,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async{
                        await DefaultCacheManager().emptyCache();
                         SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
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
                    ),
                    Spacer()
                  ],
                )
              ],
            ),
          );
        });
  }
}
