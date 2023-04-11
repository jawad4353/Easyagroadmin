import 'dart:convert';
import 'dart:math';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    ..backgroundColor =  Colors.lightGreen.shade700
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
  mylist.add(Colors.lightGreen);
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
  mylist.add(Colors.lightGreen);
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








void Send_mailAdmin(receiver_email,subject,message){
  var
  Service_id='service_plttjgm',
      Template_id='template_vmg32zl',
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
          'receiver_email':receiver_email,
          'subject':subject,
          'message':message

        }
      })
  ).onError((error, stackTrace) => jd());

}



class show_progress_indicator extends StatelessWidget{
  Color border_color;
  show_progress_indicator({required this.border_color});
  @override
  Widget build(BuildContext context) {
    return
      Center(child: Container(
        color: Colors.transparent,
        child: SpinKitFoldingCube(
          size: 50.0,
          duration: Duration(milliseconds: 700),
          itemBuilder: ((context, index) {
            var Mycolors=[Colors.lightGreen.shade700,Colors.white];
            var Mycol=Mycolors[index%Mycolors.length];
            return DecoratedBox(decoration: BoxDecoration(
                color: Mycol,
                border: Border.all(color: border_color,)

            ));
          }),
        ),
      ),

      );

  }

}








void Set_windowsize(height,width){
  var win=appWindow;
  doWhenWindowReady(() {
    win = appWindow;
    var initialSize = Size(height, width);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}





class MyAppBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 30,
        backgroundColor:Colors.white,
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
    );
  }

}



