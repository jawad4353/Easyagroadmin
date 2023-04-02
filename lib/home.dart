




import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';

class home extends StatefulWidget{
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

   return Scaffold(
     key: _scaffoldKey,
     backgroundColor: Colors.white,
     appBar: AppBar(
       elevation: 0,
       toolbarHeight: 30,

       backgroundColor: Colors.white,
       leading: IconButton(onPressed: (){
         _scaffoldKey.currentState!.openDrawer();
       },icon: Icon(Icons.sort,color: Colors.grey,),),

       actions: [
         TextButton(onPressed: (){
           appWindow.minimize();
         }, child: Text('—',style: TextStyle(color: Colors.grey,fontSize: 20),),),
         IconButton(onPressed: (){
           if(appWindow.isMaximized){
             appWindow.size=Size(800,800);
             appWindow.maximizeOrRestore();

           }

           if(appWindow.size.height==800.0){
             appWindow.maximize();

           }

         }, icon: Icon(Icons.web_asset,color: Colors.grey,size: 20,)),
         IconButton(onPressed: (){
           appWindow.close();
         }, icon: Icon(Icons.close,color: Colors.grey,size: 20,)),

       ],),
     drawer: Drawer(
       elevation: 0,
       backgroundColor: Colors.white,
       shadowColor: Colors.white,
       width: 200,
       child: Column(children: [
         ElevatedButton(onPressed: () async {
           SharedPreferences pref =await SharedPreferences.getInstance();
          pref.clear();
         }, child: Text('clear'))
       ],),
     ),
     body: Center(child: Text(' Admin Home')),
   );
  }
}