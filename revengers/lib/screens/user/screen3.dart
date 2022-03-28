import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revengers/screens/user/user_home.dart';
import 'package:revengers/widgets/appBar.dart';

import '../../widgets/song.dart';
import '../user/screen4.dart';

class Screen3 extends StatefulWidget {
  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<Song> songs = [];
  final _cloudfirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    songs.clear();
    super.dispose();
  }

  bool isIn(String? str, values) {
    if (values == null || values.length == 0) {
      return false;
    }

    if (values is List) {
      values = values.map((e) => e.toString()).toList();
    }

    return values.indexOf(str) >= 0;
  }

  Future<void> fetch() async {
    await for (var snapshot
        in _cloudfirestore.collection('songs').snapshots()) {
      for (var message in snapshot.docs) {
        if (isIn(songName.text.toLowerCase(),
            message.data()['song_name'].toString().toLowerCase())) {
          songs.add(Song(
            price: message.data()['price'].toString(),
            email: message.data()['email'].toString(),
            owner: message.data()['owner'].toString(),
            song_name: message.data()['song_name'].toString(),
            song_url: message.data()['song_url'].toString(),
            img_url: message.data()['img'].toString(),
          ));

          setState(() {
            songs = songs;
          });
        }
      }
    }
  }

  TextEditingController songName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple,
          title: Text('Search',
              style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple[800]!,
                  Colors.purple[200]!,
                ]),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: 180,
                        child: TextField(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              letterSpacing: 2),
                          textAlign: TextAlign.center,
                          controller: songName,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                              ),
                              fillColor: Colors.transparent,
                              hintText: 'Enter Song Name',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 2)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        label: Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 18),
                          child: Text('Search', style: TextStyle(fontSize: 15)),
                        ),
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          songs = [];
                          await fetch();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    height: 550,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: songs.map((pd) {
                        return GestureDetector(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => User_Home(
                          //           title: pd.song_name,
                          //           song_url: pd.song_url,
                          //           artist_email: pd.email,
                          //           owned_email: pd.owner,
                          //           logo_url: pd.img_url,
                          //           price: pd.price,
                          //         ),
                          //       ));
                          // },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                      width: 170,
                                      height: 170,
                                      margin: EdgeInsets.only(
                                          top: 30, left: 20, right: 20),
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, top: 20),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(pd.img_url)),
                                        border: Border.all(
                                            color: Colors.black, width: 1.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(child: Text(''))),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      pd.song_name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Screen4(
                                  //               artist_email: pd.email,
                                  //               logo_url: pd.img_url,
                                  //               owned_email: pd.owner,
                                  //               price: pd.price,
                                  //               song_url: pd.song_url,
                                  //               title: pd.song_name,
                                  //             )));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => User_Home(
                                          currentIndex: 3,
                                          title: pd.song_name,
                                          song_url: pd.song_url,
                                          artist_email: pd.email,
                                          owned_email: pd.owner,
                                          logo_url: pd.img_url,
                                          price: pd.price,
                                        ),
                                      ));
                                },
                                child: Text('\nBUY\n\nEth ${pd.price}\n'),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
