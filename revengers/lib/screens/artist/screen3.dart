import 'package:flutter/material.dart';
import 'package:revengers/widgets/appBar.dart';
import 'package:revengers/widgets/upload_function.dart';
// import 'dart:html';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
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
  FilePickerResult? image, song;
  String? imagepath, songpath;
  Reference? ref;
  var image_down_url, song_down_url;
  final firestoreinstance = FirebaseFirestore.instance;

  void selectimage() async {
    image = await FilePicker.platform.pickFiles();

    setState(() {
      image = image;
      imagepath = basename(image!.paths.toString());
      uploadimagefile(image?.files.first.bytes, imagepath!);
    });
  }

  void uploadimagefile(Uint8List? image, String imagepath) async {
    ref = FirebaseStorage.instance.ref().child(imagepath);
    UploadTask uploadTask = ref!.putData(image!);

    image_down_url =
        await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
  }

  void selectsong() async {
    song = await FilePicker.platform.pickFiles();

    setState(() {
      song = song;
      songpath = basename(song!.paths.toString());
      uploadsongfile(song!.files.first.bytes, songpath!);
    });
  }

  void uploadsongfile(Uint8List? song, String songpath) async {
    ref = FirebaseStorage.instance.ref().child(songpath);
    UploadTask uploadTask = ref!.putData(song!);

    song_down_url =
        await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
  }

  finalupload(context) {
    if (songName.text != '' &&
        song_down_url != null &&
        image_down_url != null) {
      print(songName.text);
      print(song_down_url);
      print(image_down_url.toString());

      var data = {'details': {}};

      firestoreinstance.collection("songs").doc('tIH7UbUSFBNWBy2uhXQh').update({
        'songs_created_name': FieldValue.arrayUnion([songName]),
        'songs_created_url': FieldValue.arrayUnion([song_down_url]),
        'songs_owned_url': FieldValue.arrayUnion([song_down_url]),
        'songs_owned_name': FieldValue.arrayUnion([songName]),
      }).whenComplete(() => showDialog(
            context: context,
            builder: (context) =>
                _onTapButton(context, "Files Uploaded Successfully :)"),
          ));
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            _onTapButton(context, "Please Enter All Details :("),
      );
    }
  }

  _onTapButton(BuildContext context, data) {
    return AlertDialog(title: Text(data));
  }

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
                          hintText: 'Enter Song Name: ',
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
                            selectsong();
                            fileUploaded.text = songpath!;
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
                          selectimage();
                          bgImage.text = imagepath!;
                        });
                      },
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: ElevatedButton.icon(
                      label: Text('Create NFT', style: TextStyle(fontSize: 15)),
                      icon: Icon(Icons.upload),
                      onPressed: () {
                        setState(() {
                          firestoreinstance
                              .collection("songs")
                              .doc('tIH7UbUSFBNWBy2uhXQh')
                              .update({
                            'songs_created_name':
                                FieldValue.arrayUnion([songName]),
                            'songs_created_url':
                                FieldValue.arrayUnion([song_down_url]),
                            'songs_owned_url':
                                FieldValue.arrayUnion([song_down_url]),
                            'songs_owned_name':
                                FieldValue.arrayUnion([songName]),
                          }).whenComplete(() => showDialog(
                                    context: context,
                                    builder: (context) => _onTapButton(context,
                                        "Files Uploaded Successfully :)"),
                                  ));
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
