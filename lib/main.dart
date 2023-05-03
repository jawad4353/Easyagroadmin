

import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easyagroadmin/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';
import 'home.dart';
import 'login.dart';
import 'dart:ui';
import 'package:dcdg/dcdg.dart';




final  apiKey= "AIzaSyD1dC0Mx7EjQNYD1wWsamjJV9PAenH6bfQ";
final   projectId= "easyagro-ed808";


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
Firestore.initialize(projectId);
// Firebase.initializeApp(options: FirebaseOptions(
//     apiKey:"AIzaSyDtXYijb9Bwbf24hZZennLwMrIqGIYVRqs",
//     appId: '1:730243418927:web:88a00c295cdcf9ec5cefda',
//     messagingSenderId:'730243418927',
//     projectId: "easyagro-ed808"
// ));



  var s=DateTime.now();
  print(s);


  final window = WidgetsBinding.instance.window;
  final screenSize = window.physicalSize / window.devicePixelRatio;
  setWindowTitle('EasyAgro');
  var win=appWindow;
  doWhenWindowReady(() {
    win = appWindow;
    var initialSize = Size(1300, 800);
    win.minSize = initialSize;

    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
  // Set_windowsize(screenSize.height,screenSize.width);
  // setWindowFrame(Rect.fromLTRB(0,0,screenSize.width*1.13,screenSize.height*1.15));
  // setWindowMinSize(Size(screenSize.width*1.13 ,screenSize.height*1.15));

  runApp(MyApp());

}


class MyApp extends StatelessWidget {

  Get_user() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    return await pref.getString("email");
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ValueProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,


        ),
        home:FutureBuilder(
          future: Get_user(),
          builder: (context,snapshot){
            return snapshot.data==null ? Login():home(index: 0,);

          },
        ) ,
        builder: EasyLoading.init(),
      ),
    );
  }
}

