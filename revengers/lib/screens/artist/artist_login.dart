import 'package:flutter/material.dart';
import 'package:revengers/screens/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revengers/screens/user/user_register.dart';

import '../../widgets/appBar.dart';
import 'artist_home.dart';
import 'artist_register.dart';

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
      backgroundColor: Colors.orange[100],
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
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
                        // borderSide: BorderSide(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Artist Email',
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
                    hintText: 'Artist Password',
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 40.0, right: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                email: username.text,
                                password: password.text,
                              );
                              if (user != null) {
                                Navigator.of(context)
                                    .pushNamed(Artist_Home.routeName);
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15),
                            child: Text('Login As Artist',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                )),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: Colors.orange[100],
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 60.0, right: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Artist_Register.routeName);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15),
                            child: Text('Sign Up!',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                )),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: Colors.orange[100],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
