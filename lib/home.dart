




import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';

import 'homescreens/dashboard.dart';

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
       centerTitle: true,
       toolbarHeight: 30,
       backgroundColor: Colors.white,
       actions: [
         TextButton(onPressed: (){
           appWindow.minimize();
         }, child: Text('—',style: TextStyle(color: Colors.grey,fontSize: 20),),),
         IconButton(onPressed: (){
           if(appWindow.isMaximized){
             appWindow.size=Size(800,800);
             appWindow.maximizeOrRestore();

           }

           if(appWindow.size.height<size.height){
             appWindow.maximize();

           }

         }, icon: Icon(Icons.web_asset,color: Colors.grey,size: 20,)),
         IconButton(onPressed: (){
           appWindow.close();
         }, icon: Icon(Icons.close,color: Colors.grey,size: 20,)),

       ],),

     body: Row(children: [
       Expanded(
         flex: 1,
           child:ListView(children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
             Image.asset('images/appicon.png',height: 60,),
             Text('E A S Y A G R O',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
           ],),
           // Divider(),
          SizedBox(height: 13,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ElevatedButton.icon(onPressed: (){},style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0
            ), icon: Icon(Icons.dashboard,color: Colors.green.shade700,),
                label: Text('Dashboard',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16),))

              , SizedBox(height: 4,),
              ElevatedButton.icon(onPressed: (){},style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0
              ), icon: Icon(Icons.favorite_border,color: Colors.green.shade700,),
                  label: Text('Orders',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16),))
,                 SizedBox(height: 4,),
              ElevatedButton.icon(onPressed: (){},style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0
              ), icon: Icon(Icons.house_siding_sharp,color: Colors.green.shade700,),
                  label: Text('Companies',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16),))
,
              SizedBox(height: 4,),
              ElevatedButton.icon(onPressed: (){},style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0
              ), icon: Icon(Icons.perm_contact_cal,color: Colors.green.shade700,),
                  label: Text('Dealers',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16)))
,
              SizedBox(height: 4,),
              ElevatedButton.icon(onPressed: (){},style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.green,

                  elevation: 0
              ), icon: Icon(Icons.accessibility_new_sharp,color: Colors.green.shade700,),
                  label: Text('Farmers',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16),))

              , SizedBox(height: 4,),
              ElevatedButton.icon(onPressed: (){},style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0
              ), icon: Icon(Icons.logout,color: Colors.green.shade700,),
                  label: Text('Logout',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16),))

            ],)
           ],)),
       VerticalDivider(),

       Expanded(
           flex: 8,
           child: Dashboard()),

     ],),

   );
  }
}