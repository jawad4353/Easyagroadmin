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
       Container(
         height: 600,
         width: 600,
         child: StreamBuilder(
             stream: Firestore.instance.collection('orders').where('status' ,isEqualTo: 'confirmed').get().asStream(),
             builder: (context,snap){
           var data=snap.data!.asMap();
           print(data);
           return data.length==0 ? Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.favorite,size: 45,color: Colors.lightGreen,),
               Text('No Orders',style: TextStyle(fontWeight: FontWeight.w500),),
             ],):

             ListView.builder(itemBuilder: (context,index){
             Container(
               width: size.width*0.61,
               child: ListTile(
                 title: Text('j'),

                 // subtitle: Column(
                 //   mainAxisAlignment: MainAxisAlignment.start,
                 //   crossAxisAlignment: CrossAxisAlignment.start,
                 //   children: [
                 //
                 //     Text('Contact : ${data[index]!['address']}',style: TextStyle(fontWeight: FontWeight.w500),),
                 //     Text('Email : ${data[index]!['email']}',style: TextStyle(fontWeight: FontWeight.w500),),
                 //     Text('License :${data[index]!['license']}',style: TextStyle(fontWeight: FontWeight.w500),),
                 //     Text('Address : ${data[index]!['address']}',style: TextStyle(fontWeight: FontWeight.w500),),
                 //   ],),

               ),
             );
           });
         }),
       )
      ],),
    );
  }

}