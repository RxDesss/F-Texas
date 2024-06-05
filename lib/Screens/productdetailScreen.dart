import 'package:demo_project/GetX%20Controller/cartController.dart';
import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:demo_project/GetX%20Controller/productdetailController.dart';
import 'package:demo_project/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:flutter_html/flutter_html.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final ProductDetailController productDetailContoller =
      Get.put(ProductDetailController());
      final CartController cartController=Get.put(CartController());

  String productName = '';
  String productSku = '';
  String productDescription = '';
  String productPrice = '';
  int productQuantity = 1;
  String imageUrl = '';
  String productId='';
 

  void getData() {
 
    for (var obj in productDetailContoller.ProdectDetailList) {
      setState(() {
        productName = obj['product_name'];
        productSku = obj['sku'];
        productDescription = obj['description'];
        productPrice = obj['product_price'];
        productId=obj['id'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imageUrl = productDetailContoller.imageUrl;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height:MediaQuery.of(context).size.height * 0.3,
              // color: Colors.amber,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              // flex: 7,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height:MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 170, 168, 167),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Quantity",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          productQuantity++;
                                        });
                                      },
                                      icon: Icon(Icons.add)),
                                  Text('$productQuantity'),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (productQuantity > 1) {
                                            productQuantity--;
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.remove)),
                                ],
                              )
                            ],
                          ),
                          FloatingActionButton.extended(
                            onPressed: () {
                              cartController.getAddToCart(
                                productId,productQuantity,productSku,productPrice,context
                              );
                              // Add your onPressed function here
                              
                            },
                            icon: Icon(Icons
                                .add_shopping_cart), // Add your desired icon here
                            label: Text("Add To Cart"),
                            // You can customize the width of the button by setting the button's widthFactor
                            // For example, widthFactor: 2.0 will make the button twice as wide
                            // width: 200.0, // Adjust the width according to your preference
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        "${productName}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${productSku}"),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Column(
                        children: [
                          Text(
                            "Price :",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text("\$ ${productPrice}")
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discription :",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            " ${productDescription.replaceAll(RegExp(r'<[^>]*>|<\/[^>]*>'), '')},",
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
