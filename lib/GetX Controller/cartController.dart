import 'dart:convert';
import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  RxBool isLoadingCartAPI = true.obs;
  List<dynamic> Data = [].obs;
  List<dynamic> cartData = [].obs;
  String Message = "";
  double totalAmount = 0.0;
  RxDouble totalAmount1 = 0.0.obs;

  Future<void> getAddToCart(productId, productQuantity, productSku, productPrice, context) async {
    String url = 'https://www.texasknife.com/dynamic/texasknifeapi.php?action=cart&store_id=1&user_id=${loginController.userId}&product_id=${productId}&product_det_qty=${productQuantity}&get_cur_price=${productPrice}&sku=${productSku}&user_email=${loginController.userEmail}&session_ids=123456&based_on=Add';
    var res = await http.get(Uri.parse(url));
    
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      Data = json['data'];
      Navigator.pushReplacementNamed(context, '/tabnavigation');
    }
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    totalAmount1.value = 0.0; // Reset totalAmount
    String url = 'https://www.texasknife.com/dynamic/texasknifeapi.php?action=final_cart_details&store_id=1&customer_id=${loginController.userId}';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      cartData = json['data'];
      isLoadingCartAPI.value = false;
      List<dynamic> data = json['data'];

      for (var item in data) {
        totalAmount += double.parse(item['total'].toString());
        totalAmount1.value += double.parse(item['total'].toString());
      }

      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<void> deleteCartItem(productID) async {
    String url = 'https://www.texasknife.com/dynamic/texasknifeapi.php?action=remove_cart&customer_id=${loginController.userId}&session_id=123456&product_id=$productID';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Handle success
      } else {
        throw Exception('Failed to remove cart item: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to remove cart item: $e');
    }
  }

  Future<void> addProductQuantity(productID, total) async {
    String url = 'https://www.texasknife.com/dynamic/texasknifeapi.php?action=sku&id=${productID}';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        List<dynamic> data = json['data'];
        String sku = data[0]['sku'];
        var res = await http.get(Uri.parse("https://www.texasknife.com/dynamic/texasknifeapi.php?action=cart&store_id=1&user_id=${loginController.userId}&product_id=${productID}&product_det_qty=1&get_cur_price=${total}&sku=${sku}&user_email=${loginController.userEmail}&session_ids=123456&based_on=Add"));
        if (res.statusCode == 200) {
          // Handle success
        }
      } else {
        throw Exception('Failed to add product quantity: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to add product quantity: $e');
    }
  }

  Future<void> minusProductQuantity(productID, total) async {
    String url = 'https://www.texasknife.com/dynamic/texasknifeapi.php?action=sku&id=${productID}';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        List<dynamic> data = json['data'];
        String sku = data[0]['sku'];
        var res = await http.get(Uri.parse("https://www.texasknife.com/dynamic/texasknifeapi.php?action=cart&store_id=1&user_id=${loginController.userId}&product_id=${productID}&product_det_qty=1&get_cur_price=${total}&sku=${sku}&user_email=${loginController.userEmail}&session_ids=123456&based_on=Minus"));
        if (res.statusCode == 200) {
          // Handle success
        }
      } else {
        throw Exception('Failed to subtract product quantity: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to subtract product quantity: $e');
    }
  }
}
