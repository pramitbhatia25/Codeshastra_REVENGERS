import 'package:flutter/material.dart';
import 'package:revengers/screens/login_screen.dart';
import 'package:revengers/screens/registration_screen.dart';
import 'package:revengers/screens/welcome_screen.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: WelcomeScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
        Home.routeName: (ctx) => Home(),
      },
    );
  }
}
