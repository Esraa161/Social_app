import 'package:firbaseapp/core/widgets/constants.dart';
import 'package:flutter/material.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post",style: TextStyle(color: KPrimaryColor),),
        leading: Icon(Icons.arrow_back_ios_new_outlined,color: KPinck,),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
