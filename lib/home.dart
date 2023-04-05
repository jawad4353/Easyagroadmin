




import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyagroadmin/supporting.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';

import 'homescreens/Companies.dart';
import 'homescreens/Dealers.dart';
import 'homescreens/Farmers.dart';
import 'homescreens/addadmin.dart';
import 'homescreens/dashboard.dart';
import 'homescreens/orders.dart';
import 'login.dart';

class home extends StatefulWidget{
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var screens=[Dashboard(),Orders(),Companies(),Dealers(),Farmers(),RegistrationForm()],index=0;
  var current_email;
 @override
  void initState() {
    Get_email();
    super.initState();
  }

  Get_email() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
   current_email= await pref.getString("email");
  }

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
       leadingWidth: 110,
       leading:   Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Image.asset('images/appicona.png',height: 50,),
           Text('  EasyAgro',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 14),),
         ],),
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
           child:Container(
             color: Colors.lightGreen.shade700,
             child: ListView(
               children: [
                 SizedBox(height: 5,),
                 Container(
                   height: 200,
                   child: StreamBuilder(
                     stream: Firestore.instance.collection('admin').document('${current_email}').stream,
                     builder: (context,snap){
                       if (!snap.hasData) {
                         return show_progress_indicator();
                       }


                       return ListView(children: [
                         Container(
                           clipBehavior: Clip.antiAlias,
                           child: Image.network('${snap.data!.map['image']}',fit: BoxFit.cover,),
                           height: 110,decoration: BoxDecoration(
                             color: Colors.black12,
                             shape: BoxShape.circle
                         ),),
                         SizedBox(height: 13,),

                         Column(children: [
                           SizedBox(height: 4,),
                           Text('${snap.data!.map['name']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'jd',
                               color: Colors.white),),

                           Text('${snap.data!.map['contact']}',style: TextStyle(color: Colors.white),),
                           Text('Admin',style: TextStyle(color: Colors.white),),
                         ],),
                       ],);
                     },
                   ),
                 ),

          Divider(),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              ElevatedButton.icon(onPressed: (){
                setState(() {
                  index=0;
                });
              },style:ButtonStyle(
                 backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreen.shade700),
                elevation: MaterialStateProperty.resolveWith((states) => 0),
                overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12)
              ), icon: Icon(Icons.dashboard,color: Colors.white,),
                  label: Text('Dashboard',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16),))

                , SizedBox(height: 6,),
                ElevatedButton.icon(onPressed: (){
                  setState(() {
                    index=1;
                  });
                },style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreen.shade700),
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12)
                ), icon: Icon(Icons.favorite_border,color: Colors.white,),
                    label: Text('Orders',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16),))
,                 SizedBox(height: 6,),


                ElevatedButton.icon(onPressed: (){
                  setState(() {
                    index=2;
                  });
                },style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreen.shade700),
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12)
                ), icon: Icon(Icons.house_siding_sharp,color: Colors.white,),
                    label: Text('Companies',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16),))
,
                SizedBox(height: 6,),
                ElevatedButton.icon(onPressed: (){
                  setState(() {
                    index=3;
                  });
                },style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreen.shade700),
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12)
                ), icon: Icon(Icons.perm_contact_cal,color:Colors.white,),
                    label: Text('Dealers',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16)))
,
                SizedBox(height: 6,),
                ElevatedButton.icon(onPressed: (){
                  setState(() {
                    index=4;
                  });
                },style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) =>Colors.lightGreen.shade700),
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12)
                ), icon: Icon(Icons.accessibility_new_sharp,color: Colors.white,),
                    label: Text('Farmers',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16),))

                , SizedBox(height: 6,),
                ElevatedButton.icon(onPressed: (){
                  setState(() {
                    index=5;
                  });
                },style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreen.shade700),
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12)
                ), icon: Icon(Icons.add,color: Colors.white,),
                    label: Text('Add Admin',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16),))

                , SizedBox(height: 6,),
                ElevatedButton.icon(onPressed: () async {
                  SharedPreferences pref =await SharedPreferences.getInstance();
                  pref.clear();
                  showDialog(context: context, builder: (context)=>AlertDialog(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('Are you sure ?'),
                      Text('You will be redirected to login page and will be logout ',style: TextStyle(
                        fontWeight: FontWeight.normal,fontSize: 15
                      ),),
                    ],),
                    actions: [
                      ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen.shade700
                  ),onPressed: (){
                        EasyLoading.showSuccess('Logout');
                        Navigator.pushReplacement(context, Myroute(Login()));
                      }, child: Text('Yes')),
                      ElevatedButton(style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen.shade700
                      ),onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text('No')),
                    ],
                  ));

                },style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreen.shade700),
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12)
                ), icon: Icon(Icons.logout,color: Colors.white,),
                    label: Text('Logout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16),))

              ],)
             ],),
           )),

       Expanded(
           flex: 8,
           child: screens[index]),

     ],),

   );
  }
}