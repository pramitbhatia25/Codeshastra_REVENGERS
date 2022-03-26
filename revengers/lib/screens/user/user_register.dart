import 'package:flutter/material.dart';
import 'package:revengers/screens/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/appBar.dart';

class User_Register extends StatefulWidget {
  static const routeName = '/user_register';

  @override
  State<User_Register> createState() => _User_RegisterState();
}

class _User_RegisterState extends State<User_Register> {
  final _auth = FirebaseAuth.instance;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red[400],
      appBar: myAppBar(title: "User Register."),
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
                  hintText: 'Username',
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
                          email: username.text, password: password.text);
                      if (newUSer != null) {
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
