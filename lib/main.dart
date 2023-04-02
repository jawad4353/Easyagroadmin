

import 'dart:async';

import 'package:easyagroadmin/supporting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';
import 'home.dart';
import 'login.dart';
import 'dart:ui';



final  apiKey= "AIzaSyD1dC0Mx7EjQNYD1wWsamjJV9PAenH6bfQ";
final   projectId= "easyagro-ed808";


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
Firestore.initialize(projectId);
  setWindowTitle('EasyAgro');
  final window = WidgetsBinding.instance.window;
  final screenSize = window.physicalSize / window.devicePixelRatio;
  setWindowFrame(Rect.fromLTRB(0,0,screenSize.width*1.13,screenSize.height*1.15));
  setWindowMinSize(Size(screenSize.width*1.13 ,screenSize.height*1.15));
  runApp(MyApp());

}


class MyApp extends StatelessWidget {

  Get_user() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    return await pref.getString("email");
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:FutureBuilder(
        future: Get_user(),
        builder: (context,snapshot){
          if (!snapshot.hasData) {
            return show_progress_indicator();
          }
          print(snapshot.data);
          return snapshot.data==null ? Login():home();

        },
      ) ,
      builder: EasyLoading.init(),
    );
  }
}

