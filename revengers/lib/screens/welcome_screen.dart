import 'package:flutter/material.dart';
import 'package:revengers/screens/user_login.dart';
import 'package:revengers/widgets/roundbutton.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundButton(
              color: Colors.blueAccent,
              text: 'Enter as User',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserLoginScreen()));
              },
            ),
            RoundButton(
              color: Colors.blueAccent,
              text: 'Enter as Artist',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArtistLoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
