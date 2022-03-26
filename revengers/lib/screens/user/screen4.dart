import 'package:flutter/material.dart';
import 'package:revengers/widgets/appBar.dart';

class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Screen4'),
    );
  }
}
