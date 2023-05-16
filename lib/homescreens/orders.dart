

import 'dart:convert';

import 'package:firedart/firestore/models.dart';
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
              var result= mapToList(data);
               var Mylist=[];
              for(int i=0;i<result.length;i++)
              {
                var s='${result[i]}'.split('{');
               Mylist.add(convertListStringToMap(s[1].substring(0,s[1].length-1)));
              }

               return Mylist!.length==0 ? Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.favorite,size: 45,color: Colors.lightGreen,),
               Text('No Orders',style: TextStyle(fontWeight: FontWeight.w500),),
             ],): Container(
               height: size.height*0.9,
               child: ListView.builder(
                   itemCount: Mylist.length,
                   itemBuilder: (context,index) {
              return  ListTile(
                   title: Text('${Mylist[index]['date']}     ${Mylist[index]['total']} R.s'),
                  subtitle: Wrap(children: [
                    Text('${Mylist[index]['address']}'),
                    Text('${Mylist[index]['']}'),
                    Text('${Mylist[index]['address']}'),
                  ],),
               );
           }),
             );
         }),
       )
      ],),
    );
  }

  List<Document> mapToList(Map<int, Document> map) {
    return map.values.toList();
  }

}

Map<String, dynamic> convertListStringToMap(String listString) {
  List<String> keyValuePairs = listString.split(', ');

  Map<String, dynamic> map = {};

  for (String keyValuePair in keyValuePairs) {
    List<String> keyValue = keyValuePair.split(': ');

    String key = keyValue[0].trim();
    String value = keyValue[1].trim();

    map[key] = value;
  }

  return map;
}



