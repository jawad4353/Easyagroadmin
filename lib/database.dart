

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class Database{

  Admin_Login(email,password) async {
    var s='';
    try{
      await Firestore.instance.collection("admin").get().then((querySnapshot) {
        querySnapshot.forEach((result) {
          if(email==result.map['email'] && password==result.map['password']){
            s=result.map['name'];
          }
        });
      });
      return s;
    }

    catch(e){
    var error='${e}'.split(']');
    EasyLoading.showError('${error[1]}');

    }
  }


 Email_Exists(collectionname,email) async {
    var name='';
  try{
    await Firestore.instance.collection("$collectionname").get().then((querySnapshot) {
      querySnapshot.forEach((result) {
        if(email==result.map['email'] ){
          name=result.map['name'];
        }
      });
    });
    return name;
  }
  catch(e){
    var error='${e}'.split(']');
    EasyLoading.showError('${error[1]}');

  }
 }




  Update_Password(collectionname,email,newpassword) async {
    var updated=false;
    try{
      await Firestore.instance.collection("$collectionname").get().then((querySnapshot) {
        querySnapshot.forEach((result) {
          if(email==result.map['email'] ){
            Firestore.instance.collection("$collectionname").document(result.id).update({'password':'${newpassword}'});
            updated=true;
          }
        });
      });
      return updated;
    }
    catch(e){
      var error='${e}'.split(']');
      EasyLoading.showError('${error[1]}');

    }
  }






 uploadImage(File imageFile,email) async {
    try {
      final response = await http.post(Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/easyagro-ed808.appspot.com/o?uploadType=media&name=adminimages/$email'),
          body: await imageFile.readAsBytesSync(), headers: {
          'Content-Type': '.png',
        },);
      if (response.statusCode == 200) {
        final downloadUrl = jsonDecode(response.body);
        return downloadUrl;
      } else {
        print('Error uploading image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> deleteImage(url) async {
  try{
    final response = await http.delete(Uri.parse(url));
  }
  catch(e){
    print('error $e');
  }
  }
  

  Check_duplicateEmail(email,id) async {

    var exists=false;
    var dat=await Firestore.instance.collection('admin').get();
    var data=dat.asMap().forEach((key, value) {
             if(value.map['email']==email  &&  value.map['id']!=id ){
               exists=true;
             }
    }) ;
  return exists;
    }





  String getUniqueProductID() {
    var uuid = Uuid();
    var random = Random();
    String uniqueID = uuid.v4();
    int randomInt = random.nextInt(100000);
    return "user-$uniqueID-$randomInt";
  }


}