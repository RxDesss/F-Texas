import 'dart:convert';
import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class AddressController extends GetxController{
  final LoginController loginController=Get.put(LoginController());
 RxList<dynamic> AddressDatas = <dynamic>[].obs;

  Future<void> fetchOldAddress() async {
    String url = "https://www.texasknife.com/dynamic/texasknifeapi.php?action=get_checkoutship&customer_id=${loginController.userId}";
    print('fetchContinueToPayment: $url');
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        AddressDatas.assign(json['data'][0]);
        print("AddressDatas");
        print(AddressDatas);
      }
    } catch (e) {
      print('Error in fetchOldAddress: $e');
    }
  }


}