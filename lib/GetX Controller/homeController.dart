
import 'dart:convert';

import 'package:demo_project/Screens/noCategoryScreen.dart';
import 'package:demo_project/Screens/subCategoyScreen.dart';
import 'package:demo_project/Screens/subsubCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController{
  List<dynamic> featureProductList=[].obs;
  List<dynamic> categoryProductList=[].obs;
  List<dynamic> noCategoryData=[].obs ;
    List<dynamic> subCategoryData=[].obs ;
     List<dynamic> subSubCategoryData=[].obs ;


    String productCategoryName='';
  

    bool _featureLoaded = false;
  bool _categoryLoaded = false;

  Future<void> fetchDataAndNavigate(context) async {
    await fetchFeatureApi();
    await fetchCategoryApi();
// print(_featureLoaded);
// print(_categoryLoaded);
    if (_featureLoaded && _categoryLoaded) {
      Navigator.pushReplacementNamed(context, '/tabnavigation');
    
    }
  }

  Future<void>  fetchFeatureApi()async{
  String url='https://www.texasknife.com/dynamic/texasknifeapi.php?action=cus_featured_product';
  // print(url);

  var res=await http.get(Uri.parse(url));
  if(res.statusCode==200){
    final body=res.body;
    final json=jsonDecode(body);
    featureProductList=json['data'];
     _featureLoaded = true;
    // print("Feature");
    // print(featureProductList);
  }else{
    print("Feature product list not working");
  }


}

  Future<void> fetchCategoryApi()async{
  String url='https://www.texasknife.com/dynamic/texasknifeapi.php?action=cus_category';
  // print(url);

  var res=await http.get(Uri.parse(url));
  if(res.statusCode==200){
    final body=res.body;
    final json=jsonDecode(body);
    categoryProductList=json['data'];
    _categoryLoaded = true;
    // print("category");
    //  print(categoryProductList);
  }else{
    print("Feature product list not working");
  }
}


// https://www.texasknife.com/dynamic/texasknifeapi.php?action=cus_sub_category&category_id=2

 Future<List<Map<String, dynamic>>> getSubCategory(categoryid) async {
    String url = ' https://www.texasknife.com/dynamic/texasknifeapi.php?action=cus_sub_category&category_id=${categoryid}';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      List<dynamic> data = json['data'];

      // Assuming each item in data is a map
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load cart items');
    }
  }

// https://www.texasknife.com/dynamic/texasknifeapi.php?action=cus_sub_category&category_id=1

   Future<void> getSubList(context,categoryId,categoryName) async {
        productCategoryName=categoryName;
        subCategoryData.assign([]);
    if(categoryName=='** Grab Bag Deals **'){
       Get.to(()=>NoCategoryPage() );
String noProductUrl='https://www.texasknife.com/dynamic/texasknifeapi.php?action=cus_category_product&category=${categoryName}';
   print(noProductUrl);
    var response = await http.get(Uri.parse(noProductUrl));

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
     noCategoryData.assign(json['data']); // Update the observable list
         print("noCategoryData");
      print(noCategoryData);

      // Assuming each item in data is a map
      // return List<Map<String, dynamic>>.from(data);
    } 
    }else {
      // subCategoryData=[];
       Get.to(()=>SubCategoryScreen() );
       String url ='https://www.texasknife.com/dynamic/texasknifeapi.php?action=cus_sub_category&category_id=${categoryId}';
         print(url);
        var res = await http.get(Uri.parse(url));
       if (res.statusCode == 200) {
      final body1 = res.body;
      final json1 = jsonDecode(body1);
     subCategoryData.assign(json1['data']); // Update the observable list
      print("subCategoryData");
      print(subCategoryData);
      

      // Assuming each item in data is a map
      // return List<Map<String, dynamic>>.from(data);
    }
    }
  }

 
 Future<void> getSubSubCategory(context,productSubCategoryName)async {
  Get.to(()=>SubSubCategoryPage());
  subSubCategoryData.assign([]); 
  String url="https://www.texasknife.com/dynamic/texasknifeapi.php?action=cus_subcategory_product&category=${productCategoryName}&sub_category=${productSubCategoryName}";
print('subsubcategoryurl :  ${url}');
  var res= await http.get(Uri.parse(url));
  if(res.statusCode==200){
    final body = res.body;
      final json = jsonDecode(body);
     subSubCategoryData.assign(json['data']); 
     print("subSubCategoryData");
     print(subSubCategoryData);
  }

 }
  


  }