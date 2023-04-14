import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,title: Text('Active',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),backgroundColor: Colors.white,elevation: 0,),

      body: Column(children: [
       StreamBuilder(
           stream: Firestore.instance.collection('orders').where('status' ,isEqualTo: 'verified').get().asStream(),
           builder: (context,snap){
         var data=snap.data!.asMap();
         return ListView.builder(itemBuilder: (context,index){
           Container(
             width: size.width*0.61,
             child: ListTile(
               title: Text('${data[index]!['name']}'),

               subtitle: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Text('Contact : ${data[index]!['phone']}',style: TextStyle(fontWeight: FontWeight.w500),),
                   Text('Email : ${data[index]!['email']}',style: TextStyle(fontWeight: FontWeight.w500),),
                   Text('License :${data[index]!['license']}',style: TextStyle(fontWeight: FontWeight.w500),),
                   Text('Address : ${data[index]!['address']}',style: TextStyle(fontWeight: FontWeight.w500),),
                 ],),
               trailing:Wrap(children: [
                 Container(
                   width: 140,
                   child: ElevatedButton.icon(onPressed: () async {

                   }, icon: Icon(Icons.panorama_rounded,color: Colors.white,), label: Text('Products',style: TextStyle(
                       color: Colors.white
                   ),)),
                 ),
                 Text(' '),
                 Container(
                   width: 140,
                   child: ElevatedButton.icon(onPressed: () async {

                   }, icon: Icon(Icons.favorite_border,color: Colors.white,), label: Text('Orders',style: TextStyle(
                       color: Colors.white
                   ),)),
                 )
               ],),
             ),
           );
         });
       })
      ],),
    );
  }

}