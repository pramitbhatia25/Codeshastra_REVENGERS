import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:revengers/widgets/appBar.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  TextEditingController fileUploaded = TextEditingController();
  TextEditingController bgImage = TextEditingController();
  TextEditingController songName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple,
          title: Text('Creator Studio',
              style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
      body: Container(
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
                Center(
                  child: Container(
                    width: 250,
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white, fontSize: 15, letterSpacing: 2),
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
                SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: ElevatedButton.icon(
                      label: Text('Choose MP3 File To Upload',
                          style: TextStyle(fontSize: 15)),
                      icon: Icon(Icons.upload),
                      onPressed: () {
                        setState(() {
                          if (songName.text != "") {
                            fileUploaded.text = "Gabba gabba gabba";
                          } else {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.purple,
                                content: Text('Incorrect Details Entered',
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1.0,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w800)),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ),
                ),
                Center(
                  child: TextField(
                    style: TextStyle(
                        color: Colors.white, fontSize: 15, letterSpacing: 2),
                    enabled: false,
                    textAlign: TextAlign.center,
                    controller: fileUploaded,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 2.0),
                        ),
                        fillColor: Colors.transparent,
                        hintText: 'No MP3 file Selected',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 2)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: ElevatedButton.icon(
                      label: Text('Choose Background Image To Upload',
                          style: TextStyle(fontSize: 15)),
                      icon: Icon(Icons.upload),
                      onPressed: () {
                        setState(() {
                          bgImage.text = "Gabba gabba gabba";
                        });
                      },
                    ),
                  ),
                ),
                Center(
                  child: TextField(
                    style: TextStyle(
                        color: Colors.white, fontSize: 15, letterSpacing: 2),
                    enabled: false,
                    textAlign: TextAlign.center,
                    controller: bgImage,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 2.0),
                        ),
                        fillColor: Colors.transparent,
                        hintText: 'No Image Selected',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 2)),
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
