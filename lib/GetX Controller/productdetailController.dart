import 'dart:convert';
import 'dart:ffi';

import 'package:demo_project/Screens/productdetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart%20';

class ProductDetailController extends GetxController{
List<dynamic> ProdectDetailList=[];
String imageName='';
String imageUrl='';


Future<void> getProductImage(String productBImage)async{
  String url='https://www.texasknife.com/dynamic/texasknifeapi.php?action=image&image=${productBImage}';
  var res=await http.get(Uri.parse(url));
  if(res.statusCode==200){
    final body=res.body;
    final json=jsonDecode(body);
    List data=json['data'];
    print("img url");
    print(data);
    imageUrl=data[0]['msg'];
     Get.to(()=>ProductDetailScreen());
  }
}


Future<void> getProductDetail(id)async{
String url='https://www.texasknife.com/dynamic/texasknifeapi.php?action=sku&id=${id}';
print(url);
var res=await http.get(Uri.parse(url));
if(res.statusCode==200){
  final body=res.body;
  final json=jsonDecode(body);
  ProdectDetailList=json["data"];
  print(ProdectDetailList);
 String productBImage = ProdectDetailList[0]['product_b_image'];
      getProductImage(productBImage);
 
}
}
}