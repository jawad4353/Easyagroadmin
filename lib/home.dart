



import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget{
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(leading: Icon(Icons.email),),
     body: Center(child: Text(' Admin Home')),
   );
  }
}