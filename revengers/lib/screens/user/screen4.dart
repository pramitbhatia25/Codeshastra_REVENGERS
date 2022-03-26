import 'package:flutter/material.dart';
import 'package:revengers/widgets/appBar.dart';

class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  TextEditingController walletId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text('Wallet',
              style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.green[800]!,
                Colors.green[200]!,
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
                //Let's add some text title
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Your Earnings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, right: 20, left: 20, bottom: 8),
                  child: TextField(
                    controller: walletId,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        fillColor: Colors.transparent,
                        hintText: 'Enter Wallet Id',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2)),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      child: Text('GET Balance'),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.transparent,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
