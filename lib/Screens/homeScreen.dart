import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:demo_project/GetX%20Controller/productdetailController.dart';
import 'package:demo_project/GetX%20Controller/searchProductController.dart';
import 'package:demo_project/Screens/QRScanPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  final ProductDetailController productDetailController = Get.put(ProductDetailController());
  final SearchProductController searchProductController = Get.put(SearchProductController());

  String? userName;
  List<String> apiProductNames = [];
  List<String> apiProductPrice = [];
  List<String> apiProductImage = [];
  List<String> apiCategoryName = [];
  List<String> apiCategoryImage = [];
  List<String> id = [];
  List<String> apiCategoryId = [];

  @override
  void initState() {
    super.initState();
    getData();
    getFeatureProduct();
    getCategoryProduct();
  }

  void getProductDetail(String id) {
    productDetailController.getProductDetail(id);
  }

  void getData() {
    userName = loginController.loginList.isNotEmpty ? loginController.loginList[0]['user_name'] : null;
  }

 void getFeatureProduct() {
  final featureProducts = homeController.featureProductList;
  if (featureProducts.isNotEmpty) {
    apiProductNames = featureProducts.map<String>((obj) => obj['product_name'] as String).toList();
    apiProductPrice = featureProducts.map<String>((obj) => obj['product_price'] as String).toList();
    apiProductImage = featureProducts.map<String>((obj) => obj['product_image'] as String).toList();
    id = featureProducts.map<String>((obj) => obj['id'] as String).toList();
  }
}

void getCategoryProduct() {
  final categoryProducts = homeController.categoryProductList;
  if (categoryProducts.isNotEmpty) {
    apiCategoryName = categoryProducts.map<String>((obj) => obj['name'] as String).toList();
    apiCategoryImage = categoryProducts.map<String>((obj) => obj['image'] as String).toList();
    apiCategoryId = categoryProducts.map<String>((obj) => obj['id'] as String).toList();
  }
}
  final List<String> imageList = [
    'https://cdn.pixabay.com/photo/2015/12/11/17/51/knife-1088529_1280.png',
    'https://images.pexels.com/photos/168804/pexels-photo-168804.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/365631/pexels-photo-365631.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/39011/paprika-vegetables-snack-vegetables-cut-39011.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];

  final List<String> categoryImages = [
    'assets/cimg/1.png',
    'assets/cimg/2.png',
    'assets/cimg/3.png',
    'assets/cimg/4.png',
    'assets/cimg/5.png',
    'assets/cimg/6.png',
    'assets/cimg/7.png',
    'assets/cimg/8.png',
    'assets/cimg/9.png',
    'assets/cimg/10.png',
    'assets/cimg/11.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(context, userName),
              imageCarousel(context, imageList),
              search(context),
              categoryImage(context, categoryImages),
              featureProducts(context, apiProductImage, apiProductPrice, apiProductNames, getProductDetail, id),
              categoryProduct(context, apiCategoryName, apiCategoryImage, apiCategoryId),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context, String? userName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Hello',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                userName ?? '',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/TexasImage.png',
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.08,
          ),
        ],
      ),
    );
  }

  Widget imageCarousel(BuildContext context, List<String> imageList) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.20,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 4 / 3,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
        items: imageList.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(),
                child: CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget search(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.42,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
              ),
              onPressed: () {
                searchProductController.fetchAllProduct();
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search, size: 20.0),
                  SizedBox(width: 4),
                  Text(
                    'Search Product',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.42,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
              ),
              onPressed: () {
                Get.to(() => QRScanPage());
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt, size: 20.0),
                  SizedBox(width: 4),
                  Text(
                    'Scan Code',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryImage(BuildContext context, List<String> categoryImages) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Category Image",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryImages.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.25,
                margin: EdgeInsets.only(
                  left: 10.0,
                  right: index == categoryImages.length - 1 ? 10.0 : 0,
                  bottom: 10.0,
                ),
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                  left: 5.0,
                  right: 5.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(100.0),
                  image: DecorationImage(
                    image: AssetImage(categoryImages[index]),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget featureProducts(
    BuildContext context,
    List<String> apiProductImage,
    List<String> apiProductPrice,
    List<String> apiProductNames,
    Function(String) getProductDetail,
    List<String> id,
  ) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: Text(
            "Feature Products",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: apiProductImage.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  getProductDetail(id[index]);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  margin: EdgeInsets.only(
                    left: 10.0,
                    right: index == apiProductImage.length - 1 ? 10.0 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: CachedNetworkImage(
                          imageUrl: apiProductImage[index],
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.13,
                          height: MediaQuery.of(context).size.height * 0.022,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Text(
                              "\$${apiProductPrice[index]}",
                              style: const TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.068,
                          child: Center(
                            child: Text(
                              apiProductNames[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 11),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget categoryProduct(
    BuildContext context,
    List<String> apiCategoryName,
    List<String> apiCategoryImage,
    List<String> apiCategoryId,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10, left: 10),
            child: Text(
              "Products Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                mainAxisExtent: MediaQuery.of(context).size.height * 0.17,
              ),
              itemCount: apiCategoryName.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    homeController.getSubList(context, apiCategoryId[index], apiCategoryName[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                apiCategoryName[index],
                                style: const TextStyle(color: Colors.blueAccent),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: CachedNetworkImage(
                              imageUrl: apiCategoryImage[index],
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
