import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

//video player

// slide digital clock

import 'home_page.dart';
//wakelock

void main() async{
  //widgets bindings
  WidgetsFlutterBinding.ensureInitialized();
  //wakelock
  Wakelock.enable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ORIENTATION  PORTRAIT ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // keep screen on
 

    //enable wakelock

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agni',
      home: HomePage(),
    );
  }
}
