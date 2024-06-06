// ignore: file_names
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentCotroller extends GetxController{
     
  RxList<dynamic> paymentApiData = <dynamic>[].obs;
  
   Future<void> fetchPayment()async{
    String url='';
    try{
       var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        paymentApiData.assign(json['data']);
      }
    } catch (e) {
      // print('Error in fetchPayment: $e');

    }
   }  
}