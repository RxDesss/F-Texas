// ignore_for_file: file_names

import 'package:demo_project/Screens/productdetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailController extends GetxController {
  List<dynamic> productDetailList = [];
  String imageName = '';
  String imageUrl = '';

  Future<void> getProductImage(String productBImage) async {
    String url =
        'https://www.texasknife.com/dynamic/texasknifeapi.php?action=image&image=$productBImage';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      List data = json['data'];
      imageUrl = data[0]['msg'];
       Get.back(); // Close the loader dialog
      Get.to(() => ProductDetailScreen());
    }
  }

  Future<void> getProductDetail(id) async {
    String url =
        'https://www.texasknife.com/dynamic/texasknifeapi.php?action=sku&id=$id';
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      productDetailList = json["data"];
      String productBImage = productDetailList[0]['product_b_image'];
      await getProductImage(productBImage);
     
    }
  }
}
