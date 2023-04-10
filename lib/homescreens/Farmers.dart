

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
 var  _selectedSoilType,_selectedcrop_name,trigger=0;
 TextEditingController _soilTypeController=new TextEditingController();
 TextEditingController _crop_Controller=new TextEditingController();
 TextEditingController _Crop_name_Controller=new TextEditingController();

 TextEditingController phosphorus_Controller=new TextEditingController();
 TextEditingController potassium_Controller=new TextEditingController();
 TextEditingController nitrogen_Controller=new TextEditingController();
 TextEditingController zinc_Controller=new TextEditingController();
 TextEditingController calcium_Controller=new TextEditingController();
 TextEditingController from_temp_controller=new TextEditingController();
 TextEditingController to_temp_controller=new TextEditingController();


 List<Map<String, dynamic>> _crops=[];

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
     appBar: AppBar(title: Text('  Crops',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),backgroundColor: Colors.white,elevation: 0,),
     body:Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [

        Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           SingleChildScrollView(
             child: Container(
               height: size.height*0.25,
               width: size.width*0.6,

               child:  StreamBuilder(
                     stream: Firestore.instance.collection('cropname').get().asStream(),
                     builder: (context,snap){
                       if(!snap.hasData){
                         return show_progress_indicator(border_color: Colors.lightGreen,);
                       }
                       var data=snap.data!.asMap();

                       return data.length==0 ? Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                         Icon(Icons.no_drinks),
                         Text('No crops'),
                       ],) : ListView.builder(
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
                                 leading:  Text('${index+1}     ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.lightGreen),),
                                 trailing: ElevatedButton.icon(onPressed: (){
                                   Firestore.instance.collection('cropname').document('${data[index]!.id}').delete();
                                   EasyLoading.showSuccess('Deleted');
                                   setState(() {

                                   });
                                 },icon: Icon(Icons.delete,color: Colors.white,),
                                   label: Text('Delete',style: TextStyle(color: Colors.white)),),
                                 title:  Text('${data[index]!['name']}', style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
                                 subtitle:   Text('Min : ${data[index]!['minimum']}°C   Max : ${data[index]!['maximum']}°C', style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.grey),),


                               ),
                             );
                           }
                       );
                     }),

             ),
           ),

             Text(''),
           Text('Fertilizer Quantity ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
             Text(''),
           SingleChildScrollView(
             child: Container(
              height: size.height*0.56,
               width: size.width*0.6,


               child: StreamBuilder(
                   stream: Firestore.instance.collection('crops').orderBy('cropname').get().asStream(),
                   builder: (context,snap){
                     if(!snap.hasData){
                       return show_progress_indicator(border_color: Colors.lightGreen,);
                     }
                     var data=snap.data!.asMap();

                     return  data.length==0 ? Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.no_drinks),
                         Text('You have not added fertilizer amount for any crop'),
                       ],):  ListView.builder(
                         itemCount: data.length,
                         itemBuilder:(context,index)

                         {
                           var name=data[index]!.id.split('+');
                           return
                              ListTile(
                                isThreeLine: true,
                               onTap: () async {
                               },
                                leading:  Text('${index+1}     ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.lightGreen),),
                                trailing: Wrap(children: [
                                  ElevatedButton.icon(onPressed: (){
                                    setState(() {

                                      _soilTypeController.text=name[0];
                                      _crop_Controller.text=name[1];
                                      calcium_Controller.text='${data[index]!['calcium']}';
                                      nitrogen_Controller.text='${data[index]!['nitrogen']}';
                                      potassium_Controller.text='${data[index]!['potassium']}';
                                      phosphorus_Controller.text='${data[index]!['phosphorus']}';
                                      zinc_Controller.text='${data[index]!['zinc']}';
                                    });
                                  }, icon:Icon(Icons.update,color: Colors.white,),
                                    label: Text('Update',style: TextStyle(color: Colors.white)),),
                                  Text('  '),
                                  ElevatedButton.icon(onPressed: (){
                                    EasyLoading.show(status: 'Deleting');
                                    Firestore.instance.collection('crops').document(data[index]!.id).delete();
                                    setState(() {
                                       EasyLoading.dismiss();
                                    });
                                  }, icon:Icon(Icons.delete,color: Colors.white,),
                                    label: Text('Delete',style: TextStyle(color: Colors.white)),),
                                ],),
                               title:Text('${name[0]}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                subtitle:Wrap(children: [

                                  Text('${name[1]} ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  Text('  '),
                                  Text(data[index]!['nitrogen']==''? '' :' N : ${data[index]!['nitrogen']}  ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                  Text(data[index]!['calcium']==''? '' :' Ca : ${data[index]!['calcium']}   ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                  Text(data[index]!['zinc']==''? '' :' Zn : ${data[index]!['zinc']}    ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                  Text(data[index]!['potassium']==''? '' :' K2O : ${data[index]!['potassium']}   ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                  Text(data[index]!['phosphorus']==''? '' :'P2O5 : ${data[index]!['phosphorus']}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                ],),

                           );
                         }
                     );
                   }),
             ),
           ),
         ],
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
                         hintText: 'Rice',
                         border: OutlineInputBorder()
                     ),
                   ),
                   Text('Optimum Temperature',style: TextStyle(fontWeight: FontWeight.w500),),
                   Wrap(children: [
                     Container(
                       width:130,
                       child: TextFormField(
                         controller: from_temp_controller,
                         inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9.-.---]')),],
                         decoration: InputDecoration(
                             labelText: "Minimum",
                             hintText: '2 °C',
                             border: OutlineInputBorder()
                         ),
                       ),
                     ),
                     SizedBox(width: 2,),
                     Container(
                       width:130,
                       child: TextFormField(
                         controller: to_temp_controller,
                         inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9.-.]')),],
                         decoration: InputDecoration(
                             labelText: "Maximum",
                             hintText: '55 °C',
                             border: OutlineInputBorder()
                         ),
                       ),
                     ),
                   ],),
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
                         if(from_temp_controller.text.isEmpty){
                           EasyLoading.showInfo('Minimum temperature required !');
                           return;
                         }
                         if(to_temp_controller.text.isEmpty){
                           EasyLoading.showInfo('Maximum temperature required !');
                           return;
                         }
                         if(int.parse('${from_temp_controller.text}')<-20){
                           EasyLoading.showInfo('Minimum temperature must be lesser than -20');
                           return;
                         }
                         if(int.parse('${to_temp_controller.text}')>55){
                           EasyLoading.showInfo('Maximum temperature must be lesser than 55');
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
                        try{
                        await Firestore.instance.collection('cropname').document('${_Crop_name_Controller.text.toLowerCase()}').set({
                        'name':'${_Crop_name_Controller.text}',
                        'minimum':'${from_temp_controller.text}',
                        'maximum':'${to_temp_controller.text}'
                         }).whenComplete(() =>setState(() {
                        trigger=5;
                         }) );
                         EasyLoading.showSuccess('Crop Added');
                          }
                         catch(e){
                         var s='$e'.split(']');
                         EasyLoading.showSuccess('Error : ${s[1]}');
                         }



                       }, child: Text('Add Crop',style: TextStyle(color: Colors.white),)))
                   ,
                     SizedBox(height: 9,),
                 ],),
               ),





                SizedBox(height: 19,),
                Container(
                   width: 350,
                   padding:  EdgeInsets.only(left: 30,right: 30,top: 20),
                   height: size.height*0.59,
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
                       StreamBuilder(
                         stream: Firestore.instance.collection('cropname').stream,
                         builder: (context, snapshot) {
                           if(!snapshot.hasData){
                             return show_progress_indicator(border_color: Colors.lightGreen,);
                           }
                           _crops.clear();
                          var data= snapshot.data!.asMap();
                          for(int i=0;i<data.length;i++){
                             _crops.add({'value':'${data[i]!['name']}','label':'${data[i]!['name']}'});
                          }


                           return  data.length==0 ? Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.no_drinks),
                               Text('No crops'),
                             ],): SelectFormField(
                             controller: _crop_Controller,
                             style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
                             decoration: InputDecoration(
                               border: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.green),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.green,width: 2),
                               ),
                               labelText: 'Crop',
                             ),
                             items: _crops,
                             onChanged: (val) => setState(() {
                               _selectedcrop_name = val;

                             }),
                             onSaved: (val) => setState((){
                               _selectedcrop_name = val;

                             }),
                           );
                         }
                       ),
                       SizedBox(height: 9,),
                       TextFormField(
                         controller: phosphorus_Controller,
                         inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9.-.]')),],
                         decoration: InputDecoration(labelText: "Phosphorus P2O5 (KG) per Acre",
                             hintText: '65 KG',
                             border: OutlineInputBorder()
                         ),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),
                       TextFormField(
                         controller: potassium_Controller,
                         inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9.-.]')),],
                         decoration: InputDecoration(labelText: "Potassium K2O(KG) per Acre",
                             hintText: '75 KG',
                             border: OutlineInputBorder()
                         ),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),
                       TextFormField(
                         inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9.-.]')),],
                         controller: nitrogen_Controller,
                         decoration: InputDecoration(labelText:"Nitrogen (KG) per Acre",
                             hintText: '95 KG',
                             border: OutlineInputBorder()),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),

                       TextFormField(
                         inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9.-.]')),],
                         controller: zinc_Controller,
                         decoration: InputDecoration(labelText: "Zinc(KG) per Acre",
                             hintText: '5 KG',
                             border: OutlineInputBorder()
                         ),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),
                       TextFormField(
                         inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9.-.]')),],
                         controller: calcium_Controller,
                         decoration: InputDecoration(labelText: "Calcium(KG) per Acre",
                             hintText: '35 KG',
                             border: OutlineInputBorder()
                         ),
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                       ),
                       SizedBox(height: 9,),
                       ElevatedButton(onPressed: () async {
                         if(_soilTypeController.text.isEmpty){
                           EasyLoading.showInfo('Select Soil Type !');
                           return;
                         }
                         if(_crop_Controller.text.isEmpty){
                           EasyLoading.showInfo('Select Crop !');
                           return;
                         }
                         if(nitrogen_Controller.text.isEmpty && phosphorus_Controller.text.isEmpty && zinc_Controller.text.isEmpty &&
                         potassium_Controller.text.isEmpty && calcium_Controller.text.isEmpty
                         ){

                           EasyLoading.showInfo('Must enter atleast one element !');
                           return;
                         }

                         EasyLoading.show(status: 'Processing');

                        try{
                          await Firestore.instance.collection('crops').document('${_soilTypeController.text}+${_crop_Controller.text}').set({
                            'nitrogen':'${nitrogen_Controller.text}',
                            'phosphorus':'${phosphorus_Controller.text}',
                            'potassium':'${potassium_Controller.text}',
                            'calcium':'${calcium_Controller.text}',
                            'zinc':'${zinc_Controller.text}',
                            'cropname':'${_crop_Controller.text.toLowerCase()}'
                          }).whenComplete(() =>  setState(() {
                            trigger=1;
                          }));
                          EasyLoading.showSuccess('Added');
                        }
                        catch(e){
                          var s='$e'.split(']');
                          EasyLoading.showSuccess('Error : ${s[1]}');
                        }






                       }, child: Text('Register',style: TextStyle(color: Colors.white),))


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