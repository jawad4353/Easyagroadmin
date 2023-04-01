




import 'package:easyagroadmin/supporting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'home.dart';
import 'login.dart';

class Otp_verify extends StatefulWidget{
  var OTP,email;
  Otp_verify({required this.OTP,required this.email});
  @override
  State<Otp_verify> createState() => _Otp_verifyState();
}

class _Otp_verifyState extends State<Otp_verify> {
  TextEditingController OTP_controller=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                    child: ElevatedButton(onPressed: (){
                      if(OTP_controller.text.isEmpty){
                        EasyLoading.showInfo('Enter SMS code (OTP) set to ${widget.email}');
                        return;
                      }
                      if(OTP_controller.text==widget.OTP){
                        EasyLoading.showSuccess('Login Sucessful');
                        Navigator.pushReplacement(context,Myroute(home()) );
                        return;
                      }
                    }, child: Text('Verify')))
              ],),
            ),
          ),
        ),
      ),
    );
  }
}