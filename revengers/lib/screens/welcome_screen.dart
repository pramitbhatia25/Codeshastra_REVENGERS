import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:revengers/screens/artist/artist_login.dart';
import 'package:revengers/screens/user/user_login.dart';
import 'package:revengers/widgets/roundbutton.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red[400],
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
            children: [
              SizedBox(
                height: 150,
              ),
              const Text('muse-FT',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                    fontFamily: 'Mogra',
                  )),
              // Container(
              //   height: 150,
              //   width: 150,
              //   child: Lottie.asset('../assets/lottie/continuePage.json',
              //       height: 150),
              // ),
              Lottie.asset('assets/lottie/artistPage.json',
                  height: 200.0), //lottie
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        topLeft: Radius.circular(60)),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 40.0, right: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(User_Login.routeName);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, bottom: 15),
                                    child: Text('Enter As User',
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
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 40.0, right: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(Artist_Login.routeName);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, bottom: 15),
                                    child: Text('Enter As Artist',
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
            ],
          ),
        ),
      ),
    );
  }
}
