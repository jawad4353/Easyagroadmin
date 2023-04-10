

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easyagroadmin/supporting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'database.dart';
import 'login.dart';

class Forgotpassword extends StatefulWidget{
  var OTP;
  Forgotpassword({required this.OTP});
  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {

  TextEditingController email=new TextEditingController();
  TextEditingController OTP_controller=new TextEditingController();
  TextEditingController password=new TextEditingController();
  var hidepassword=true,Password_error='',Password_error_color=Colors.grey,mail_sent=false;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size(30,30),
          child: MyAppBar()),
      body:  Container(
        decoration: BoxDecoration(
          color: Colors.green,
          image: DecorationImage(
              image: Image.asset('images/backk.jpg').image,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.dstATop,
              )
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top:size.height*0.15 ,bottom:size.height*0.15,left: 40,right: 40 ),
            child: Container(
              padding: EdgeInsets.only(left: 30,right: 30,bottom: 10,top: 10),
              width: 410,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Row(children: [
                   IconButton(onPressed:(){
                  Navigator.pushReplacement(context, Myroute(Login()));
                }, icon: Icon(Icons.arrow_back_outlined)),
                 ],),

                  Lottie.asset('images/otp_animation.json',height:size.height*0.20),
                  Text('\nForgot Password ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
                  Text('Enter your email and get OTP.Verify OTP and enter new password',style: TextStyle(color: Colors.grey),),
                  Text(''),
                  if(!mail_sent)
                  TextField(
                    controller: email,
                    inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.-.@-@_-_]')),],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail),
                      suffix: ElevatedButton(onPressed: () async {
                        var name;
                        EasyLoading.show(status: 'Checking',dismissOnTap: false);
                        if(email.text.isEmpty){
                          EasyLoading.showInfo('Email required');
                          return;
                        }
                        var s=Email_Validation(email.text);
                        if(s[1]==Colors.red){
                          EasyLoading.showInfo('${s[0]}');
                          return;
                        }
                       name= await new Database().Email_Exists('admin',email.text);
                         if(name==''){
                           EasyLoading.showError('Email Not Registered !\n${email.text}');
                           return;
                         }
                         else{
                           Send_mail(name,widget.OTP,email.text);
                           setState(() {
                             mail_sent=true;
                           });
                           print(mail_sent);

                         }
                         EasyLoading.dismiss();
                      },child: Text('Get Code',style: TextStyle(color: Colors.white),),)
                    ),
                  ),
                if(mail_sent)
                  TextField(
                      controller: OTP_controller,
                      inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),],
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Sms code',
                        border: OutlineInputBorder(),
                  ),),
                  Text(""),
                  if(mail_sent)
                  TextField(
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (a){
                      var s=Password_Validation(a);
                      if(s[0]==null){
                        return;
                      }
                      setState(() {
                        Password_error_color=s[1];
                        Password_error=s[0];
                      });
                    },
                    decoration: InputDecoration(
                      errorText: Password_error,
                      errorStyle: TextStyle(color: Password_error_color),
                      focusColor: Password_error_color,
                      labelText: 'New Password',
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          hidepassword=!hidepassword;
                        });
                      },icon: Icon(Icons.remove_red_eye,color: Colors.lightGreen.shade700,),),

                      border: OutlineInputBorder(),
                      focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Password_error_color))  ,
                      focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Password_error_color)) ,
                      enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Password_error_color)) ,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Password_error_color)),
                    ),
                  ),


                  if(mail_sent)
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show(status: 'Updating',dismissOnTap: false);
                        if(OTP_controller.text.isEmpty){
                          EasyLoading.showInfo('Enter OTP send to ${email.text}');
                          return;
                        }
                        if(OTP_controller.text!=widget.OTP){
                          EasyLoading.showError('Incorrect OTP');
                          return;
                        }
                        if(password.text.isEmpty){
                          EasyLoading.showInfo('Enter new password !');
                          return;
                        }
                        var s1=Password_Validation(password.text);
                        if(s1[1]==Colors.red){
                          EasyLoading.showInfo('${s1[0]}');
                          return;
                        }
                       var result= await new Database().Update_Password('admin',email.text,password.text);
                        if(result){
                          EasyLoading.showSuccess('Updated Successfully');
                          Navigator.pushReplacement(context, Myroute(Login()));
                          return;
                        }
                        else{
                          EasyLoading.showInfo('Password Not Updated !');
                          return;
                        }

                      },
                      child: Text('Update',style: TextStyle(color: Colors.white),),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}