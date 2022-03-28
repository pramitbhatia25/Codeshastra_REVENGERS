import 'package:feather_icons/feather_icons.dart';
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
  String price = "Default";
  int currentIndex = 0;

  User_Home({
    required this.title,
    required this.logo_url,
    required this.song_url,
    required this.artist_email,
    required this.owned_email,
    required this.price,
    required this.currentIndex,
  });
  static const routeName = '/user_home';
  @override
  State<User_Home> createState() => _User_HomeState();
}

class _User_HomeState extends State<User_Home> {
  PageController _pageController = PageController();
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
                FeatherIcons.home,
                color: Colors.orange,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            BottomNavyBarItem(
              icon: Icon(
                FeatherIcons.playCircle,
                color: Colors.blue,
              ),
              title: Text('Playing'),
            ),
            BottomNavyBarItem(
                icon: Icon(
                  FeatherIcons.search,
                  color: Colors.purple,
                ),
                title: Text(
                  'Search',
                  style: TextStyle(color: Colors.purple),
                )),
            BottomNavyBarItem(
                icon: Icon(
                  FeatherIcons.dollarSign,
                  color: Colors.green,
                ),
                title: Text('Wallet', style: TextStyle(color: Colors.green))),
          ],
          selectedIndex: widget.currentIndex,
          onItemSelected: (index) {
            setState(() => widget.currentIndex = index);
            _pageController.jumpToPage(index);
          },
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                widget.currentIndex = index;
                _pageController.jumpToPage(widget.currentIndex);
              });
            },
            children: [
              Screen2(),
              Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.lightBlue,
                    title: Text('Currently Playing',
                        style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
                //let's start by creating the main UI of the app
                body: SingleChildScrollView(
                  child: Container(
                    height: 700,
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
                              child: Center(
                                child: Text(
                                  "NFT Owned By: ${widget.owned_email}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.0, top: 5),
                                child: Text(
                                  "NFT Artist: ${widget.artist_email}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            //Let's add the music cover
                            Center(
                              child: Container(
                                width: 200.0,
                                height: 200.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    image: DecorationImage(
                                      image: NetworkImage(widget.logo_url),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
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
              ),
              Screen3(),
              Screen4(
                artist_email: widget.artist_email,
                logo_url: widget.logo_url,
                owned_email: widget.owned_email,
                price: widget.price,
                song_url: widget.song_url,
                title: widget.title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
