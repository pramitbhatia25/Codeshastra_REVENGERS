import 'package:flutter/material.dart';
import 'package:revengers/widgets/appBar.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<String> songs = ["Uptown Funk", "Shakira"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
          title:
              Text('Home', style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
      body: Container(
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
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: songs.map((pd) {
                        return Container(
                            width: 150,
                            margin:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text("Song")));
                      }).toList(),
                    ),
                  ),
                ),
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
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: songs.map((pd) {
                        return Container(
                            width: 150,
                            margin:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text("Song")));
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
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: songs.map((pd) {
                        return Container(
                            width: 150,
                            margin:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text("Song")));
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
