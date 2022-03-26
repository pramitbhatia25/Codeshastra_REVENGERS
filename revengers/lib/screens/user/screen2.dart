import 'package:flutter/material.dart';
import 'package:revengers/widgets/appBar.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Screen2'),
    );
  }
}
