import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:revengers/widgets/appBar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  TextEditingController fileUploaded = TextEditingController();
  TextEditingController bgImage = TextEditingController();
  TextEditingController songName = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String a = "";

  FilePickerResult? image, song;
  String? imagepath;
  String songpath = "";
  Reference? ref;
  Uint8List? imgfileBytes;
  Uint8List? songfileBytes;
  String? imgfileName;
  String? songfileName;
  bool imaageCheck = false;
  bool songcheck = false;
  List<String> genre = ["", "", ""];

  var image_down_url, song_down_url;
  final firestoreinstance = FirebaseFirestore.instance;

  void selectimage() async {
    image = await FilePicker.platform.pickFiles(withData: true);
    if (song != null) {
      print(image!.files.first);
      imgfileBytes = image!.files.first.bytes!;
      imgfileName = image!.files.first.name;

      // Upload file
      //await FirebaseStorage.instance.ref(imgfileName).putData(imgfileBytes!);
    }
  }

  void uploadimagefile(Uint8List? image, String imagepath) async {
    ref = FirebaseStorage.instance.ref().child(imagepath);
    UploadTask uploadTask = ref!.putData(image!);

    image_down_url =
        await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
  }

  void selectsong() async {
    song = await FilePicker.platform.pickFiles(withData: true);
    if (song != null) {
      print(song!.files.first);
      songfileBytes = song!.files.first.bytes!;
      songfileName = song!.files.first.name;

      // Upload file
      //await FirebaseStorage.instance.ref(songfileName).putData(songfileBytes!);
    }
    // setState(() {
    //   //songpath = 'saas';
    //   // if (song?.paths != null) {
    //   //   songpath = basename(song!.paths[0].toString());
    //   //   print(song!.files.single);
    //   //   uploadsongfile(song!.files.single.bytes, songpath);
    //   // }
    // });
    // setState(() {
    //   //song = song;

    //   // songpath = basename(song?.paths.toString());

    // });
  }

  void uploadsongfile(Uint8List? song, String songpath) async {
    ref = FirebaseStorage.instance.ref().child(songpath);
    print(song);
    UploadTask? uploadTask = ref!.putData(song!);

    song_down_url =
        await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
    print(song_down_url);
  }

  _onTapButton(BuildContext context, data) {
    return AlertDialog(title: Text(data));
  }

  finalupload(context) async {
    Map<String, dynamic> songdata = {
      'email': _auth.currentUser!.email,
      'genre': genre,
      'img': FirebaseStorage.instance.ref(imgfileName).getDownloadURL(),
      'owner': _auth.currentUser!.email,
      'price': 0.0001,
      'song_name': songName,
      'song_url': FirebaseStorage.instance.ref(songfileName).getDownloadURL(),
    };
    await FirebaseStorage.instance.ref(imgfileName).putData(imgfileBytes!);
    await FirebaseStorage.instance.ref(songfileName).putData(songfileBytes!);
    await FirebaseFirestore.instance.collection('songs').add(songdata);
    await FirebaseFirestore.instance
        .collection('artist')
        .doc('xUJ0qbqpYQYF0vgTicrH')
        .update({
      'songs_created_name': FieldValue.arrayUnion([songName]),
      'songs_created_url': FieldValue.arrayUnion(
          [FirebaseStorage.instance.ref(songfileName).getDownloadURL()]),
      'songs_owned_name': FieldValue.arrayUnion([songName]),
      'songs_owned_url': FieldValue.arrayUnion(
          [FirebaseStorage.instance.ref(songfileName).getDownloadURL()]),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple,
          title: Text('Creator Studio',
              style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
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
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 250,
                      child: TextField(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            genre[0] = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                            ),
                            fillColor: Colors.transparent,
                            hintText: 'Enter Genre 1',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 2)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Container(
                      width: 250,
                      child: TextField(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            genre[1] = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                            ),
                            fillColor: Colors.transparent,
                            hintText: 'Enter Genre 2',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 2)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      width: 250,
                      child: TextField(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            genre[2] = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                            ),
                            fillColor: Colors.transparent,
                            hintText: 'Enter Genre 3',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 2)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Checkbox(
                        value: songcheck,
                        onChanged: (value) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        checkColor: Colors.purple,
                        activeColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: ElevatedButton.icon(
                          label: Text('Choose MP3 File To Upload',
                              style: TextStyle(fontSize: 15)),
                          icon: Icon(Icons.upload),
                          onPressed: () {
                            selectsong();
                            setState(() {
                              songcheck = true;
                              if (songName.text != "") {
                                fileUploaded.text = songpath;
                              }
                              //else {
                              //     Scaffold.of(context).showSnackBar(
                              //       SnackBar(
                              //         backgroundColor: Colors.purple,
                              //         content: Text('Incorrect Details Entered',
                              //             style: TextStyle(
                              //                 color: Colors.white,
                              //                 letterSpacing: 1.0,
                              //                 fontSize: 15.0,
                              //                 fontWeight: FontWeight.w800)),
                              //         duration: Duration(seconds: 3),
                              //       ),
                              //     );
                              //   }
                              // });
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Center(
                      child: Text(
                    fileUploaded.text,
                    style: TextStyle(color: Colors.white),
                  )
                      // child: TextField(
                      //   style: TextStyle(
                      //       color: Colors.white, fontSize: 15, letterSpacing: 2),
                      //   enabled: false,
                      //   textAlign: TextAlign.center,
                      //   controller: fileUploaded,
                      //   decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //             color: Colors.transparent, width: 2.0),
                      //       ),
                      //       fillColor: Colors.transparent,
                      //       hintText: 'No MP3 file Selected',
                      //       hintStyle: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 15,
                      //           letterSpacing: 2)),
                      // ),
                      ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Checkbox(
                          value: imaageCheck,
                          onChanged: (value) {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          activeColor: Colors.white,
                          checkColor: Colors.purple,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0.0),
                        child: ElevatedButton.icon(
                          label: Text('Choose Background Image To Upload',
                              style: TextStyle(fontSize: 15)),
                          icon: Icon(Icons.upload),
                          onPressed: () {
                            selectimage();
                            setState(() {
                              imaageCheck = true;
                              // a = imagepath;
                              // bgImage.text = imagepath;
                            });
                          },
                        ),
                      ),
                    ],
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
                          hintText: '$a',
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
                        label: Text('Upload', style: TextStyle(fontSize: 15)),
                        icon: Icon(Icons.upload),
                        onPressed: () {
                          finalupload(context);
                          setState(() {
                            // a = imagepath;
                            // bgImage.text = imagepath;
                          });
                        },
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
