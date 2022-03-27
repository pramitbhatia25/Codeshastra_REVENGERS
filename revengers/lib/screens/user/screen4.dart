import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revengers/widgets/appBar.dart';

import '../../widgets/song.dart';

class Screen4 extends StatefulWidget {
  String title = "Default";
  String logo_url = "Default";
  String song_url = "Default";
  String artist_email = "Default";
  String owned_email = "Default";
  String price = "Default";

  Screen4({
    required this.title,
    required this.logo_url,
    required this.song_url,
    required this.artist_email,
    required this.owned_email,
    required this.price,
  });

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  TextEditingController walletId = TextEditingController();
  final _cloudfirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  Future<void> buy() async {
    // var snapshots = _cloudfirestore.collection('songs').snapshots();

    // await snapshots.forEach((document) async {
    //   document.reference.updateData(<String, dynamic>{
    //     'owner': loggedInUser?.email.toString(),
    //   });
    // });

    await for (var snapshot
        in _cloudfirestore.collection('songs').snapshots()) {
      for (var message in snapshot.docs) {
        if (message.data()['song_name'] == widget.title.toString()) {
          message.data()['owner'] = loggedInUser?.email.toString();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text('Wallet',
              style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.green[800]!,
                Colors.green[200]!,
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                //Let's add some text title
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Your Earnings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, right: 20, left: 20, bottom: 8),
                  child: TextField(
                    controller: walletId,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        fillColor: Colors.transparent,
                        hintText: 'Enter Wallet Id',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2)),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      child: Text('GET Balance'),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.transparent,
                      )),
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                            height: 150,
                            width: 150,
                            margin:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget.logo_url)),
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text(''))),
                        SizedBox(height: 10),
                        Text(widget.title),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () async {
                        await buy();
                      },
                      child: Text('\nBUY\n\nEth ${widget.price}\n'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
