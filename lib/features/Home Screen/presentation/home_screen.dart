import 'package:firbaseapp/core/widgets/constants.dart';
import 'package:firbaseapp/features/Chats/presentation/chats_screen.dart';
import 'package:firbaseapp/features/Home/presentation/home.dart';
import 'package:firbaseapp/features/Setting/presentation/setting_screen.dart';
import 'package:firbaseapp/features/Users/presentation/users_screen.dart';
import 'package:firbaseapp/features/post/presentation/post_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
int _currentIndex = 0;

final List<Widget> _screens = [
  Home(),
  ChatsScreen(),
  PostScreen(),
  UsersScreen(),
  SettingScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          backgroundColor: KPrimaryColor,
          //Color.fromARGB(202, 36, 30, 98),
          title: Row(
            children: [
              Icon(Icons.dehaze_rounded,color:KPinck,),
              Spacer(),
              Icon(Icons.notifications,color: KPinck,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search,color:KPinck,),
              ),

            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
       //backgroundColor: Colors.white,
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(

          backgroundColor: Color.fromARGB(202, 36, 30, 98),
          elevation: 5,
          unselectedItemColor: Colors.grey,
          selectedItemColor: KPrimaryColor,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {

              if(index==2){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const PostScreen()),
                );
              }else{
                _currentIndex = index;
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );

  }
}

