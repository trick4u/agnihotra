

import 'package:dough/dough.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

//geocoding
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:share/share.dart';

//video player
import 'package:video_player/video_player.dart';
//slide digital clock
import 'package:slide_digital_clock/slide_digital_clock.dart';

//glass kit
import 'package:glass_kit/glass_kit.dart';

// date time format
import 'package:intl/intl.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:wakelock/wakelock.dart';
//map
import 'package:map/map.dart';

//dough
import 'package:dough/dough.dart';

//datetime format
//tts

// video compresss

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  //enable wakelock

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/fire.mp4')
      ..initialize().then((_) {
        //controller play
        _controller.play();
        //loop video
        _controller.setLooping(true);
        // video speed
        _controller.setPlaybackSpeed(1.0);

        setState(() {});
      });
  }

  String morning =
      "सूर्याय स्वाहा सूर्याय इदम् न म मa  प्रजापतये स्वाहा प्रजापतये इदम् न म मa ..";

  String morning1 =
      "सूर्याय स्वाहा सूर्याय इदम् न म म  प्रजापतये स्वाहा प्रजापतये इदम् न म म ..";

  String evening =
      "अग्नये स्वाहा अग्नये इदम् न म मa  प्रजापतये स्वाहा प्रजापतये इदम् न म मa .. ";
  String evening1 =
      "अग्नये स्वाहा अग्नये इदम् न म म  प्रजापतये स्वाहा प्रजापतये इदम् न म म .. ";

  //date time
  DateTime _dateTime = DateTime.now();
  //today

  bool _isTapped = true;
  bool _isDoubleTapped = true;

  // text to speech
  late TextToSpeech _textToSpeech = TextToSpeech();
  var location;
  //map

  late String newAddress;
  var currentAddress = "";
  var currentLocation = "";
  var currentposition;

  //geopoint
  var geopoint;
  bool isWakeEnable = true;

  // dispose video controller
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

  dough1(widget) {
    return DoughRecipe(
      data: DoughRecipeData(
        adhesion: 21,
      ),
      child: GyroDough(
        child: widget,
      ),
    );
  }

  //create a function to turn of screen
  void _turnOffScreen() {
    Wakelock.disable();
  }

  // red card

