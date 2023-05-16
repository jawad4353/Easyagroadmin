


import 'package:accordion/accordion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyagroadmin/supporting.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';

class View_complains extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
   return Scaffold(
     backgroundColor: Colors.white,
     body: Column(
       children: [
         Text('Complains\n',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
         Container(
           height:size.height*0.82 ,
           child: StreamBuilder(
             stream: Firestore.instance.collection('complains').stream,
             builder: (context,snap){
               if(!snap.hasData){
                 show_progress_indicator(border_color: Colors.lightGreen,);
               }
               var data;
               try{
                 data=snap.data!.asMap();
               }
               catch(e){
                 return show_progress_indicator(border_color: Colors.lightGreen,);
               }
               return data.length==0 ? Column(children: [
                 Icon(Icons.report),
                 Text('No Complains')
               ],) :ListView.builder(
                 itemCount: data.length,
                   itemBuilder: (context,index){
                     return ListTile(
                         onTap: (){},
                         leading:  Container(height: 20,
                           width: 20,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(30),
                             color: data[index]['status']=='Resolved'? Colors.lightGreen.shade700:Colors.redAccent,) ,
                         ),

                         title:Wrap(children: [
                           Text('${data[index]['subject']}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),


                         ],),
                         subtitle:  Wrap(children: [
                           Text('${data[index]['status']}\t \t \t',style: TextStyle(fontWeight: FontWeight.w500)),
                           Text('${data[index]['date']}'.substring(0,16),style: TextStyle(fontWeight: FontWeight.w500)),
                           Text('\t \t${data[index]['from']}\t ',style: TextStyle(fontWeight: FontWeight.w500)),

                         ],),
                         trailing: Wrap(children: [

                           ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.where_to_vote_rounded,color: Colors.white,), label: Text('Resolved',style: TextStyle(color: Colors.white),)),
                           SizedBox(width: 10,),
                           ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.clear,color: Colors.white,), label: Text('Dismiss ',style: TextStyle(color: Colors.white),)),

                         ],),

                       );

                   });
             },
           ),
         ),
       ],
     )
   );
  }

}