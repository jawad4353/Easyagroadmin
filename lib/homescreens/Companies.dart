

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easyagroadmin/home.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../supporting.dart';

class Companies extends StatefulWidget{
  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  var total_unverified='';
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(centerTitle: true,title: Text('Pending Verifications',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),backgroundColor: Colors.white,elevation: 0,),
     body: Column(

       children: [

             Container(
               height: size.height*0.4,
               color: Colors.white,
               padding: EdgeInsets.only(left: 30),
               child: StreamBuilder(
                 stream: Firestore.instance.collection('company').where('accountstatus' ,isEqualTo: 'unverified').get().asStream(),
                 builder: (context,snap){
                   if(!snap.hasData){
                     return show_progress_indicator(border_color: Colors.lightGreen,);
                   }
                   var data=snap.data!.asMap();

                   return  data.length==0 ? Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.no_drinks),
                       Text('No Pending Verifications'),
                     ],):
                   ListView.builder(
                     itemCount:data.length ,
                       itemBuilder: (context,index){
                       return Padding(
                         padding: EdgeInsets.only(bottom: 10),
                         child: Wrap(children: [
                           Text('${index+1}     ',style: TextStyle(fontSize: 16,color: Colors.lightGreen,fontWeight: FontWeight.bold),),

                          InkWell(
                            onTap: (){
                              Navigator.push(context, Myroute(View_Network_Image(url: data[index]!['profileimage'],)));
                            },
                            child: Container(
                                 height:100,
                                 width: 150,
                                 clipBehavior: Clip.antiAlias,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(12),
                                   border: Border.all(color: Colors.black12)
                                 ),
                                 child:Image.network('${data[index]!['profileimage']}',fit: BoxFit.fill,),),
                          ),
                           Text(' '),
                           InkWell(
                             onTap: (){
                               Navigator.push(context, Myroute(View_Network_Image(url: data[index]!['licenseimage'],)));
                             },
                             child: Container(
                               height:100,
                               width: 150,
                               clipBehavior: Clip.antiAlias,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12),
                                   border: Border.all(color: Colors.black12)
                               ),
                               child:Image.network('${data[index]!['licenseimage']}',fit: BoxFit.fill,),),
                           ),

                           Container(
                             width: size.width*0.6,
                             padding: EdgeInsets.only(bottom: 17),
                             decoration: BoxDecoration(
                               border: Border(bottom: BorderSide(color: Colors.black12))
                             ),
                             child: ListTile(
                               onTap: (){

                               },
                               title: Text('${data[index]!['name']}',style: TextStyle(fontWeight: FontWeight.w500),),
                               trailing: Wrap(children: [
                                 Container(
                                   width: 140,
                                   child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.approval,color: Colors.white,),
                                       label:Text('Approve',style: TextStyle(color: Colors.white),) ),
                                 ),
                                 Text(' '),
                                 Container(
                                   width: 140,
                                   child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.white,),
                                       label: Text('Reject',style: TextStyle(color: Colors.white))),
                                 ),
                               ],),

                               subtitle: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                 Text('${data[index]!['phone']}',style: TextStyle(fontWeight: FontWeight.w500),),
                                   Text('${data[index]!['email']}',style: TextStyle(fontWeight: FontWeight.w500),),
                                   Text('${data[index]!['license']}',style: TextStyle(fontWeight: FontWeight.w500),),
                                   Text('${data[index]!['address']}',style: TextStyle(fontWeight: FontWeight.w500),),
                               ],),

                             ),
                           )
                         ],),
                       );
                   });
                 },
               ),
             ),
         Text('\n  Verified Companies\n',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
         Container(
           height: size.height*0.3,
           color: Colors.white,
           child: StreamBuilder(
             stream: Firestore.instance.collection('company').where('accountstatus' ,isEqualTo: 'verified').get().asStream(),
             builder: (context,snap){
               if(!snap.hasData){
                 return show_progress_indicator(border_color: Colors.lightGreen,);
               }
               var data=snap.data!.asMap();
               return  data.length==0 ? Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(Icons.no_drinks),
                   Text('No Verified Company '),
                 ],):
               ListView.builder(
                   itemCount:data.length ,
                   itemBuilder: (context,index){
                     return ListTile(
                       title: Text('${data[index]!['name']}'),
                       subtitle: Text('${data[index]!['license']}'),
                     );
                   });
             },
           ),
         ),

       ],
     ),
   );
  }


}

