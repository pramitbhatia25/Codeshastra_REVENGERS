import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:revengers/screens/user/screen2.dart';
import 'package:revengers/screens/user/screen3.dart';
import 'package:revengers/screens/user/screen4.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:revengers/widgets/appBar.dart';

class User_Home extends StatefulWidget {
  String title = "Default";
  String logo_url = "Default";
  String song_url = "Default";
  String artist_email = "Default";
  String owned_email = "Default";

  User_Home({
    required this.title,
    required this.logo_url,
    required this.song_url,
    required this.artist_email,
    required this.owned_email,
  });
  static const routeName = '/user_home';
  @override
  State<User_Home> createState() => _User_HomeState();
}

class _User_HomeState extends State<User_Home> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  bool playing = false; // at the begining we are not playing any song
  IconData playBtn = Icons.play_arrow; // the main state of the play button icon

  //Now let's start by creating our music player
  //first let's declare some object
  AudioPlayer? _player;
  AudioCache? cache;

  Duration position = new Duration();
  Duration musicLength = new Duration(seconds: 100);

  //we will create a custom slider

  Widget slider() {
    return Container(
      width: 280.0,
      child: Slider.adaptive(
          activeColor: Colors.blue[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            setState(() {
              seekToSec(value.toInt());
            });
          }),
    );
  }

  //let's create the seek function that will allow us to go to a certain position of the music
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player?.seek(newPos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    // cache = AudioCache(fixedPlayer: _player);

    _player?.onAudioPositionChanged.listen((Duration p) =>
        {print('Current position: $p'), setState(() => position = p)});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: BottomNavyBar(
          //backgroundColor: ,
          backgroundColor: Colors.white,
          items: [
            BottomNavyBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.orange,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            BottomNavyBarItem(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.blue,
              ),
              title: Text('Playing'),
            ),
            BottomNavyBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.purple,
                ),
                title: Text(
                  'Search',
                  style: TextStyle(color: Colors.purple),
                )),
            BottomNavyBarItem(
                icon: Icon(
                  Icons.money,
                  color: Colors.green,
                ),
                title: Text('Wallet', style: TextStyle(color: Colors.green))),
          ],
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              Screen2(),
              Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.lightBlue,
                    title: Text('Currently Playing',
                        style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
                //let's start by creating the main UI of the app
                body: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue[800]!,
                          Colors.blue[200]!,
                        ]),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 0.0,
                    ),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          //Let's add some text title
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              widget.owned_email,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 38.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text(
                              widget.artist_email,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          //Let's add the music cover
                          Center(
                            child: Container(
                              width: 280.0,
                              height: 280.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  image: DecorationImage(
                                    image: AssetImage("assets/image.png"),
                                  )),
                            ),
                          ),

                          SizedBox(
                            height: 18.0,
                          ),
                          Center(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //Let's start by adding the controller
                                  //let's add the time indicator text

                                  Container(
                                    width: 500.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        slider(),
                                        Flexible(
                                          child: Text(
                                            "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        iconSize: 45.0,
                                        color: Colors.blue,
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.skip_previous,
                                        ),
                                      ),
                                      IconButton(
                                        iconSize: 62.0,
                                        color: Colors.blue[800],
                                        onPressed: () {
                                          //here we will add the functionality of the play button
                                          if (!playing) {
                                            //now let's play the song
                                            // _player?.setUrl(
                                            // "https://firebasestorage.googleapis.com/v0/b/revengers-88a84.appspot.com/o/love%20yourself.mp3?alt=media&token=ccb41994-7a4b-4fb7-a7ac-353a00f33212");
                                            _player?.play(widget.song_url);
                                            // cache?.play("opening.mp3");
                                            setState(() {
                                              playBtn = Icons.pause;
                                              playing = true;
                                            });
                                          } else {
                                            _player?.pause();
                                            setState(() {
                                              playBtn = Icons.play_arrow;
                                              playing = false;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          playBtn,
                                        ),
                                      ),
                                      IconButton(
                                        iconSize: 45.0,
                                        color: Colors.blue,
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.skip_next,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Screen3(),
              Screen4(),
            ],
          ),
        ),
      ),
    );
  }
}
