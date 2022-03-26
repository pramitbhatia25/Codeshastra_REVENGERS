import 'package:flutter/material.dart';
import 'package:revengers/screens/artist/artist_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/appBar.dart';

class Artist_Register extends StatefulWidget {
  static const routeName = '/artist_register';
  @override
  State<Artist_Register> createState() => _Artist_RegisterState();
}

class _Artist_RegisterState extends State<Artist_Register> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red[400],
      appBar: myAppBar(title: "Artist Register."),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 200),
            const Text('codeLib 1.0',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'Mogra',
                )),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 40, right: 40),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 40, right: 40),
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      var newUSer = await _auth.createUserWithEmailAndPassword(
                          email: username.toString(),
                          password: password.toString());
                      if (newUSer != null) {
                        Navigator.of(context).pushNamed(Artist_Home.routeName);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Register')),
            )
          ],
        ),
      ),
    );
  }
}
