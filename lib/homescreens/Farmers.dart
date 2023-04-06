

import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:select_form_field/select_form_field.dart';

import '../supporting.dart';

class Farmers extends StatefulWidget{
  @override
  State<Farmers> createState() => _FarmersState();
}

class _FarmersState extends State<Farmers> {
 var  _selectedSoilType;
 TextEditingController _soilTypeController=new TextEditingController();
 TextEditingController _Crop_name_Controller=new TextEditingController();

  final List<Map<String, dynamic>> _soilTypeOptions = [
    {'value': 'Loamy', 'label': 'Loamy'},
    {'value': 'Sandy', 'label': 'Sandy'},
    {'value': 'Clay', 'label': 'Clay'},
    {'value': 'Silt', 'label': 'Silt'},  ];
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
     body:Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
       SingleChildScrollView(
         child: Column(children: [
           Container(
             height: size.height*0.25,
             width: size.width*0.6,

             child: StreamBuilder(
                 stream: Firestore.instance.collection('cropname').get().asStream(),
                 builder: (context,snap){
                   if(!snap.hasData){
                     return show_progress_indicator();
                   }
                   var data=snap.data!.asMap();
                   return ListView.builder(
                       itemCount: data.length,
                       itemBuilder:(context,index){
                         return Container(
                           decoration: BoxDecoration(
                             border: Border(
                               bottom: BorderSide(
                                 color: Colors.black12,
                                 width: 1.0,
                               ),
                             ),
                           ),
                           child: ListTile(
                             onTap: () async {
                             },
                             title:Text('${data[index]!.id}'),


                           ),
                         );
                       }
                   );
                 }),
           ),
           Container(
             height: size.height*0.74,
             width: size.width*0.4,

             child: StreamBuilder(
                 stream: Firestore.instance.collection('crops').get().asStream(),
                 builder: (context,snap){
                   if(!snap.hasData){
                     return show_progress_indicator();
                   }
                   var data=snap.data!.asMap();
                   return ListView.builder(
                       itemCount: data.length,
                       itemBuilder:(context,index){
                         return Container(
                           decoration: BoxDecoration(
                             border: Border(
                               bottom: BorderSide(
                                 color: Colors.black12,
                                 width: 1.0,
                               ),
                             ),
                           ),
                           child: ListTile(
                             onTap: () async {
                             },
                             title:Text('${data[index]!.id}'),


                           ),
                         );
                       }
                   );
                 }),
           ),
         ],),
       ),


          Container(
            width: 350,
            child: ListView(
              children: [
                SizedBox(height: 19,),
               Container(
                 padding:  EdgeInsets.only(left: 30,right: 30,top: 20),
                 decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey),
                     borderRadius: BorderRadius.circular(20)
                 ),
                 child: Column(
                   mainAxisSize: MainAxisSize.max,
                   children: [
                     Center(child: Text('Add new Crop\n',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                   TextFormField(
                     controller: _Crop_name_Controller,
                     inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z.-. - ]')),],
                     decoration: InputDecoration(
                         labelText: "Crop Name",
                         border: OutlineInputBorder()
                     ),
                   ),
                   SizedBox(height: 9,),
                   Container(
                       width: double.infinity,
                       child: ElevatedButton(onPressed: () async {
                         if(_Crop_name_Controller.text.isEmpty){
                           EasyLoading.showInfo('Add new Cropname !');
                           return;
                         }
                         if(_Crop_name_Controller.text.replaceAll(' ', '').length<2){
                           EasyLoading.showInfo('Crop Name must have 2 characters');
                           return;
                         }
                         if(_Crop_name_Controller.text.replaceAll(' ', '').length>20){
                           EasyLoading.showInfo('Crop Name must have  less than 20 characters');
                           return;
                         }
                         EasyLoading.show(status: 'processing');
                         var exist= await Firestore.instance.collection('cropname').document('${_Crop_name_Controller.text.toLowerCase()}').exists;
                         if(exist){
                           EasyLoading.showInfo('Already registered crop.\n${_Crop_name_Controller.text.toLowerCase()}');
                           return;
                         }

                         Firestore.instance.collection('cropname').document('${_Crop_name_Controller.text.toLowerCase()}').set({
                           'name':'${_Crop_name_Controller.text.toLowerCase()}'
                         });
                         EasyLoading.showSuccess('Crop Added');



                       }, child: Text('Add Crop',style: TextStyle(color: Colors.white),)))
                   ,
                     SizedBox(height: 9,),
                 ],),
               ),
                SizedBox(height: 9,),
                Container(
                   width: 350,
                   padding:  EdgeInsets.only(left: 30,right: 30,top: 20),
                   height: size.height*0.65,
                   decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey),
                       borderRadius: BorderRadius.circular(20)
                   ),
                   child: ListView(
                     children: [
                       Center(child: Text('Add Fertilizer Quantity\n',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                       SelectFormField(
                         controller: _soilTypeController,
                         style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
                         decoration: InputDecoration(
                           border: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.green),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.green,width: 2),
                           ),
                           labelText: 'Soil Type',
                         ),
                         items: _soilTypeOptions,
                         onChanged: (val) => setState(() {
                           _selectedSoilType = val;

                         }),
                         onSaved: (val) => setState((){
                           _selectedSoilType = val;

                         }),
                       ),
                       SizedBox(height: 9,),
                       TextFormField(
                         decoration: InputDecoration(
                             labelText: "Crop Name",
                             border: OutlineInputBorder()
                         ),
                       ),
                       SizedBox(height: 9,),
                       TextFormField(
                         decoration: InputDecoration(labelText: "Phosphorus(KG) Marla",
                             border: OutlineInputBorder()
                         ),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),
                       TextFormField(
                         decoration: InputDecoration(labelText: "Potassium(KG) Marla",
                             border: OutlineInputBorder()
                         ),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),
                       TextFormField(
                         decoration: InputDecoration(labelText:"Nitrogen(KG) Marla",
                             border: OutlineInputBorder()),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),

                       TextFormField(
                         decoration: InputDecoration(labelText: "Zinc(KG) Marla",
                             border: OutlineInputBorder()
                         ),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),
                       TextFormField(
                         decoration: InputDecoration(labelText: "Calcium(KG) Marla",
                             border: OutlineInputBorder()
                         ),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),
                       ElevatedButton(onPressed: (){}, child: Text('Register',style: TextStyle(color: Colors.white),))


                     ],
                   ),

         ),
              ],
            ),
          ),
       ],
     )

    );
  }
}