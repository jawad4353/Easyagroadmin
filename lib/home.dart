




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
import 'homescreens/diseases.dart';
import 'homescreens/orders.dart';
import 'login.dart';

class home extends StatefulWidget{
  int index;
  home({required this.index});
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var screens=[Dashboard(),Orders(),Companies(),Dealers(),Farmers(),RegistrationForm(),Diseases()];
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
     appBar: PreferredSize(
         preferredSize: Size(30,30),
         child: MyAppBar()),

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
                         return show_progress_indicator(border_color: Colors.white,);
                       }


                       return ListView(children: [
                         InkWell(
                           onTap: (){
                             Navigator.push(context, Myroute(View_Network_Image(url: snap.data!.map['image'],)));
                           },
                           child: Container(
                             clipBehavior: Clip.antiAlias,
                             child: Image.network('${snap.data!.map['image']}',fit: BoxFit.cover,),
                             height: 110,decoration: BoxDecoration(
                               color: Colors.black12,
                               shape: BoxShape.circle
                           ),),
                         ),
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
                  widget.index=0;
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
                    widget.index=1;
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
                    widget.index=2;
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
                    widget.index=3;
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
                    widget.index=4;
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
                    widget.index=5;
                  });
                },style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreen.shade700),
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12)
                ), icon: Icon(Icons.add,color: Colors.white,),
                    label: Text('Admin',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16),))




         ,ElevatedButton.icon(onPressed: (){
           setState(() {
             widget.index=6;
           });
                },style:ButtonStyle(
               backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreen.shade700),
               elevation: MaterialStateProperty.resolveWith((states) => 0),
               overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black12)), icon: Icon(Icons.coronavirus,color: Colors.white,),
            label: Text('Diseases',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16),))


                , SizedBox(height: 6,),
                ElevatedButton.icon(onPressed: () async {
                  
                  var result=await onClick(context);
                  if(result==true){
                    SharedPreferences pref =await SharedPreferences.getInstance();
                    pref.clear();
                    EasyLoading.showSuccess('Logout');
                    Navigator.pushReplacement(context, Myroute(Login()));
                  }

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
           child: screens[widget.index]),

     ],),

   );
  }
}













class View_Network_Image extends StatelessWidget{
  var url;
  View_Network_Image({required this.url});
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.white,

    appBar:PreferredSize(
      preferredSize: Size(30,30),
      child:   MyAppBar(),),
    body: ListView(
      children: [
        Padding(
          padding:  EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(

                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      shape: BoxShape.circle
                  ),
                  child: IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,))),
            ],
          ),
        ),
        Container(
          height: size.height*0.9,
          width: size.width,
          child: Center(child: InteractiveViewer(
              maxScale: 7,
              minScale: 0.5,
              child: Image.network('$url'))),
        ),
      ],
    )
  );
  }

}










Future<bool> onClick(context)async{
  return (await showDialog(context: context, builder:(context)=>AlertDialog(
    title: Text('Are you sure?'),
    content:  Text('You will be Logout of the App'),
    actions: [
      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text('Yes',style: TextStyle(color: Colors.white),),
      ),
      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(false),
        child:  Text('No',style: TextStyle(color: Colors.white)),
      ),
    ],
  ))) ?? false;
}
