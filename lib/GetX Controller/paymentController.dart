import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentCotroller extends GetxController{
     
  RxList<dynamic> paymentApiData = <dynamic>[].obs;
  
   Future<void> fetchPayment()async{
    String url='';
    print("fetchPayment Api : $url");
    try{
       var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        paymentApiData.assign(json['data']);
        print("paymentApiData");
        print(paymentApiData);
      }
    } catch (e) {
      print('Error in fetchPayment: $e');

    }
   }  
}