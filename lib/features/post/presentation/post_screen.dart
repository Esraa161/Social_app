import 'package:firbaseapp/core/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/data/cubit/auth_cubit.dart';
import '../../auth/data/cubit/auth_states.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Add Post",style: TextStyle(color: KPrimaryColor),),
              leading: Icon(Icons.arrow_back_ios_new_outlined,color: KPinck,),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
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
                ],
              ),
            ),
          );
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                ],
              ),
            ),
          );
        });

  }
}
