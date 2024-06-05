import 'dart:convert';
import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:demo_project/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

// import 'package:register_screen/models/login.dart';

class LoginController extends GetxController {
  List<dynamic> loginList = [].obs;
  String userId='';
  String userEmail='';
  final HomeController homeContoller=Get.put(HomeController());

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Invalid Details'),
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

  get userData => null;

  void fetchLogin(username, password, context) async {
    String url =
        'https://www.texasknife.com/dynamic/texasknifeapi.php?action=static_login&email=$username&password=$password';
    print(url);
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      loginList = json['data'];
      homeContoller.fetchDataAndNavigate(context);
      print(loginList);
      userId=loginList[0]['id'];
      userEmail=loginList[0]['email'];
      // Get.to(() => HomeScreen());
      // Navigator.pushReplacementNamed(context,'/tabnavigation');
      // List<dynamic> data = json.decode(res.body)['data']; // Explicitly defining data type
      // loginList.value = data.map((item) => Login.fromJson(item)).toList();
      // print(data);
    //    for (var obj in loginList) {
    //       userId = obj['id'];
    //       userEmail=obj['email'];
    //   print('userId: $userId');
    // }

    } else {
      _showAlertDialog(context);
    }
// Parse the JSON string
    // Map<String, dynamic> jsonObject = json.decode(loginList[0]);
    //     print("object  :");
    // print(jsonObject['user_name']);

    // for (var obj in loginList) {
    //   String userName = obj['user_name'];
    //   print('userName: $userName');
    // }
  }
}