

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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






 uploadImage(File imageFile) async {
    try {
      final response = await http.post(Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/easyagro-ed808.appspot.com/o?uploadType=media&name=admin/${path.basename(imageFile.path)}'),
          body: imageFile.readAsBytesSync());
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




}