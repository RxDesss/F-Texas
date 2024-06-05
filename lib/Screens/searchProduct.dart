// ignore_for_file: prefer_const_constructors

import 'package:demo_project/GetX%20Controller/searchproductController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final SearchProductController searchProductController = Get.put(SearchProductController());
  final ScrollController _controller = ScrollController();
  TextEditingController _filterController = TextEditingController();

  // void _loadMore() {
  //   if (_controller.position.maxScrollExtent == _controller.position.pixels) {
  //     // You reached the bottom
  //     setState(() {
  //       int currentMax = searchProductController.filteredProducts.length;
  //       int nextMax = currentMax + 10;
  //       for (var i = currentMax; i < nextMax; i++) {
  //         searchProductController.filteredProducts.add(i);
  //       }
  //     });
  //   }
  // }

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
                print('Search text: $searchText');
                // No need to add further processing here, as filtering is already performed
              },
            ),
          ],
        ),
      ),
      body: Obx(() => ListView.builder(
        controller: _controller,
        itemCount: searchProductController.filteredProducts.length,
        itemBuilder: (context, index) {
          return Container(
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
               Container(
                // width: MediaQuery.of(context).size.width*9,
                //  height: MediaQuery.of(context).size.height*2,
            
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                     Container(
                      width:MediaQuery.of(context).size.width*0.55,
                      // height:100,
                      child: Text(searchProductController.filteredProducts[index]['description'].replaceAll(RegExp(r'<[^>]*>|<\/[^>]*>'), '')))
                  ],
                             ),
               ),
             
              ],
              
            ),
          );
        },
      )),
    );
  }
}
