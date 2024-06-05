// ignore_for_file: prefer_const_constructors

import 'package:demo_project/GetX%20Controller/searchproductController.dart';
import 'package:demo_project/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProduct extends StatefulWidget {
  
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final SearchProductController searchProductController = Get.put(SearchProductController());
  final ScrollController _controller = ScrollController();
  final TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _controller.addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              
              child: TextField(
                onChanged: (value)  {
                   searchProductController.filterProducts(value);
                },
                controller: _filterController,
                decoration: InputDecoration(
                  hintText: 'Search by SKU',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                String searchText = _filterController.text.toLowerCase();
                searchProductController.filterProducts(searchText);
             
              },
            ),
          ],
        ),
      ),
      body: Obx(() => ListView.builder(
        controller: _controller,
        itemCount: searchProductController.filteredProducts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              productDetailContoller.getProductDetail(searchProductController.filteredProducts[index]['sku']);
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.8,
              // height: 100,
              margin:EdgeInsets.all(MediaQuery.of(context).size.height*0.015),
              padding:EdgeInsets.all(MediaQuery.of(context).size.height*0.015),
              decoration: BoxDecoration(
               color: Colors.blueAccent[100],
               borderRadius:BorderRadius.only(topRight:Radius.circular(60))
              ),
              child: Column(
                children: [
                Row(
                  children: [
                    Text('Sku: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                     Text(searchProductController.filteredProducts[index]['sku'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                  ],
                ),
                 SizedBox(
              
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                       SizedBox(
                        width:MediaQuery.of(context).size.width*0.55,
                        child: Text(searchProductController.filteredProducts[index]['description'].replaceAll(RegExp(r'<[^>]*>|<\/[^>]*>'), '')))
                    ],
                               ),
                 ),
               
                ],
                
              ),
            ),
          );
        },
      )),
    );
  }
}