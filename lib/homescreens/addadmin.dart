import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easyagroadmin/supporting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      backgroundColor: Colors.lightGreen.shade700,
      appBar: AppBar(
        title:  Text('Register Admin'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen.shade700,
        elevation: 0,
      ),
      body:  Center(
          child: Container(
            width: size.width*0.27,
            padding: EdgeInsets.fromLTRB(13, 15, 13, 15),
            decoration: BoxDecoration(
              color: Colors.white,
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
                   final result = await Firestore.instance.collection('admin').document('${email_controller.text}').get();

                  try{

                    final file = File(_image.path);
                    final imageUrl = await new Database().uploadImage(file);
                    if(imageUrl!=null){
                       final downloadUrl = 'https://firebasestorage.googleapis.com/v0/b/easyagro-ed808.appspot.com/o/${imageUrl['name']}?alt=media&token=${imageUrl['downloadTokens']}';
                      await Firestore.instance.collection('admin').document('${email_controller.text}').set({
                        'name': name_controller.text,
                        'email': email_controller.text,
                        'password': password_controller.text,
                        'image': '$downloadUrl',
                        'contact': contact_controller.text,
                      });
                    }

                  }
                   catch(e){
                     EasyLoading.showError('Error Adding Admin ${e}');
                     print(e);
                     return;
                   }





                 },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.lightGreen.shade700
                   ),
                   child: Text('Register',),),)
                  ],
                ),
          ),
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