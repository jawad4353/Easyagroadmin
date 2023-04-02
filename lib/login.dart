

import 'dart:ui';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easyagroadmin/supporting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';

import 'Otpverify.dart';
import 'database.dart';
import 'forgotpassword.dart';





class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email=new TextEditingController();

  TextEditingController password=new TextEditingController();

  var hidepassword=true,Email_error='',
      Email_Error_color=Colors.grey,
      Password_error='',
      Password_error_color=Colors.grey,
  keep_login=false;

  @override
  void initState() {
    Customize_Easyloading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
     toolbarHeight: 30,
      leadingWidth: 100,
      backgroundColor: Colors.white,
      leading: Row(children: [
        Image.asset('images/appicon.png'),
        Text('  EasyAgro',style: TextStyle(color: Colors.grey),)
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                 Lottie.asset('images/welcome_animation.json',height:size.height*0.21),
                    Text(
                      'Login ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Enter your email and password to continue',style: TextStyle(color: Colors.grey),),

                   Text(''),
                    TextField(
                      controller: email,
                      inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.-.@-@_-_]')),],
                      keyboardType: TextInputType.emailAddress,
                      onTap: (){
                        setState(() {
                          Password_error_color=Colors.grey;
                          Password_error='';
                        });
                      },
                      onTapOutside: (a){
                          setState(() {
                            Password_error_color=Colors.grey;
                            Password_error='';
                          });
                      },
                      onChanged: (a){
                        var s=Email_Validation(a);
                        if(s[0]==null){
                          return;
                        }
                        setState(() {
                          Email_Error_color=s[1];
                          Email_error=s[0];
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                        focusColor: Email_Error_color,
                        hoverColor: Email_Error_color,
                        errorText: Email_error,
                        errorStyle: TextStyle(color: Email_Error_color),
                        border: OutlineInputBorder(),
                        focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Email_Error_color))  ,
                        focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Email_Error_color)) ,
                        enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Email_Error_color)) ,
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Email_Error_color)),
                      ),
                    ),

                    TextField(
                      controller: password,
                      obscureText: hidepassword,
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
                      onTap: (){
                        setState(() {
                        Email_Error_color=Colors.grey;
                         Email_error='';
                        });
                      },
                      onTapOutside: (a){
                        setState(() {
                          Email_Error_color=Colors.grey;
                          Email_error='';
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.vpn_key),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            hidepassword=!hidepassword;
                          });
                        },icon: Icon(Icons.remove_red_eye,color: Colors.green,),),
                        errorText: Password_error,
                        hoverColor: Password_error_color,
                        focusColor: Password_error_color,
                        errorStyle: TextStyle(color: Password_error_color),
                        border: OutlineInputBorder(),
                        focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Password_error_color))  ,
                        focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Password_error_color)) ,
                        enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Password_error_color)) ,
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Password_error_color)),
                      ),
                    ),

                   Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                  Row(children: [
                    Checkbox(value: keep_login, onChanged: (a){setState(() {
                      keep_login=a!;
                    });}),
                    Text('Keep Login')
                  ],),

                      TextButton(
                         onPressed: () {
                           Navigator.push(context, Myroute(Forgotpassword (OTP:Generate_OTP())));
                         },
                         child: Text('Forgot Password?'),
                       ),

                   ],),


                    Text(''),
                    SizedBox(
                      width: double.infinity,
                      height: 38,
                      child: ElevatedButton(
                        onPressed: () async {
                          EasyLoading.show(status: 'Checking',dismissOnTap: false);

                          if(email.text.isEmpty){
                            EasyLoading.showInfo('Email required');
                            return;
                          }
                          if(password.text.isEmpty){
                            EasyLoading.showInfo('Password required');
                            return;
                          }
                          var s=Email_Validation(email.text);
                          var s1=Password_Validation(password.text);
                          if(s[1]==Colors.red){
                            EasyLoading.showInfo('${s[0]}');
                            return;
                          }
                          if(s1[1]==Colors.red){
                            EasyLoading.showInfo('Password ${s1[0]}');
                            return;
                          }
                          var result=await new Database().Admin_Login(email.text,password.text);
                          if(result==''){
                            EasyLoading.showError('Incorrect Email or Password !');
                            return;
                          }
                          else{
                           var OTP= Generate_OTP();
                            Send_mail(result,OTP,email.text);
                           print(OTP);
                          Navigator.pushReplacement(context, Myroute(  Otp_verify(OTP:OTP,email: email.text,keep_login:keep_login)));
                          EasyLoading.dismiss();
                            return;
                          }

                        },
                        child: Text('Login'),
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