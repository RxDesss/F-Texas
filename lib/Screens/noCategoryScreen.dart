import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:demo_project/GetX%20Controller/productdetailController.dart';
import 'package:demo_project/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NoCategoryPage extends StatefulWidget {
  const NoCategoryPage({Key? key}) : super(key: key);

  @override
  State<NoCategoryPage> createState() => _NoCategoryPageState();
}

class _NoCategoryPageState extends State<NoCategoryPage> {
  final HomeController homeController = Get.put(HomeController());
  final ProductDetailController productDetailContoller=Get.put(ProductDetailController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("**Grab Bag Deals**"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (homeController.noCategoryData.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return noCategoryWidget(context, homeController,productDetailContoller);
            }
          },
        ),
      ),
    );
  }
}


Widget noCategoryWidget(BuildContext context,  homeController,productDetailContoller) {
  return Container(
    child: Obx(() => ListView.builder(
      itemCount: homeController.noCategoryData.length,
      itemBuilder: (context, index) {
        final itemsList = homeController.noCategoryData[index];
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



// Widget noCategoryWidget(BuildContext context, HomeController homeController) {
//   return Container(
//     child: Obx(() => ListView.builder(
//       itemCount: homeController.noCategoryData.length,
//       itemBuilder: (context, index) {
//         final itemsList = homeController.noCategoryData[index];
//         return ListView.builder(
//           physics: NeverScrollableScrollPhysics(), // Disables scrolling for the nested ListView
//           shrinkWrap: true, // Use this to avoid infinite height error
//           itemCount: itemsList.length,
//           itemBuilder: (context, itemIndex) {
//             final item = itemsList[itemIndex];
//             return Container(
//               color: const Color.fromARGB(255, 178, 217, 248),
//               margin: EdgeInsets.all(10),
//               height: MediaQuery.of(context).size.height * 0.14,
//               padding: EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.height * 0.12,
//                     height: MediaQuery.of(context).size.height * 0.12,
//                     color: Colors.cyanAccent,
//                     child: item["product_image"] != null ? Image.network(item["product_image"], fit: BoxFit.fill) : null,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.60,
//                           height: MediaQuery.of(context).size.height * 0.06,
//                           child: Text(
//                             item["product_name"] ?? '',
//                             overflow: TextOverflow.fade,
//                             softWrap: true,
//                           ),
//                         ),
//                         Text("\$${item["product_price"] ?? ''}"),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     )),
//   );
// }
