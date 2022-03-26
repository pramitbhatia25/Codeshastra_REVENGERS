import 'package:flutter/material.dart';
import 'package:revengers/widgets/appBar.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Screen3'),
    );
  }
}
