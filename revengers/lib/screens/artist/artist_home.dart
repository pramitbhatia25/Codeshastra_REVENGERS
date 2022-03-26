import 'package:flutter/material.dart';

class Artist_Home extends StatefulWidget {
  static const routeName = '/artist_home';

  const Artist_Home({Key? key}) : super(key: key);

  @override
  State<Artist_Home> createState() => _Artist_HomeState();
}

class _Artist_HomeState extends State<Artist_Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ElevatedButton(
        onPressed: () {},
        child: Text('Artist Home.'),
      )),
    );
  }
}
