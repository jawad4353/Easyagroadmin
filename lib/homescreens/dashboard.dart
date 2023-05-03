

import 'dart:async';

import 'package:easyagroadmin/database.dart';
import 'package:easyagroadmin/supporting.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:dcdg/dcdg.dart';
import '../home.dart';
import '../providers.dart';
import 'charts.dart';



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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black12,width: 0.4))
          ),

      )),),
         body:ListView(
           children: [


             // Consumer<ValueProvider>(
             //   builder: (context, valueProvider, child) {
             //     return Text('Total : ${valueProvider.value}',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),);
             //   },
             // ),
            Row(children: [
              SizedBox(width: 6,),
              TweenAnimationBuilder(
                  duration: Duration(seconds: 2),
                  tween: Tween(begin: 0.1,end: 0.7),
                  builder: (context,val,o) {
                    return Stack(
                      children: [
                        Container(
                          height: 90,
                          width: size.width*0.21,
                          decoration: BoxDecoration(

                              gradient: LinearGradient(
                                  colors: [Colors.lightGreen.shade700,Colors.lightGreen]
                              ),
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)
                          ),


                        ),
                        Positioned(
                          top:10,
                          left:60,

                          child: Text('Companies',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.white),),)
                        ,
                        Positioned(
                            top:30,
                            left:60,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text('Verified :',style: TextStyle(color: Colors.white,fontSize: 15),),
                                  Text(' 556',style: TextStyle(color: Colors.white,fontSize: 16)),
                                ],),
                                Row(children: [
                                  Text('Unverified:',style: TextStyle(color: Colors.white,fontSize: 15)),
                                  Text(' 56',style: TextStyle(color: Colors.white,fontSize: 16)),
                                ],),

                              ],))

                        ,  Positioned(
                            top:10,
                            left:0,
                            child:Icon(Icons.house,color: Colors.white,size: 60,))
                      ],
                    );
                  }
              ),




              SizedBox(width: 6,),
              TweenAnimationBuilder(
                  duration: Duration(seconds: 2),
                  tween: Tween(begin: 0.1,end: 0.7),
                  builder: (context,val,o) {
                    return Stack(
                      children: [
                        Container(
                          height: 90,
                          width: size.width*0.21,
                          decoration: BoxDecoration(

                              gradient: LinearGradient(
                                  colors: [Colors.lightGreen.shade700,Colors.lightGreen]
                              ),
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)
                          ),


                        ),
                        Positioned(
                          top:10,
                          left:60,

                          child: Text('Dealers',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.white),),)
                        ,
                        Positioned(
                            top:30,
                            left:60,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text('Verified :',style: TextStyle(color: Colors.white,fontSize: 15),),
                                  Text(' 556',style: TextStyle(color: Colors.white,fontSize: 16)),
                                ],),
                                Row(children: [
                                  Text('Unverified:',style: TextStyle(color: Colors.white,fontSize: 15)),
                                  Text(' 56',style: TextStyle(color: Colors.white,fontSize: 16)),
                                ],),

                              ],))

                        ,  Positioned(
                            top:10,
                            left:0,
                            child:Icon(Icons.person,color: Colors.white,size: 60,))
                      ],
                    );
                  }
              ),





              SizedBox(width: 6,),
              TweenAnimationBuilder(
                  duration: Duration(seconds: 2),
                  tween: Tween(begin: 0.1,end: 0.7),
                  builder: (context,val,o) {
                    return Stack(
                      children: [
                        Container(
                          height: 90,
                          width: size.width*0.21,
                          decoration: BoxDecoration(

                              gradient: LinearGradient(
                                  colors: [Colors.lightGreen.shade700,Colors.lightGreen]
                              ),
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)
                          ),


                        ),
                        Positioned(
                          top:10,
                          left:60,

                          child: Text('Complains',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.white),),)
                        ,
                        Positioned(
                            top:30,
                            left:60,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text('Resolved :',style: TextStyle(color: Colors.white,fontSize: 15),),
                                  Text(' 556',style: TextStyle(color: Colors.white,fontSize: 16)),
                                ],),
                                Row(children: [
                                  Text('Pending :',style: TextStyle(color: Colors.white,fontSize: 15)),
                                  Text(' 56',style: TextStyle(color: Colors.white,fontSize: 16)),
                                ],),

                              ],))

                        ,  Positioned(
                            top:10,
                            left:0,
                            child:Icon(Icons.report,color: Colors.white,size: 60,))
                      ],
                    );
                  }
              ),




              SizedBox(width: 6,),
              TweenAnimationBuilder(
                  duration: Duration(seconds: 2),
                  tween: Tween(begin: 0.1,end: 0.7),
                  builder: (context,val,o) {
                    return Stack(
                      children: [
                        Container(
                          height: 90,
                          width: size.width*0.21,
                          decoration: BoxDecoration(

                              gradient: LinearGradient(
                                  colors: [Colors.lightGreen.shade700,Colors.lightGreen]
                              ),
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)
                          ),


                        ),
                        Positioned(
                          top:10,
                          left:60,

                          child: Text('Farmers',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.white),),)
                        ,
                        Positioned(
                          top:30,
                          left:60,
                          child:Text('Total : 565',style: TextStyle(color: Colors.white,fontSize: 15)),)

                        ,  Positioned(
                            top:10,
                            left:0,
                            child:Icon(Icons.accessibility_sharp,color: Colors.white,size: 60,))
                      ],
                    );
                  }
              ),

            ],),

             Row(children: [
               SizedBox(width: 10,),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 Color_displayer_chart(name: 'Companies',color: Colors.blue,),
                 SizedBox(height: 5,),
                 Color_displayer_chart(name: 'Dealers',color: Colors.orange,),
                   SizedBox(height: 5,),
                 Color_displayer_chart(name: 'Farmers',color: Colors.lightGreen.shade700,),
               ],),
               PieChartPage(),
               Text('\n       Companies',style: TextStyle(fontWeight: FontWeight.bold)),
               LineChartWidget(
                 spots: [
                   FlSpot(0, 2),
                   FlSpot(1, 4),
                   FlSpot(2, 3),
                   FlSpot(3, 5),
                   FlSpot(4, 4),
                   FlSpot(5, 6),
                   FlSpot(6, 5),
                 ],
               ),




             ],),

                Text('\n      Farmers',style: TextStyle(fontWeight: FontWeight.bold),),

             StreamBuilder(
               stream: Firestore.instance.collection('farmers').stream,
                 builder: (context,snap){
                   if(!snap.hasData){
                     return show_progress_indicator(border_color: Colors.lightGreen,);
                   }
                   var data=snap.data!.asMap();
                   return  data.length==0 ? Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.no_drinks,size: 45,color: Colors.lightGreen,),
                       Text('No Farmers ',style: TextStyle(fontWeight: FontWeight.w500),),
                     ],):
                   Container(
                     height: size.height*0.35,
                     child: ListView.builder(
                       itemCount: data.length,
                         itemBuilder:(context,index){
                           final date = DateTime.parse('${data[index]!['date']}');
                           final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);
                          return Container(
                            padding: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(top: BorderSide(color: Colors.black12),bottom: BorderSide(color: Colors.black12) )
                            ),

                            child: Wrap(children: [
                             if( data[index]!['image']!='')
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, Myroute(View_Network_Image(url: data[index]!['image'],)));
                                },
                                child: Container(
                                  height:100,
                                  width: 150,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.grey)
                                  ),

                                  child:Image.network('${data[index]!['image']}',fit: BoxFit.fill,),),
                              ),
                              if( data[index]!['image']=='')
                              InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  height:100,
                                  width: 150,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.grey)
                                  ),

                                  child:Image.asset('images/noimage.png',fit: BoxFit.fill,),),
                              ),

                     Container(
                       width: size.width*0.7,
                       child: ListTile(
                         title: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                             Text('${data[index]!['name']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                             Text('Email :${data[index]!['email']}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                               Text('Date :${formattedDate}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),

                             ],),
                         trailing: ElevatedButton.icon(onPressed: () async {
                           EasyLoading.show(status:'Deleting');
                          try{
                            if(data[index]!['image']!=''){
                              new Database().deleteImage(data[index]!['image']);
                            }
                            var s=await Firestore.instance.collection('farmers').where('email',isEqualTo: '${data[index]!['email']}').get();
                            await Firestore.instance.collection('farmers').document(s[0].id).delete();
                            setState(() {
                              EasyLoading.showSuccess('Deleted');
                            });
                          }
                          catch(e){
                            EasyLoading.showError('Not Deleted');
                          }
                         }, icon: Icon(Icons.delete,color: Colors.white,), label: Text('Delete',style: TextStyle(color: Colors.white),))
                         ,
                       ),
                     )
                             ,

                            ],),
                          );
                         }),
                   );

             })








           ],
         ) ,
    );
  }
}





