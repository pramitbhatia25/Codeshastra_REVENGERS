import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revengers/screens/artist/artist_home.dart';
import 'package:revengers/widgets/appBar.dart';

import '../../widgets/song.dart';
import '../welcome_screen.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<Song> songs = [];
  List<Song> owner_songs = [];
  List<Song> created_songs = [];
  final _cloudfirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    fetch();
    fetchOwner();
    fetchCreated();
    super.initState();
  }

  @override
  void dispose() {
    songs.clear();
    owner_songs.clear();
    created_songs.clear();
    super.dispose();
  }

  Future<void> fetch() async {
    try {
      final user = await _auth.currentUser;
      if (user != Null) {
        loggedInUser = user;
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }

    await for (var snapshot
        in _cloudfirestore.collection('songs').snapshots()) {
      for (var message in snapshot.docs) {
        if (message.data()['owner'].toString() !=
            loggedInUser!.email.toString()) {
          songs.add(Song(
            email: message.data()['email'].toString(),
            price: message.data()['price'].toString(),
            owner: message.data()['owner'].toString(),
            song_name: message.data()['song_name'].toString(),
            song_url: message.data()['song_url'].toString(),
            img_url: message.data()['img'].toString(),
          ));
        }

        setState(() {
          songs = songs;
        });
      }
    }
  }

  Future<void> fetchOwner() async {
    try {
      final user = await _auth.currentUser;
      if (user != Null) {
        loggedInUser = user;
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }

    await for (var snapshot
        in _cloudfirestore.collection('songs').snapshots()) {
      for (var message in snapshot.docs) {
        if (message.data()['owner'].toString() ==
            loggedInUser!.email.toString()) {
          owner_songs.add(Song(
            email: message.data()['email'].toString(),
            owner: message.data()['owner'].toString(),
            song_name: message.data()['song_name'].toString(),
            price: message.data()['price'].toString(),
            song_url: message.data()['song_url'].toString(),
            img_url: message.data()['img'].toString(),
          ));
        }

        setState(() {
          owner_songs = owner_songs;
        });
      }
    }
  }

  Future<void> fetchCreated() async {
    try {
      final user = await _auth.currentUser;
      if (user != Null) {
        loggedInUser = user;
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }

    await for (var snapshot
        in _cloudfirestore.collection('songs').snapshots()) {
      for (var message in snapshot.docs) {
        if (message.data()['email'].toString() ==
            loggedInUser!.email.toString()) {
          created_songs.add(Song(
            email: message.data()['email'].toString(),
            owner: message.data()['owner'].toString(),
            song_name: message.data()['song_name'].toString(),
            song_url: message.data()['song_url'].toString(),
            img_url: message.data()['img'].toString(),
            price: message.data()['price'].toString(),
          ));
        }

        setState(() {
          created_songs = created_songs;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).pushNamed(WelcomeScreen.routeName);
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
          title:
              Text('Home', style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange[800]!,
                  Colors.orange[200]!,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Owned Songs",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: owner_songs.map((pd) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Artist_Home(
                                      title: pd.song_name,
                                      song_url: pd.song_url,
                                      artist_email: pd.email,
                                      owned_email: pd.owner,
                                      logo_url: pd.img_url,
                                      price: pd.price,
                                    ),
                                  ));
                            },
                            child: Column(
                              children: [
                                Container(
                                    height: 150,
                                    width: 150,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(pd.img_url)),
                                      border: Border.all(
                                          color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Text(''))),
                                SizedBox(height: 10),
                                Text(pd.song_name),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Created Songs",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: created_songs.map((pd) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Artist_Home(
                                      title: pd.song_name,
                                      song_url: pd.song_url,
                                      artist_email: pd.email,
                                      owned_email: pd.owner,
                                      logo_url: pd.img_url,
                                      price: pd.price,
                                    ),
                                  ));
                            },
                            child: Column(
                              children: [
                                Container(
                                    width: 150,
                                    height: 150,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(pd.img_url)),
                                      border: Border.all(
                                          color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Text(''))),
                                SizedBox(height: 10),
                                Text(pd.song_name),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Availaible Songs",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: songs.map((pd) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Artist_Home(
                                      title: pd.song_name,
                                      song_url: pd.song_url,
                                      artist_email: pd.email,
                                      owned_email: pd.owner,
                                      logo_url: pd.img_url,
                                      price: pd.price,
                                    ),
                                  ));
                            },
                            child: Column(
                              children: [
                                Container(
                                    width: 150,
                                    height: 150,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(pd.img_url)),
                                      border: Border.all(
                                          color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Text(''))),
                                Text(pd.song_name),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
