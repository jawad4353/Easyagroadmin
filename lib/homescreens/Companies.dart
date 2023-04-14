

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easyagroadmin/home.dart';
import 'package:easyagroadmin/homescreens/products.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../database.dart';
import '../supporting.dart';
import 'Email_sending.dart';

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
     appBar: AppBar(centerTitle: true,title: Text('Pending Verifications',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),backgroundColor: Colors.white,elevation: 0,),

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
                       Icon(Icons.no_drinks,size: 45,color: Colors.lightGreen,),
                       Text('No Pending Verifications',style: TextStyle(fontWeight: FontWeight.w500),),
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
                                  border: Border.all(color: Colors.grey)
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
                                   border: Border.all(color: Colors.grey)
                               ),
                               child:Image.network('${data[index]!['licenseimage']}',fit: BoxFit.fill,),),
                           ),

                           Container(
                             width: size.width*0.6,
                             padding: EdgeInsets.only(bottom: 17),

                             child: ListTile(
                               onTap: (){

                               },
                               title: Text('${data[index]!['name']}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                               trailing: Wrap(children: [
                                 Container(
                                   width: 140,
                                   child: ElevatedButton.icon(onPressed: (){
                                    try{

                                      Firestore.instance.collection('company').document(data[index]!.id).update({
                                        'accountstatus':'verified'
                                      }).whenComplete(() =>setState(() {
                                        Send_mailAdmin(data[index]!['email'],' EasyAgro Account Approved','Hi your Company Account for Easy'
                                            'Agro Application has been Approved . You can Login to your Account Now using your license and password ');
                                        EasyLoading.showSuccess('Approved');

                                      }));
                                    }
                                    catch(e)
                                     {
                                       EasyLoading.showError('$e');
                                     }
                                   }, icon: Icon(Icons.approval,color: Colors.white,),
                                       label:Text('Approve',style: TextStyle(color: Colors.white),) ),
                                 ),
                                 Text(' '),
                                 Container(
                                   width: 140,
                                   child: ElevatedButton.icon(onPressed: () async {
                                     var s=await showEmailDialog(context,data[index]);
                                     if(s==true || s==false){
                                       setState(() {

                                       });
                                     }


                                   }, icon: Icon(Icons.delete,color: Colors.white,),
                                       label: Text('Reject',style: TextStyle(color: Colors.white))),
                                 ),
                               ],),

                               subtitle: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                 Text('Contact : ${data[index]!['phone']}',style: TextStyle(fontWeight: FontWeight.w500),),
                                   Text('Email : ${data[index]!['email']}',style: TextStyle(fontWeight: FontWeight.w500),),
                                   Text('License :${data[index]!['license']}',style: TextStyle(fontWeight: FontWeight.w500),),
                                   Text('Address : ${data[index]!['address']}',style: TextStyle(fontWeight: FontWeight.w500),),
                               ],),

                             ),
                           )
                         ],),
                       );
                   });
                 },
               ),
             ),


         Text('\n  Verified Companies\n',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
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
                   Icon(Icons.no_drinks,size: 45,color: Colors.lightGreen,),
                   Text('No Verified Company ',style: TextStyle(fontWeight: FontWeight.w500),),
                 ],):
               ListView.builder(
                   itemCount:data.length ,
                   itemBuilder: (context,index){
                     return Container(
                       padding: EdgeInsets.only(top: 10),
                       decoration: BoxDecoration(

                           border: Border(top: BorderSide(color: Colors.black12),bottom: BorderSide(color: Colors.black12) )
                       ),
                       child: Wrap(children: [

                         Text('    ${index+1}     ',style: TextStyle(fontSize: 16,color: Colors.lightGreen,fontWeight: FontWeight.bold),),
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
                                 Navigator.push(context, Myroute(Products(companydetails: data[index],)));
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
                         )
                       ],),
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

