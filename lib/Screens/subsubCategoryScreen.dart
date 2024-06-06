import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:demo_project/GetX%20Controller/productdetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SubSubCategoryPage extends StatefulWidget {
  const SubSubCategoryPage({super.key});

  @override
  State<SubSubCategoryPage> createState() => _SubSubCategoryPageState();
}

class _SubSubCategoryPageState extends State<SubSubCategoryPage> {
  final HomeController homeController = Get.put(HomeController());
  final ProductDetailController productDetailController = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeController.productCategoryName.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (homeController.subSubCategoryData.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return subSubCategoryWidget(context, homeController, productDetailController);
            }
          },
        ),
      ),
    );
  }
}

Widget subSubCategoryWidget(BuildContext context, HomeController homeController, ProductDetailController productDetailController) {
  return Obx(
    () => ListView.builder(
      itemCount: homeController.subSubCategoryData.length,
      itemBuilder: (context, index) {
        final itemsList = homeController.subSubCategoryData[index];
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemsList.length,
          itemBuilder: (context, itemIndex) {
            final item = itemsList[itemIndex];
            print(item);
            return InkWell(
              onTap: () {
                // productDetailController.getProductDetail(item["id"]);
                productDetailController.getProductDetail(item["sku"]);
              },
              child: Container(
                color: const Color.fromARGB(255, 178, 217, 248),
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.14,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.12,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: item["product_image"] != null
                          ? CachedNetworkImage(
                              imageUrl: item["product_image"],
                              fit: BoxFit.fill,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Center(
                                child: Icon(Icons.error),
                              ),
                            )
                          : const Center(child: Text('No image')),
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
    ),
  );
}
