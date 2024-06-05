import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:demo_project/GetX%20Controller/productdetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SubSubCategoryPage extends StatefulWidget {
  const SubSubCategoryPage({super.key});

  @override
  State<SubSubCategoryPage> createState() => _SubSubCategoryPageState();
}

class _SubSubCategoryPageState extends State<SubSubCategoryPage> {
  final HomeController homeController=Get.put(HomeController());
  final ProductDetailController productDetailContoller=Get.put(ProductDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(
          () {
            if (homeController.subSubCategoryData.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return subSubCategoryWidget(context, homeController,productDetailContoller);
            }
          },
        ),
    )
    );  
  }
}

Widget subSubCategoryWidget(BuildContext context,  homeController,productDetailContoller) {
  return Container(
    child: Obx(() => ListView.builder(
      itemCount: homeController.subSubCategoryData.length,
      itemBuilder: (context, index) {
        final itemsList = homeController.subSubCategoryData[index];
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemsList.length,
          itemBuilder: (context, itemIndex) {
            final item = itemsList[itemIndex];
            return InkWell(
              onTap: (){
                 productDetailContoller.getProductDetail(item["id"]);
              },
              child: Container(
                color: const Color.fromARGB(255, 178, 217, 248),
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.14,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.12,
                      height: MediaQuery.of(context).size.height * 0.12,
                      // color: Colors.cyanAccent,
                      child: item["product_image"] != null 
                          ? FutureBuilder(
                              future: precacheImage(NetworkImage(item["product_image"]), context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  return Image.network(
                                    item["product_image"],
                                    fit: BoxFit.fill,
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            )
                          : Center(child: Text('No image')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Text(
                              item["product_name"] ?? '',
                              overflow: TextOverflow.fade,
                              softWrap: true,
                            ),
                          ),
                          Text("\$${item["product_price"] ?? ''}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    )),
  );
}
