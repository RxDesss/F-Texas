import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Comman {

  static errortoast(errormessage){
     return Fluttertoast.showToast(
        msg: errormessage,
        toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 255, 174, 0),
      textColor: Colors.white,
      fontSize: 16.0,
      );
  }

 static sucesstoast(sucessmessage){
    return    Fluttertoast.showToast(
      msg:sucessmessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
      
    );
  }

}