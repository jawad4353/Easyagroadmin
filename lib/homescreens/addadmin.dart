import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easyagroadmin/home.dart';
import 'package:easyagroadmin/supporting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database.dart';


class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  var _image=null,hidepassword=true,countrycode='+92';
  TextEditingController email_controller=new TextEditingController();
  TextEditingController contact_controller=new TextEditingController();
  TextEditingController password_controller=new TextEditingController();
  TextEditingController name_controller=new TextEditingController();



  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        title:  Text('Admins',style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: size.height,
              width: size.width*0.5,

              child: StreamBuilder(
                stream: Firestore.instance.collection('admin').orderBy('name').get().asStream(),
                  builder: (context,snap){
                if(!snap.hasData){
                  return show_progress_indicator(border_color: Colors.lightGreen,);
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
                    child: Wrap(
                      children: [
                        Text('${index+1}     ',style: TextStyle(fontSize: 16,color: Colors.lightGreen,fontWeight: FontWeight.bold),),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, Myroute(View_Network_Image(url:data[index]!['image'] ,)));
                          },
                          child: Container(
                            height:80,
                            width: 120,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child:Image.network('${data[index]!['image']}',fit: BoxFit.fill,),),
                        ),
                        Container(
                          width: size.width*0.37,
                          child: ListTile(
                            isThreeLine: true,
                            onTap: () async {
                              SharedPreferences pref =await SharedPreferences.getInstance();
                              var current_email= await pref.getString("email");
                              Navigator.push(context,
                                  Myroute(Update_admin (image:data[index]!['image'] ,email: data[index]!['email'],
                                    contact: data[index]!['contact'],name: data[index]!['name'],current_email: current_email,
                                countrycode: data[index]!['countrycode'] ,id: data[index]!['id'], )));
                            },
                            title:Text('${data[index]!['name']}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                            subtitle: Text(' ${data[index]!['email']}\n${data[index]!['countrycode']+data[index]!['contact']}\nAdmin'
                              ,style: TextStyle(fontWeight: FontWeight.w500),) ,

                            trailing:Wrap(children: [
                              ElevatedButton.icon(onPressed: () async {
                                SharedPreferences pref =await SharedPreferences.getInstance();
                                var current_email= await pref.getString("email");
                                Navigator.push(context,
                                    Myroute(Update_admin (image:data[index]!['image'] ,email: data[index]!['email'],
                                      contact: data[index]!['contact'],name: data[index]!['name'],current_email: current_email,
                                      countrycode: data[index]!['countrycode'] ,id: data[index]!['id'], )));
                              },icon: Icon(Icons.update,color: Colors.white,),
                              label: Text('Update',style: TextStyle(color: Colors.white)),
                              ),
                              Text('  '),
                              ElevatedButton.icon(onPressed: () async {
                                SharedPreferences pref =await SharedPreferences.getInstance();
                               var current_email= await pref.getString("email");
                               if(current_email!=data[index]!['email'])
                                 {
                                try{
                                  new Database().deleteImage(data[index]!['image']);
                                  await Firestore.instance.collection('admin').document('${data[index]!['email']}').delete();
                                  EasyLoading.showSuccess('Deleted');
                                  setState(() {

                                  });
                                }
                                catch(e){
                                  EasyLoading.showError(' Error Deleting Image $e');
                                  return;
                                }
                              }
                               else{
                                 EasyLoading.showError('You cannot delete your Account !');
                                 return;
                               }
                               },icon: Icon(Icons.delete,color: Colors.white,),
                                label: Text('Delete',style: TextStyle(color: Colors.white)),),
                            ],) ,
                          ),
                        ),
                      ],
                    ),
                  );
                    }
                    );
              }),
            ),
            SizedBox(width: 6,),
            Container(
              width: size.width*0.27,
              padding: EdgeInsets.fromLTRB(13, 15, 13, 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(18)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Container(
                    width: size.width*0.26,
                    height: 200,
                    color: Colors.black12,
                    child: GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                        await FilePicker.platform.pickFiles(type: FileType.image);

                        if (result != null) {
                          setState(() {
                            _image = File(result.files.single.path!);
                          });
                        }
                      },
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : Icon(Icons.add_a_photo,size: 56,),
                    ),
                  ),

                  SizedBox(height: 20),
                  TextFormField(
                    controller: name_controller,
                    inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z.-. - ]')),],
                    decoration: const InputDecoration(
                      labelText: 'Name',

                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),

                  TextFormField(
                    controller: contact_controller,
                    inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                    decoration:  InputDecoration(
                      prefixIcon: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent
                          ),
                          onPressed: (){
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              countryListTheme: CountryListThemeData(
                                  inputDecoration: InputDecoration(
                                    hintText: 'Search',
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedErrorBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))  ,
                                    focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)) ,
                                    enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color:Colors.grey)) ,
                                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    border:  UnderlineInputBorder(borderSide: BorderSide(color:Colors.grey)),
                                  )
                              ),// optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  countrycode='+'+country.phoneCode;
                                });
                              },
                            );

                          }, child:Text('${countrycode}',style: TextStyle(color: Colors.black),)),
                      labelText: 'Contact',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: email_controller,
                    inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.-.@-@_-_]')),],
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller:password_controller ,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: [AsciiInputFormatter()],
                    obscureText: hidepassword,
                    decoration:  InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          hidepassword=!hidepassword;
                        });
                      }, icon: Icon(Icons.remove_red_eye)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: size.width*0.27,
                    child:ElevatedButton(onPressed: () async {
                      if(name_controller.text.isEmpty){
                        EasyLoading.showInfo('Name required');
                        return;
                      }
                      var a=name_controller.text.replaceAll(' ', '');
                      if(a.length<3){
                        EasyLoading.showInfo('Name must have three characters');
                        return;
                      }
                      if(contact_controller.text.isEmpty){
                        EasyLoading.showInfo('Contact required !');
                        return;
                      }

                      if(email_controller.text.isEmpty){
                        EasyLoading.showInfo('Email required');
                        return;
                      }
                      if(password_controller.text.isEmpty){
                        EasyLoading.showInfo('Password required');
                        return;
                      }

                      if(contact_controller.text.length!=10){
                        EasyLoading.showInfo('Enter 10 digit contact');
                        return;
                      }
                      var s=Email_Validation(email_controller.text);
                      var s1=Password_Validation(password_controller.text);
                      if(s[1]==Colors.red){
                        EasyLoading.showInfo('${s[0]}');
                        return;
                      }
                      if(s1[1]==Colors.red){
                        EasyLoading.showInfo('${s1[0]}');
                        return;
                      }
                      if(_image==null){
                        EasyLoading.showInfo('Upload Profile Picture !');
                        return;
                      }
                      EasyLoading.show(status: 'Processing',dismissOnTap: false);

                      final email_exists = await Firestore.instance.collection('admin').document('${email_controller.text}').exists;

                      if(email_exists){
                        EasyLoading.showInfo('Already Registered Email !');
                        return;
                      }
                      try{

                        final file = File(_image.path);
                        final imageUrl = await new Database().uploadImage(file,email_controller.text);
                        if(imageUrl!=null){
                          var s='${imageUrl['name']}'.replaceAll('@', '%40');
                          var s1='${s}'.replaceAll('/', '%2F');

                          final downloadUrl = 'https://firebasestorage.googleapis.com/v0/b/easyagro-ed808.appspot.com/o/${s1}?alt=media&token=${imageUrl['downloadTokens']}';
                          await Firestore.instance.collection('admin').document('${email_controller.text}').set({
                            'name': name_controller.text,
                            'email': email_controller.text,
                            'password': password_controller.text,
                            'image': '$downloadUrl',
                            'contact': contact_controller.text,
                            'countrycode':countrycode,
                            'id':new Database().getUniqueProductID()
                          });
                        }
                        EasyLoading.showSuccess('Registered');

                      }
                      catch(e){
                        EasyLoading.showError('Error Adding Admin ${e}');
                        return;
                      }


                      setState(() {
                        email_controller.text='';
                        contact_controller.text='';
                        countrycode='+92';
                        password_controller.text='';
                        name_controller.text='';
                        _image=null;
                      });

                      EasyLoading.dismiss();

                    },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen.shade700
                      ),
                      child: Text('Register',style: TextStyle(color: Colors.white),),),),


                ],
              ),
            ),
          ],
        ),


    );
  }
}





class AsciiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.replaceAll(RegExp(r'[^\x00-\x7F]'), ''),
      selection: newValue.selection,
    );
  }
}































class Update_admin extends StatefulWidget{
  var image,name,email,contact,current_email,countrycode,id;
  Update_admin({required this.image,required this.name,required this.email,required this.contact,required this.current_email,required this.countrycode,required this.id});
  @override
  State<Update_admin> createState() => _Update_adminState();
}

class _Update_adminState extends State<Update_admin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var countrycode='+92',hidepassword=true,_image=null;
  TextEditingController email_controller=new TextEditingController();
  TextEditingController contact_controller=new TextEditingController();
  TextEditingController name_controller=new TextEditingController();
  @override

  void initState() {
    email_controller.text=widget.email;
    contact_controller.text=widget.contact;
    name_controller.text=widget.name;

    super.initState();
  }
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
  return Scaffold(
    appBar: PreferredSize(
        preferredSize: Size(30,30),
        child:   MyAppBar(),),
    backgroundColor: Colors.white,
    body: Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.lightGreen.shade700,
        image: DecorationImage(
            image: Image.asset('images/back2.jpg').image,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.dstATop,
            )
        ),
      ),

      child: Center(
        child: Padding(
          padding:  EdgeInsets.all(3.0),
          child: Container(
            width: size.width*0.32,
            padding: EdgeInsets.fromLTRB(13, 15, 13, 15),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(18)
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                 Row(children: [
                   IconButton(onPressed: (){
                     Navigator.of(context).pop();
                   }, icon:Icon(Icons.arrow_back)),
                   Text('Update',style: TextStyle(fontWeight: FontWeight.w500),)
                 ],),
                  Container(
                    width: size.width*0.32,
                    height: 200,
                    color: Colors.black12,
                    child: GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                        await FilePicker.platform.pickFiles(type: FileType.image);

                        if (result != null) {
                          setState(() {
                            _image = File(result.files.single.path!);
                          });
                        }
                      },
                      child: _image != null
                          ? Image.file(_image !, fit: BoxFit.fill)
                          : Image.network('${widget.image}',fit: BoxFit.fitWidth,),
                    ),
                  ),

                  SizedBox(height: 20),
                  TextFormField(
                    controller: name_controller,
                    inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z.-. - ]')),],
                    decoration: const InputDecoration(
                      labelText: 'Name',

                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),

                  TextFormField(
                    controller: contact_controller,
                    inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                    decoration:  InputDecoration(
                      prefixIcon: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent
                          ),
                          onPressed: (){
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              countryListTheme: CountryListThemeData(
                                  inputDecoration: InputDecoration(
                                    hintText: 'Search',
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedErrorBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))  ,
                                    focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)) ,
                                    enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color:Colors.grey)) ,
                                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    border:  UnderlineInputBorder(borderSide: BorderSide(color:Colors.grey)),
                                  )
                              ),// optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  widget.countrycode='+'+country.phoneCode;
                                });
                              },
                            );

                          }, child:Text('${widget.countrycode}',style: TextStyle(color: Colors.black),)),
                      labelText: 'Contact',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: email_controller,
                    inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.-.@-@_-_]')),],
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    width: size.width*0.27,
                    child:ElevatedButton(onPressed: () async {
                      if(name_controller.text.isEmpty){
                        EasyLoading.showInfo('Name required');
                        return;
                      }
                      var a=name_controller.text.replaceAll(' ', '');
                      if(a.length<3){
                        EasyLoading.showInfo('Name must have three characters');
                        return;
                      }
                      if(a.length>30){
                        EasyLoading.showInfo('Name should not exceed 30 characters');
                        return;
                      }
                      if(contact_controller.text.isEmpty){
                        EasyLoading.showInfo('Contact required !');
                        return;
                      }

                      if(email_controller.text.isEmpty){
                        EasyLoading.showInfo('Email required');
                        return;
                      }

                      if(contact_controller.text.length!=10){
                        EasyLoading.showInfo('Enter 10 digit contact');
                        return;
                      }
                      var s=Email_Validation(email_controller.text);

                      EasyLoading.show(status: 'Processing',dismissOnTap: false);

                      final email_exists = await new Database().Check_duplicateEmail(email_controller.text,widget.id);
                       print(email_exists);
                      if(email_exists){
                        EasyLoading.showInfo('Already Registered Email !');
                        return;
                      }


                      try{
                        if(_image==null){
                          await Firestore.instance.collection('admin').document('${email_controller.text}').update({
                            'name': name_controller.text,
                            'email': email_controller.text,
                            'contact': contact_controller.text,
                            'countrycode':'${widget.countrycode}'
                          });
                          EasyLoading.showSuccess('Updated');
                          Navigator.pushReplacement(context, Myroute(home(index: 5,)));
                          return ;
                        }
                        final file = File(_image.path);
                        final imageUrl = await new Database().uploadImage(file,email_controller.text);
                        if(imageUrl!=null){
                          var s='${imageUrl['name']}'.replaceAll('@', '%40');
                          var s1='${s}'.replaceAll('/', '%2F');

                          final downloadUrl = 'https://firebasestorage.googleapis.com/v0/b/easyagro-ed808.appspot.com/o/${s1}?alt=media&token=${imageUrl['downloadTokens']}';
                          await Firestore.instance.collection('admin').document('${email_controller.text}').update({
                            'name': name_controller.text,
                            'email': email_controller.text,
                            'image': '$downloadUrl',
                            'contact': contact_controller.text,
                            'countrycode':'${widget.countrycode}'
                          });
                        }

                        EasyLoading.showSuccess('Updated');
                        Navigator.pushReplacement(context, Myroute(home(index: 5,)));
                      }
                      catch(e){
                        EasyLoading.showError('Error Updating Admin ${e}');
                        return;
                      }




                      EasyLoading.dismiss();

                    },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen.shade700
                      ),
                      child: Text('Update',style: TextStyle(color: Colors.white),),),),


                ],

            ),
          ),
        ),
      ),
    ) ,
  );
  }
}