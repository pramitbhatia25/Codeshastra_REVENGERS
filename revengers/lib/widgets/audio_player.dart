import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerNew extends StatefulWidget {
  const PlayerNew({Key? key}) : super(key: key);
  static const String routename = "/audio_player";

  @override
  State<PlayerNew> createState() => _PlayerNewState();
}

class _PlayerNewState extends State<PlayerNew> {
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
          max: musicLength.inSeconds.toDouble() + 1,
          onChanged: (value) {
            if (value > musicLength.inSeconds) {}
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

  //Now let's initialize our player
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    // cache = AudioCache(fixedPlayer: _player);

    _player?.onAudioPositionChanged.listen((Duration p) => {
          if (p.inSeconds == musicLength.inSeconds - 10)
            {
              _player?.pause(),
              setState(() {
                playBtn = Icons.play_arrow;
                playing = false;
              }),
            }
          else
            {print('Current position: $p'), setState(() => position = p)},
        });

    //now let's handle the PlayerNew time

    //this function will allow you to get the music duration
    // _player?.durationHandler = (d) {
    //   setState(() {
    //     musicLength = d;
    //   });
    // };

    //this function will allow us to move the cursor of the slider while we are playing the song
    // _player? = (p) {
    //   setState(() {
    //     position = p;
    //   });
    // };
  }

  @override
  Widget build(BuildContext context) {
    print(musicLength);
    return Scaffold(
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
            top: 48.0,
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
                    "Music Beats",
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
                    "Listen to your favorite Music",
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
                    "Stargazer",
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  if (position.inSeconds <
                                      musicLength.inSeconds - 1) {
                                    print("idk");
                                  } else {
                                    _player?.setUrl(
                                        "https://firebasestorage.googleapis.com/v0/b/revengers-88a84.appspot.com/o/love%20yourself.mp3?alt=media&token=ccb41994-7a4b-4fb7-a7ac-353a00f33212");
                                    _player?.play;
                                    // cache?.play("opening.mp3");
                                    setState(() {
                                      playBtn = Icons.pause;
                                      playing = true;
                                    });
                                  }
                                  //now let's play the song

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
    );
  }
}
