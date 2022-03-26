import 'package:flutter/material.dart';
import 'package:revengers/screens/artist/artist_login.dart';
import 'package:revengers/screens/user/user_login.dart';
import 'package:revengers/widgets/roundbutton.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
              ),
              child:
                  Text('Enter as User', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pushNamed(User_Login.routeName);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
              ),
              child: Text('Enter as Artist',
                  style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pushNamed(Artist_Login.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
