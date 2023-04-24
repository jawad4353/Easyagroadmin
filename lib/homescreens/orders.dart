import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';

import '../supporting.dart';

class Orders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,title: Text('Active',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),backgroundColor: Colors.white,elevation: 0,),

      body: Column(children: [
       Container(
         height: 600,
         width: 600,
         child: StreamBuilder(
             stream: Firestore.instance.collection('orders').stream,
             builder: (context,snap){

               if(!snap.hasData){
                 return show_progress_indicator(border_color: Colors.lightGreen,);
               }

           var data=snap.data!.asMap();
               String input = "${data}";
               int start = input.indexOf('{');
               int end = input.lastIndexOf('}');
               String result = input.substring(start, end + 1);
               print(result); // {0: /orders/6buI

               return data!.length==0 ? Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.favorite,size: 45,color: Colors.lightGreen,),
               Text('No Orders',style: TextStyle(fontWeight: FontWeight.w500),),
             ],):

             ListView.builder(
                 itemCount: data.length,
                 itemBuilder: (context,index){
             Container(
               width: size.width*0.61,
               height: 100,
               child: ListTile(
                 title: Text(''),

               ),
             );
           });
         }),
       )
      ],),
    );
  }

}








//
// data.clear();
// documentslist.clear();
// for(int i=0;i<lengthc.length;i++){
// var s=lengthc[i].toString().split('{');
// documentslist.add('${s[0]}'.split('/'));
// var d='${s[1]}'.split('}');
// print((d));
// data.add(d);
// }
