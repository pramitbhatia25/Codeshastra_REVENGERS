import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:revengers/screens/user/screen1.dart';
import 'package:revengers/screens/user/screen2.dart';
import 'package:revengers/screens/user/screen3.dart';

class User_Home extends StatefulWidget {
  const User_Home({Key? key}) : super(key: key);
  static const routeName = '/user_home';
  @override
  State<User_Home> createState() => _User_HomeState();
}

class _User_HomeState extends State<User_Home> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        //backgroundColor: ,
        backgroundColor: Colors.white,
        items: [
          BottomNavyBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.orange,
            ),
            title: Text('Home'),
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.play_arrow,
              color: Colors.orange,
            ),
            title: Text('Playing'),
          ),
          BottomNavyBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.orange,
              ),
              title: Text('Search')),
          BottomNavyBarItem(
              icon: Icon(
                Icons.money,
                color: Colors.orange,
              ),
              title: Text('Wallet')),
        ],
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            Screen1(),
            Screen2(),
            Screen3(),
          ],
        ),
      ),
    );
  }
}
