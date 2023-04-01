import 'dart:convert';
import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

void Customize_Easyloading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor =  Colors.green.shade700
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;

}

bool Validate_Email(email){
  String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(email);
}

bool Validate_Password(String password){
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(password) ;
}



List Email_Validation(a){
  var mylist=[],is_valid_email;
  if(a.isEmpty){
    mylist.add(null);
    mylist.add(Colors.grey);
    return mylist;
  }
  is_valid_email=EmailValidator.validate(a);
  if(!is_valid_email) {
    mylist.add('Invalid Email');
    mylist.add(Colors.red);
    return mylist;
  }

  if(!'${a}'.endsWith('.com')  ) {
    mylist.add('Invalid Email');
    mylist.add(Colors.red);
    return mylist;
  }

  mylist.add('Valid Email');
  mylist.add(Colors.green);
  return mylist;


}



List Password_Validation(a){
  var mylist=[],is_valid_email;
  if(a.isEmpty){
    mylist.add(null);
    mylist.add(Colors.grey);
    return mylist;
  }

  if(!Validate_Password(a)) {
    mylist.add('Must have length 8,one upper & lowercase,\ndigit,specialchar');
    mylist.add(Colors.red);
    return mylist;
  }
  if(a.length>16){
    mylist.add('Password length should not exceed 15');
    mylist.add(Colors.red);
    return mylist;
  }

  mylist.add('Valid Password');
  mylist.add(Colors.green);
  return mylist;


}


class Myroute extends PageRouteBuilder{
  final Widget child;
  Random ob=new Random();
  var o,Random_element ,
      Directions=[AxisDirection.up,AxisDirection.down,AxisDirection.left,AxisDirection.right];

  Myroute(this.child):super(pageBuilder:(BuildContext, Animation , Animatio )=>child ){
    Random_element=ob.nextInt(4);
  }

  Duration get transitionDuration => Duration(milliseconds: 400);

  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    var T=Tween<Offset>(begin: Getoffset(Random_element),end: Offset.zero);
    var T1=Tween<double>(begin: 3.0,end: 1.0);
    return SlideTransition(
        child: child,
        position: animation.drive(T.chain(CurveTween(curve: Curves.bounceInOut))));
  }

  Offset Getoffset(Random_element){
    switch(Random_element) {
      case 0:
        o = Offset(0, -1);
        break;
      case 1:
        o = Offset(0, 1);
        break;
      case 2 :
        o = Offset(1, 0);
        break;
      case 3:
        o = Offset(-1, 0);
        break;
    }
    return o;
  }
}



Generate_OTP(){
  var ABC=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q',
    'R','S','T','U','V','W','X','Y','Z'
  ],abc=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p',
    'q','r','s','t','u','v','w','x','y','z'
  ];
  Random a=new Random();
  var random_number=a.nextInt(999999);
  var capital_alphabet=ABC[a.nextInt(ABC.length-1)];
  var capital_alphabet1=ABC[a.nextInt(ABC.length-1)];
  var small_alphabet=abc[a.nextInt(ABC.length-1)];
  return '${capital_alphabet1+small_alphabet+random_number.toString()+capital_alphabet}';
}







void Send_mail(name,OTP,receiver_email){
  var
  Service_id='service_plttjgm',
      Template_id='template_z5tnyrc',
      User_id='_ILHAzYAP3Rq7M8s7';
  var s=http.post(Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {
        'origin':'http:localhost',
        'Content-Type':'application/json'
      },
      body: jsonEncode({
        'service_id':Service_id,
        'user_id':User_id,
        'template_id':Template_id,
        'template_params':{
          'name':name,
          'receiver_email':receiver_email,
          'OTP':OTP

        }
      })
  ).onError((error, stackTrace) => jd());

}


jd(){
  EasyLoading.showError('Error sending email ');
}













