import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sub Category"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (homeController.subCategoryData.isEmpty) {
              return const Center(
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

Widget subCategoryWidget(BuildContext context, HomeController homeController) {
  return SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
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
              homeController.getSubSubCategory(context, item["name"]);
            },
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: CachedNetworkImage(
                      imageUrl: item["image"],
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.blue[50],
                    alignment: Alignment.center,
                    child: Text(item["name"]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
