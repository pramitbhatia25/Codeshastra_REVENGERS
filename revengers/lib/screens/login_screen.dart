import 'package:flutter/material.dart';
import 'package:revengers/widgets/roundbutton.dart';

class ArtistLoginScreen extends StatefulWidget {
  const ArtistLoginScreen({Key? key}) : super(key: key);

  @override
  State<ArtistLoginScreen> createState() => _ArtistLoginScreenState();
}

class _ArtistLoginScreenState extends State<ArtistLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundButton(color: Colors.blue, text: 'Login', onPressed: () {}),
            ]),
      ),
    );
  }
}
