
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../supporting.dart';

class Diseases extends StatefulWidget{
  @override
  State<Diseases> createState() => _DiseasesState();
}

class _DiseasesState extends State<Diseases> {
  TextEditingController disease_name_controller=new TextEditingController();
  TextEditingController description_controller=new TextEditingController();
  TextEditingController affecting_crop_control=new TextEditingController();
  TextEditingController youtube_link_controller=new TextEditingController();
  var s=0;



  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Diseases',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),backgroundColor: Colors.white,elevation: 0,),
      backgroundColor: Colors.white,
      body: Row(children: [

        Container(
          width: size.width*0.62,
          color: Colors.transparent,
        child: StreamBuilder(
          stream: Firestore.instance.collection('diseases').get().asStream(),
          builder: (context,snap){
            if(!snap.hasData){
              return show_progress_indicator();
            }
            var data=snap.data!.asMap();

           return data.length==0 ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.no_drinks),
                Text('No Diseases'),
              ],):
           ListView.builder(
             itemCount: data.length,
               itemBuilder: (context,index){
               return InkWell(
                 hoverColor: Colors.lightGreen,
                onTap: (){
                  setState(() {

                    disease_name_controller.text='${data[index]!['name']}';
                    description_controller.text='${data[index]!['description']}';
                    affecting_crop_control.text='${data[index]!['affectingcrops']}';
                    youtube_link_controller.text='${data[index]!['youtubelink']}';
                  });
                },
                 child: ListTile(
                   trailing: Wrap(children: [
                     ElevatedButton(onPressed: (){
                       setState(() {
                         disease_name_controller.text='${data[index]!['name']}';
                         description_controller.text='${data[index]!['description']}';
                         affecting_crop_control.text='${data[index]!['affectingcrops']}';
                         youtube_link_controller.text='${data[index]!['youtubelink']}';
                       });
                     }, child: Icon(Icons.update,color: Colors.white,)),
                     Text('  '),
                     ElevatedButton(onPressed: () async {
                       EasyLoading.show(status: 'deleting');
                       try{
                        await Firestore.instance.collection('diseases').document('${data[index]!['name']}').delete().whenComplete(() =>   setState(() {
                          s=78;
                        }));

                        EasyLoading.dismiss();
                       }
                       catch(e){
                         EasyLoading.showError('$e');
                       }

                     }, child: Icon(Icons.delete,color: Colors.white,)),
                   ],),
                   title: Text('${data[index]!['name']}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                   subtitle: Text('${data[index]!['affectingcrops']}'),
                 ),
               );
               }

           );
          },
        ),
        ),
        Container(

          width: size.width*0.26,
          height: size.height*0.8,
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.0,color: Colors.grey)
          ),
          child: Padding(
            padding:  EdgeInsets.only(left: 20,right: 20,top: 20),
            child: ListView(
              children: [
                Center(child: Text('Add/Update Disease\n',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                TextFormField(
                  controller: disease_name_controller,
                  inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z.-. - 0-9]')),],
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: 'Lasota',
                      border: OutlineInputBorder()
                  ),
                ),
               SizedBox(height: 7,),
                TextFormField(
                  controller: description_controller,
                  maxLines: 10,
                        decoration: InputDecoration(
                            labelText: "Description",
                            hintText: 'This is very dangerous ..',
                            border: OutlineInputBorder()
                        ),
                      ),


                SizedBox(height: 7,),
                TextFormField(
                  controller: affecting_crop_control,
                  maxLines: 4,
                  inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z.-. - ,-,]')),],
                  decoration: InputDecoration(
                      labelText: "Affecting Crops",
                      hintText: 'Corn , Maiz , ',
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 7,),
                TextFormField(
                  controller: youtube_link_controller,
                  decoration: InputDecoration(
                      labelText: "Youtube video link",
                      hintText: 'http:youtube.com/ff/d',
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 7,),
                ElevatedButton(onPressed: (){
                  if(disease_name_controller.text.isEmpty){
                    EasyLoading.showInfo(' Disease name required !');
                    return;
                  }
                  if(disease_name_controller.text.replaceAll(' ', '').length<3){
                    EasyLoading.showInfo(' Disease name must have three characters !');
                    return;
                  }
                  if(description_controller.text.isEmpty){
                    EasyLoading.showInfo(' Description required !');
                    return;
                  }

                  if(description_controller.text.replaceAll(' ', '').length<50){
                    EasyLoading.showInfo(' Description must have 50 characters !');
                    return;
                  }

                  if(affecting_crop_control.text.isEmpty){
                    EasyLoading.showInfo(' Affecting crops required .Enter comma after each crop !');
                    return;
                  }
                  if(youtube_link_controller.text.isEmpty){
                    EasyLoading.showInfo(' Youtube video link required!');
                    return;
                  }

                  EasyLoading.show(status: 'processing');
                try{
                    Firestore.instance.collection('diseases').document('${disease_name_controller.text}').set({
                      'name':'${disease_name_controller.text}',
                      'description':'${description_controller.text}',
                      'affectingcrops':'${affecting_crop_control.text}',
                      'youtubelink':'${youtube_link_controller.text}',
                    }).whenComplete(() =>  setState(() {
                      s=4;
                      EasyLoading.showSuccess('Added/Updated');
                    }));

                }
                  catch(e){
                    EasyLoading.showError('${e}');
                  }


                }, child: Text('Add/Update',style: TextStyle(color: Colors.white),))
              ],),
          )






        )

      ],),

    );
  }
}