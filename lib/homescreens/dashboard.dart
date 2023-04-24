

import 'dart:async';

import 'package:easyagroadmin/supporting.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers.dart';



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
         body:Wrap(
           children: [


             // Consumer<ValueProvider>(
             //   builder: (context, valueProvider, child) {
             //     return Text('Total : ${valueProvider.value}',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),);
             //   },
             // ),
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

            Container(
              height: size.height*0.8,
              child: ListView(children: [
                Text('\n      Companies',style: TextStyle(fontWeight: FontWeight.bold),),
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
                Text('\n      Dealers',style: TextStyle(fontWeight: FontWeight.bold)),
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
                Text('\n       Farmers',style: TextStyle(fontWeight: FontWeight.bold)),
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

                Text('\n          Complains',style: TextStyle(fontWeight: FontWeight.bold)),
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
            )




           ],
         ) ,
    );
  }
}






class LineChartWidget extends StatelessWidget {
  final List<FlSpot> spots;

  const LineChartWidget({Key? key, required this.spots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.lightGreen,
              barWidth: 3,
              dotData: FlDotData(show: false),
            ),
          ],
          minX: 0,
          maxX: spots.length.toDouble() - 1,
          minY: 0,
          maxY: _calculateMaxY(spots),
        ),
      ),
    );
  }

  double _calculateMaxY(List<FlSpot> spots) {
    double maxY = 0;

    for (var spot in spots) {
      if (spot.y > maxY) {
        maxY = spot.y;
      }
    }

    return maxY + 2;
  }
}


