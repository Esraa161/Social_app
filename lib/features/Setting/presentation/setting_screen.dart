import 'package:firbaseapp/core/Network/Cache_helper.dart';
import 'package:firbaseapp/features/auth/data/Model/user_model.dart';
import 'package:firbaseapp/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../auth/data/cubit/auth_cubit.dart';
import '../../auth/data/cubit/auth_states.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {},
        builder: (context, state) {

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100), child: const Image(image:  AssetImage("assets/images/User-Avatar-Profile4.png"))),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Color.fromARGB(
                                255, 248, 153, 163)),
                            child:  Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("${CacheHelper.getData(key:'name')}", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17),),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          DefaultCacheManager().emptyCache();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen(
                              )));

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width/3,
                          child: Card(
                            color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.logout,size: 25,color: Color.fromARGB(
                                    255, 248, 153, 163)),
                                Text("Logout",style: TextStyle(
                                  color: Theme.of(context).primaryColor
                                ),)

                              ],
                            ),
                          ),),
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
