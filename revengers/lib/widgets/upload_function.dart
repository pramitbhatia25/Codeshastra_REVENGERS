import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController songname = TextEditingController();
  TextEditingController artistname = TextEditingController();

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
    if (songname.text != '' &&
        song_down_url != null &&
        image_down_url != null) {
      print(songname.text);
      print(artistname.text);
      print(song_down_url);
      print(image_down_url.toString());

      var data = {'details': {}};

      firestoreinstance.collection("songs").doc('xUJ0qbqpYQYF0vgTicrH').update({
        'song_created': FieldValue.arrayUnion([
          {"name": song_down_url}
        ]),
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
    return Container();
  }
}
