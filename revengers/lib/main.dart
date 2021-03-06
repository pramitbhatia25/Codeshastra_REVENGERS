import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revengers/screens/artist/artist_home.dart';
import 'package:revengers/screens/artist/artist_login.dart';
import 'package:revengers/screens/artist/artist_register.dart';
import 'package:revengers/screens/user/user_home.dart';
import 'package:revengers/screens/user/user_login.dart';
import 'package:revengers/screens/user/user_register.dart';
import 'package:revengers/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:revengers/widgets/audio_player.dart';
import 'widgets/audio_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context)
              .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
        primarySwatch: Colors.purple,
      ),
      home: WelcomeScreen(),
      routes: {
        // PlayerNew.routename: (context) => PlayerNew(),
        User_Login.routeName: (ctx) => User_Login(),
        WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
        User_Register.routeName: (ctx) => User_Register(),
        User_Home.routeName: (ctx) => User_Home(
            currentIndex: 0,
            title: "",
            artist_email: "",
            logo_url: "",
            price: "",
            owned_email: "",
            song_url: ""),
        Artist_Login.routeName: (ctx) => Artist_Login(),
        Artist_Register.routeName: (ctx) => Artist_Register(),
        Artist_Home.routeName: (ctx) => Artist_Home(
            title: "",
            artist_email: "",
            logo_url: "",
            price: "",
            owned_email: "",
            song_url: ""),
      },
    );
  }
}
