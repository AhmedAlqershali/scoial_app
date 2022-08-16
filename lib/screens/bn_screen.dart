
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoial_app/screens/post_screen.dart';
import 'package:scoial_app/screens/profile_screen.dart';

import '../models/bn_screen_item.dart';
import 'chats_screen.dart';
import 'home_screen.dart';

class BnScreen extends StatefulWidget {
  const BnScreen({Key? key}) : super(key: key);

  @override
  State<BnScreen> createState() => _BnScreenState();
}

class _BnScreenState extends State<BnScreen> {
  int _currentIndex = 0;
  final List<BnItem> _bnScreens = <BnItem>[
     BnItem(widget: HomeScreen(), title: 'Home' ),
     BnItem(widget:ChatsScreen() , title: 'Chat'),
    BnItem(widget: PostScreen(), title: 'add Post'),
     BnItem(widget: ProfileScreen(), title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        

        appBar:
          AppBar(

          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            if(_currentIndex!=2)
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active_outlined)),
            if(_currentIndex!=2)
              IconButton(onPressed: (){}, icon: Icon(Icons.search)),


          ],

        iconTheme: const IconThemeData(color: Colors.black),
    title: Text(
    _bnScreens[_currentIndex].title,
    style: GoogleFonts.nunito(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    ),
      ),
        ),


      body: _bnScreens[_currentIndex].widget,


      bottomNavigationBar:bottomNavigationBar() ,









    );
  }




  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text('Home'),
            ),
            label: '',
            icon: Icon(Icons.home)

        ),


        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text('Chats'),
            ),
            label: '',

            icon: Icon(Icons.chat)

        ),
        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text('Post'),
            ),
            label: '',

            icon: Icon(Icons.post_add)

        ),





        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text('Profile'),
            ),
            label: '',
            icon: Icon(Icons.person)

        ),
      ],
      onTap: (int itemIndex) {
        setState(() {
          _currentIndex = itemIndex;
        });
      },
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }


}
