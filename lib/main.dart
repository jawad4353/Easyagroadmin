

import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:window_size/window_size.dart';
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
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  Login(),
      builder: EasyLoading.init(),
    );
  }
}

