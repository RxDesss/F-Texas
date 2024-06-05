import 'package:demo_project/GetX%20Controller/cartController.dart';
import 'package:demo_project/GetX%20Controller/productdetailController.dart';
import 'package:demo_project/GetX%20Controller/shippingControlle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreeen extends StatefulWidget {
  const CartScreeen({super.key});

  @override
  State<CartScreeen> createState() => _CartScreeenState();
}

class _CartScreeenState extends State<CartScreeen> {
  final CartController cartController = Get.put(CartController());
  final ProductDetailController productDetailContoller = Get.put(ProductDetailController());
  final ShippingController shippingController = Get.put(ShippingController());
  late Future<List<Map<String, dynamic>>> _futureCartData;

  void _fetchCartData() {
    _futureCartData = cartController.getCartItems();
    _futureCartData.catchError((error) {
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _futureCartData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Text(
                            'Your cart is empty',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 147, 183, 245),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      height: MediaQuery.of(context).size.height * 0.10,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blueGrey[50],
                                      ),
                                      child: Image.network(
                                        item['product_image'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.03,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            iconSize: 18.0,
                                            onPressed: () {
                                              cartController
                                                  .minusProductQuantity(item['id'], item['total'])
                                                  .then((_) => setState(_fetchCartData));
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text(item['quantity']),
                                          IconButton(
                                            iconSize: 18.0,
                                            onPressed: () {
                                              cartController
                                                  .addProductQuantity(item['id'], item['total'])
                                                  .then((_) => setState(_fetchCartData));
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: MediaQuery.of(context).size.height * 0.15,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            child: Text(
                                              item['product_name'],
                                              style: const TextStyle(
                                                overflow: TextOverflow.fade,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Quantity : ",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Text(item['quantity']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "TotalPrice : ",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Text("\$ ${item['total'].toString().length >= 5 ? item['total'].toString().substring(0, 5) : item['total'].toString()}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.info),
                                      onPressed: () {
                                        productDetailContoller.getProductDetail(item['id']);
                                      },
                                      color: const Color.fromARGB(255, 6, 104, 11),
                                      iconSize: 20.0,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        cartController
                                            .deleteCartItem(item['id'])
                                            .then((_) => setState(_fetchCartData));
                                      },
                                      color: const Color.fromARGB(255, 243, 34, 34),
                                      iconSize: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        const Text(
                          "Sub Total - ",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder<List<Map<String, dynamic>>>(
                          future: _futureCartData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              double totalAmount = 0;
                              if (snapshot.hasData) {
                                for (var item in snapshot.data!) {
                                  totalAmount += item['total'];
                                }
                              }
                              return Text(
                                "\$ ${totalAmount.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _futureCartData,
                    builder: (context, snapshot) {
                      bool isCartEmpty = snapshot.hasData && snapshot.data!.isEmpty;
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: isCartEmpty ? Colors.grey : Colors.blueAccent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          onPressed: isCartEmpty ? null : shippingController.shipping,
                          child: const Text("Proceed to Checkout"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
