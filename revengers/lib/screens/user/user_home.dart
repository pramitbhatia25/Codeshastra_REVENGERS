import 'package:flutter/material.dart';

class User_Home extends StatefulWidget {
  static const routeName = '/user_home';
  const User_Home({Key? key}) : super(key: key);

  @override
  State<User_Home> createState() => _User_HomeState();
}

class _User_HomeState extends State<User_Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ElevatedButton(
        onPressed: () {},
        child: Text('User Home.'),
      )),
    );
  }
}
