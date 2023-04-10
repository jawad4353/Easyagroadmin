

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easyagroadmin/home.dart';
import 'package:firedart/firestore/firestore.dart';
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
                     return show_progress_indicator();
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

                          Container(
                               height:70,
                               width: 120,
                               clipBehavior: Clip.antiAlias,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12),
                                 border: Border.all(color: Colors.black12)
                               ),
                               child:Image.network('${data[index]!['profileimage']}',fit: BoxFit.fill,),),

                           Container(
                             width: size.width*0.7,
                             padding: EdgeInsets.only(bottom: 17),
                             decoration: BoxDecoration(
                               border: Border(bottom: BorderSide(color: Colors.black12))
                             ),
                             child: ListTile(
                               onTap: (){
                                 Navigator.push(context, Myroute(View_Companydetails(id:data[index]!['license'] ,)));
                               },
                               title: Text('${data[index]!['name']}',style: TextStyle(fontWeight: FontWeight.w500),),
                               trailing: ElevatedButton.icon(onPressed: (){
                                 Navigator.push(context, Myroute(View_Companydetails(id:data[index]!['license'] ,)));
                               },
                                 icon:Icon(Icons.remove_red_eye,color: Colors.white,),label: Text('View',style: TextStyle(color: Colors.white),),),
                               subtitle: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                 Text('${data[index]!['phone']}',style: TextStyle(fontWeight: FontWeight.w500),),
                                   Text('${data[index]!['email']}',style: TextStyle(fontWeight: FontWeight.w500),),
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
                 return show_progress_indicator();
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


class View_Companydetails extends StatefulWidget{
  var id;
  View_Companydetails({required this.id});
  @override
  State<View_Companydetails> createState() => _View_CompanydetailsState();
}

class _View_CompanydetailsState extends State<View_Companydetails> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        leadingWidth: 110,
        leading:   Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/appicona.png',height: 50,),
            Text('  EasyAgro',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 14),),
          ],),
        actions: [
          TextButton(onPressed: (){
            appWindow.minimize();
          }, child: Text('—',style: TextStyle(color: Colors.grey,fontSize: 20),),),
          IconButton(onPressed: (){
            if(appWindow.isMaximized){
              appWindow.size=Size(800,800);
              appWindow.maximizeOrRestore();

            }

            if(appWindow.size.height<size.height){
              appWindow.maximize();

            }

          }, icon: Icon(Icons.web_asset,color: Colors.grey,size: 20,)),
          IconButton(onPressed: (){
            appWindow.close();
          }, icon: Icon(Icons.close,color: Colors.grey,size: 20,)),

        ],),
       body:ListView(children: [
         Text('\n  Verify\n',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
         Container(
           height: size.height*0.3,
           color: Colors.white,
           child: StreamBuilder(
             stream: Firestore.instance.collection('company').where('license',isEqualTo: widget.id).get().asStream(),
             builder: (context,snap){
               if(!snap.hasData){
                 return show_progress_indicator();
               }
               var data=snap.data!.asMap();
               return ListView.builder(
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
       ],) ,
    );
  }
}



