

import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../database.dart';
import '../supporting.dart';

 showEmailDialog(BuildContext context,data) async {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  var sent=false;
  subjectController.text='Verification Rejected';
  messageController.text='Hi ${data['name']}\nWe recieved your request for an account .Unfortunately we are rejecting your request';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 600,
        child: AlertDialog(
          title: Text('Send Email'),
          content: Container(
            height: 600,
            width: 400,
            child: ListView(

              children: [
                Container(
                  width: 400,
                  child: TextField(
                    controller: subjectController,
                    decoration: InputDecoration(
                      hintText: 'Subject',
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: 400,
                  child: TextField(
                    minLines: 9,
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: OutlineInputBorder()
                    ),

                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Cancel',style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Send',style: TextStyle(color: Colors.white),),
              onPressed: () async {
                if(subjectController.text.isEmpty){
                  EasyLoading.showInfo('Write any subject');
                  return;
                }
                if(messageController.text.isEmpty){
                  EasyLoading.showInfo('Write any message');
                  return;
                }
                Send_mailAdmin(data['email'],subjectController.text,messageController.text);
                try{
                  new Database().deleteImage(data['profileimage']);
                  new Database().deleteImage(data['licenseimage']);
                  await Firestore.instance.collection('dealer').document(data.id).delete();
                  EasyLoading.showSuccess('Rejected');
                  sent=true;
                }
                catch(e)
                {
                  EasyLoading.showError('$e');
                }

                Navigator.of(context).pop();

              },
            ),
          ],
        ),
      );
    },
  );
  return await sent;
}