//compress asset video

  var text1 = "Agnihotra";
  var text2 = "अग्निहोत्र";
  bool _isTapped1 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: PressableDough(
              onReleased: (r) {
                setState(() {
                  _isTapped1 = !_isTapped1;
                });
              },
              child: Text(
                _isTapped1 ? text1 : text2,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        body: Stack(
          //   mainAxisAlignment: MainAxisAlignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            _controller.value.isInitialized
                ? GestureDetector(
                    onTap: () {
                      // if volume is mute
                      if (_controller.value.volume == 0) {
                        _controller.setVolume(1.0);
                      } else {
                        _controller.setVolume(0.0);
                      }
                    },
                    onDoubleTap: () {
                      // if video is playing
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    },
                    onLongPress: () {
                      setState(() {
                        _turnOffScreen();
                      });
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    onVerticalDragStart: (v) {
                      // lock screen
                      Wakelock.enable();
                    },
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(
                        _controller,
                      ),
                    ),
                  )
                : Container(),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              top: _isTapped ? 200 : 40,
              bottom: _isTapped ? 100 : 300,
              left: _isTapped ? 10 : 35,
              right: _isTapped ? 10 : 35,
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isTapped = !_isTapped;
                    });
                  },
                  onDoubleTap: () {
                    setState(() {
                      _isDoubleTapped = !_isDoubleTapped;
                    });
                  },
                  child: GlassContainer.clearGlass(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    //margin
                    color: _isDoubleTapped
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.5),

                    //   shadowColor: Colors.black,
                    child: PressableDough(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                        //       alignment: Alignment.center,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // current day

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('EEEE').format(_dateTime),
                                    style: TextStyle(
                                      fontSize: _isTapped ? 25 : 20,
                                      fontWeight: FontWeight.bold,
                                      color: _isDoubleTapped
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    ",",
                                    style: TextStyle(
                                        color: _isDoubleTapped
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    DateFormat('MMMM d').format(_dateTime),
                                    style: TextStyle(
                                      fontSize: _isTapped ? 25 : 20,
                                      fontWeight: FontWeight.bold,
                                      color: _isDoubleTapped
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: DigitalClock(
                                  digitAnimationStyle: Curves.easeIn,
                                  is24HourTimeFormat: false,
                                  areaDecoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  hourMinuteDigitTextStyle: TextStyle(
                                    color: _isDoubleTapped
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 50,
                                  ),
                                  secondDigitDecoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  secondDigitTextStyle: TextStyle(
                                    color: _isDoubleTapped
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 50,
                                  ),
                                  amPmDigitTextStyle: TextStyle(
                                      color: _isDoubleTapped
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              // current year
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                DateFormat('yyyy').format(_dateTime),
                                style: TextStyle(
                                  fontSize: _isTapped ? 25 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: _isDoubleTapped
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              // if current time is am or pm
                              SizedBox(
                                height: 10,
                              ),
                              // date time is am or pm
                              // if current time is less than 12

                              _dateTime.hour > 12
                                  ? GestureDetector(
                                      onTap: () {
                                        // text to speech
                                        _textToSpeech.speak(evening);
                                        // language to sanskrit

                                        _textToSpeech.setLanguage("hi-IN");

                                        // pitch
                                        _textToSpeech.setPitch(1.0);
                                      },
                                      onDoubleTap: () {
                                        // if _textToSpeech is speaking then stop
                                        _textToSpeech.stop();
                                      },
                                      child: Text(
                                        evening1,
                                        style: _isDoubleTapped
                                            ? TextStyle(
                                                color: Colors.white,
                                                fontSize: _isTapped ? 25 : 20,
                                              )
                                            : TextStyle(
                                                color: Colors.black,
                                                fontSize: _isTapped ? 25 : 20,
                                              ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        _textToSpeech.speak(morning);
                                        // set language to hindi

                                        // set language to saanskrit
                                        _textToSpeech.setLanguage("hi-IN");

                                        // pitch
                                        _textToSpeech.setPitch(1.0);

                                        //reduce pitch

                                        //increase time
                                      },
                                      onDoubleTap: () {
                                        // if _textToSpeech is speaking then stop
                                        _textToSpeech.stop();
                                      },
                                      child: Text(
                                        morning1,
                                        style: TextStyle(
                                          color: _isDoubleTapped
                                              ? Colors.white
                                              : Colors.white,
                                          fontSize: _isTapped ? 30 : 20,
                                        ),
                                      ),
                                    ),

                              // location

                              currentAddress.isEmpty
                                  ? TextButton(
                                      onPressed: () {
                                        determinePosition();
                                      },
                                      child: Text(
                                        "Get Location",
                                        style: TextStyle(
                                          color: _isDoubleTapped
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        // remove location
                                        remove_location();
                                      },
                                      child: Text(
                                        "Remove Location",
                                        style: TextStyle(
                                          color: _isDoubleTapped
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: _isTapped ? 25 : 20,
                                        ),
                                      )),
                              SizedBox(
                                height: 5,
                              ),
                              currentAddress.isEmpty
                                  ? SizedBox.shrink()
                                  : Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () {
                                          MapsLauncher.launchQuery(
                                              currentAddress);
                                        },
                                        onDoubleTap: () {
                                          //share url
                                          open_map();
                                        },
                                        child: Text(
                                          currentAddress,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: _isDoubleTapped
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: _isTapped ? 25 : 20,
                                          ),
                                        ),
                                      ),
                                    ),
                         
                            ],
                          ),
                        ),
                      ),
                    ),
                    // backdrop filter
                  ),
                ),
              ),
            ),

            //  SlideDigitalClock(),
          ],
        ),
      ),
    );
  }

  void remove_location() {
    return setState(() {
      currentAddress = "";
      geopoint = null;
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    try {
      // reverseGeocode(position);
      // reverse geocode
      List<Placemark> placemark = await GeocodingPlatform.instance
          .placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemark[0];

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.street} ${place.subLocality},${place.locality}, ${place.postalCode},${place.country}";
        newAddress = "${place.subLocality},${place.locality}";
      });
    } catch (e) {
      // return null;

      print(e);
    }
    return position;
  }

  void share_location() {
    String text = currentAddress;
    String subject = "Location";
    //share location with cooredinates
    Share.share(text, subject: subject);
  }

  //open street map
  void open_map() {
    String text = currentAddress;
    String text1 = "Agnihotra is amazing!";
    //apply textstyle

    String url =
        "$text \n https://www.google.com/maps/search/?api=1&query=${currentposition.latitude},${currentposition.longitude} \n $text1";

    //share link and text
    Share.share(url);
  }
}
