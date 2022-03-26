import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revengers/screens/artist/artist_home.dart';
import 'package:revengers/screens/user/user_home.dart';

class Artist_Login extends StatefulWidget {
  static const routeName = '/artist_login';
  @override
  State<Artist_Login> createState() => _Artist_LoginState();
}

class _Artist_LoginState extends State<Artist_Login> {
  final _auth = FirebaseAuth.instance;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red[400],
      appBar: AppBar(title: Text("revengers")),
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
                keyboardType: TextInputType.emailAddress,
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
                keyboardType: TextInputType.number,
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
                      final user = await _auth.signInWithEmailAndPassword(
                        email: username.text,
                        password: password.text,
                      );
                      if (user != null) {
                        Navigator.of(context).pushNamed(User_Home.routeName);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Login')),
            )
          ],
        ),
      ),
    );
  }
}
