import 'package:flutter/material.dart';
import 'package:revengers/screens/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revengers/screens/user/user_register.dart';

import '../../widgets/appBar.dart';

class User_Login extends StatefulWidget {
  static const routeName = '/user_login';

  @override
  State<User_Login> createState() => _User_LoginState();
}

class _User_LoginState extends State<User_Login> {
  final _auth = FirebaseAuth.instance;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[100],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.red,
                Colors.orangeAccent,
                Colors.deepOrange,
                Colors.orangeAccent,
                Colors.red
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 150),
              const Text('Revengers',
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
                        // borderSide: BorderSide(width: 10, color: Colors.white),
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 40, right: 40),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(User_Register.routeName);
                    },
                    child: Text('Register')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
