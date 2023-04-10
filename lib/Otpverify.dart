




import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easyagroadmin/supporting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'login.dart';

class Otp_verify extends StatefulWidget{
  var OTP,email,keep_login;
  Otp_verify({required this.OTP,required this.email,required this.keep_login});
  @override
  State<Otp_verify> createState() => _Otp_verifyState();
}

class _Otp_verifyState extends State<Otp_verify> {
  TextEditingController OTP_controller=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(30,30),
          child: MyAppBar()),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          image: DecorationImage(
              image: Image.asset('images/backk.jpg').image,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.dstATop,
              )
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top:size.height*0.15 ,bottom:size.height*0.15,left: 40,right: 40 ),
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 30,right: 30,bottom: 10,top: 10),
              width: 440,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(children: [
                Row(children: [
                  IconButton(onPressed:(){
                    Navigator.pushReplacement(context, Myroute(Login()));
                  }, icon: Icon(Icons.arrow_back_outlined)),
                ],),
                Lottie.asset('images/verify_animation.json',height:size.height*0.26),
                Text('\nVerify OTP ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
                Text('Enter sms code (OTP) sent to your email\n${widget.email} ',style: TextStyle(color: Colors.grey),),
                Text(''),
                TextField(
                  controller: OTP_controller,
                  inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),],
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Sms code',
                    border: OutlineInputBorder(),
                  ),),
                Text(''),
                SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: ElevatedButton(onPressed: () async {
                      if(OTP_controller.text.isEmpty){
                        EasyLoading.showInfo('Enter SMS code (OTP) set to ${widget.email}');
                        return;
                      }
                      if(OTP_controller.text==widget.OTP){
                        if(widget.keep_login==true){
                          SharedPreferences pref =await SharedPreferences.getInstance();
                          await pref.setString("email", "${widget.email}");
                        }
                        EasyLoading.showSuccess('Login Sucessful');
                        Navigator.pushReplacement(context,Myroute(home(index: 0,)) );
                        return;
                      }
                      else{
                        EasyLoading.showError('Incorrect OTP');
                        return;
                      }
                    }, child: Text('Verify',style: TextStyle(color: Colors.white),)))
              ],),
            ),
          ),
        ),
      ),
    );
  }
}