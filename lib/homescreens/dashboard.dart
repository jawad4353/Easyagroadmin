

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0
      ,title: Container(
        height: 37,
          width:300,child:TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: 'Search ',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))
          ),

      )),),
         body:Wrap(
           children: [
             Container(
               height: 150,
               width: size.width*0.21,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(13),
               ),
               child: Column(children: [
                 Text('Farmers',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
               TweenAnimationBuilder(
                 duration: Duration(seconds: 2),
                 tween: Tween(begin: 0.1,end: 1.0),
                 builder: (context,val,o) {
                   return Stack(
                     children: [
                       Container(
                           height: 100,
                           width: 100,
                           child: CircularProgressIndicator(value: val,backgroundColor: Colors.black12,strokeWidth: 15,valueColor: AlwaysStoppedAnimation(Colors.green),)),

                       Positioned(
                         top:40,
                           left:30,
                           child: Text('${(val*100).ceilToDouble()} %',style: TextStyle(fontSize: 18),))
                     ],
                   );
                 }
               )

               ],),
             ),
             SizedBox(width: 6,),
             Container(
               height: 150,
               width: size.width*0.21,
               decoration: BoxDecoration(
                   color: Colors.green,
                   borderRadius: BorderRadius.circular(13)
               ),
             ),
             Container(
               height: 150,
               width: size.width*0.21,
               decoration: BoxDecoration(
                   color: Colors.yellow,
                   borderRadius: BorderRadius.circular(13)
               ),
             ),
             SizedBox(width: 6,),
             Container(
               height: 150,
               width: size.width*0.21,
               decoration: BoxDecoration(
                   color: Colors.green,
                   borderRadius: BorderRadius.circular(13)
               ),
             ),

           ],
         ) ,
    );
  }
}