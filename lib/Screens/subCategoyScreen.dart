import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Category"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (homeController.subCategoryData.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return subCategoryWidget(context, homeController);
            }
          },
        ),
      ),
    );
  }
}
Widget subCategoryWidget(context, homeController) {
  return SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.22,
        ),
        itemCount: homeController.subCategoryData[0].length,
        itemBuilder: (context, index) {
          final item = homeController.subCategoryData[0][index];
          return InkWell(
            onTap: () {
              homeController.getSubSubCategory(context,item["name"]);
            },
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Image.network(
                        item["image"],
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.blue[50],
                      child: Text(item["name"]),
                      alignment: Alignment.center,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
// Widget subCategoryWidget(context, homeController) {
//   return SingleChildScrollView(
//     child: Container(
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       child: GridView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0,
//           mainAxisExtent: MediaQuery.of(context).size.height * 0.22,
//         ),
//         itemCount: homeController.subCategoryData[0].length,
//         itemBuilder: (context, index) {
//           final item = homeController.subCategoryData[0][index];
//           return InkWell(
//             onTap: () {},
//             child: Container(
//               child: Column(
//                 children: [
//                   Expanded(
//                     flex: 7,
//                     child: Container(
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height * 0.15,
//                       child: Image.network(
//                         item["image"],
//                         fit: BoxFit.fill,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Center(
//                             child: Icon(Icons.error),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       color: Colors.blue[50],
//                       child: Text(item["name"]),
//                       alignment: Alignment.center,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }
