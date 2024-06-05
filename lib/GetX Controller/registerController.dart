import 'dart:convert';


import 'package:demo_project/Screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController{
   void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Register Failed'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  
  void fetchRegister(username,email,password,context) async{
   String url='https://trackappt.desss-portfolio.com/dynamic/dynamicapi.php?action=create&table=mobile_app_users&name=$username&email=$email&password=$password';
  print(password);
  var res=await http.get(Uri.parse(url));
  if(res.statusCode==200){
    final body=res.body;
    final json=jsonDecode(body);
    print(json['data']);
    Get.to(()=>LoginScreen());
  }else{
 _showAlertDialog(context);
  }
  }
}