import 'dart:convert';
import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class LoginController extends GetxController {
  List<dynamic> loginList = [].obs;
  String userId = '';
  String userEmail = '';
  final HomeController homeContoller = Get.put(HomeController());
  RxBool isLoading = false.obs; // Observable to track loading state

  // Method to toggle loading state
  void toggleLoading(bool value) => isLoading.value = value;

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('Invalid Details'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void fetchLogin(String? username, String? password, BuildContext context) async {
   isLoading.value=true;

    String url =
        'https://www.texasknife.com/dynamic/texasknifeapi.php?action=static_login&email=$username&password=$password';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      loginList = json['data'];
      userId=loginList[0]['id'];
      userEmail=loginList[0]['email'];
      // ignore: use_build_context_synchronously
      homeContoller.fetchDataAndNavigate(context);
    } else {
      // ignore: use_build_context_synchronously
      _showAlertDialog(context);
    }

 
  }
}
