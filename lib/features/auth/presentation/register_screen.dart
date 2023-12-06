import 'package:firbaseapp/core/widgets/constants.dart';
import 'package:firbaseapp/features/auth/data/cubit/auth_cubit.dart';
import 'package:firbaseapp/features/auth/data/cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Home Screen/presentation/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  var _NameController = TextEditingController();
  var _Email = TextEditingController();
  var _Password = TextEditingController();
  var _Phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) async {
      if (state is RegisterSuccessState) {
        Fluttertoast.showToast(
            msg: "Registration has been completed",
            textColor: Colors.white,
            backgroundColor: Colors.green);
      }
      if(state is CreatUserSuccessState){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
        );
      }
      if(state is RegisterErrorState){
        Fluttertoast.showToast(
            msg: "There is a problem registerring",
            backgroundColor: Colors.red);
      }
    },
        builder: (context, state) {

        return Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 130,
              centerTitle: true,
              backgroundColor: KPrimaryColor,
              title: Column(
                children: [
                  Text(
                    "REGISTER",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Register now to communicate with friends",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
              ),
            ),

            body:state is RegisterLoadingState?
            Center(
            child: CircularProgressIndicator(),
        ): SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _NameController,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.person),
                          hintText: 'User Name',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Enter Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _Email,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.email_outlined),
                          hintText: 'Email',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        validator: (String? value) {
                          if (value!
                              .isEmpty || /*RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)||*/
                              !RegExp(r'^[\w-\.]+@gmail.com').hasMatch(value)) {
                            return "Enter Correct email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _Password,
                        obscureText: _obscureText,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          hintText: 'Password',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _Phone,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.phone),
                          hintText: 'Phone',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        validator: (String? value) {
                          if (value!
                              .isEmpty || /*RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)||*/
                              value.length != 11) {
                            return "Enter Correct phone number";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),

                      Center(
                        child: InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              AuthCubit.get(context).Register(
                                  email: _Email.text,
                                  password: _Password.text,
                                phone: _Phone.text ,
                                name: _NameController.text
                              );

                              AuthCubit.get(context).GetUserData();
                            }
                          },
                          child: Container(
                            width: 300,
                            height: MediaQuery.of(context).size.height / 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 10,
                                      color: Colors.grey),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    //Colors.blue.shade200,
                                   KPrimaryColor,
                                    Color.fromARGB(152, 209, 157, 222),
                                   KPrimaryColor,
                                  ],
                                )),
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:11,
                          ),),
                        Text("   REGISTER",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize:11,
                          ),),
                      ],
                    ),
                  )*/
                      SizedBox()
                    ],
                  ),
                ),
              ),
            ));


    });

  }
}

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      child: LayoutBuilder(builder: (context, constraint) {
        final width = constraint.maxWidth * 10;
        return ClipRect(
          child: OverflowBox(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
            child: SizedBox(
              width: width,
              height: width,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 2,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 10.0)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
