

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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

}