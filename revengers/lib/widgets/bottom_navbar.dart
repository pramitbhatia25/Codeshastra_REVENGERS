import 'package:flutter/material.dart';
import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({Key? key}) : super(key: key);

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavBar(
        items: [
          BottomNavBarItem(
            icon: Icon(Icons.home),
            title: 'Home',
            activeColor: Colors.orange,
            inactiveColor: Colors.white,
            activeBackgroundColor: Colors.white,
          ),
          BottomNavBarItem(
            icon: Icon(Icons.person),
            title: 'My Profile',
            activeColor: Colors.orange,
            inactiveColor: Colors.white,
            activeBackgroundColor: Colors.white,
          ),
          BottomNavBarItem(
            icon: Icon(FontAwesomeIcons.search),
            title: 'Search',
            activeColor: Colors.orange,
            inactiveColor: Colors.white,
            activeBackgroundColor: Colors.white,
          ),
          BottomNavBarItem(
            icon: Icon(FontAwesomeIcons.moneyBill),
            title: 'Earnings',
            activeColor: Colors.orange,
            inactiveColor: Colors.white,
            activeBackgroundColor: Colors.white,
          ),
        ],
        showElevation: true,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
        });
  }
}
