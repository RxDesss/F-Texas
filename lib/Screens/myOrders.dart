import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:demo_project/GetX%20Controller/myorderController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final LoginController loginController = Get.put(LoginController());
  final MyOrderController myOrderController = Get.put(MyOrderController());

  String? userName;
  List<String> orderId = [];
  List<String> orderDate = [];
  List<String> netAmount = [];

  void getUserData() {
    myOrderController.getMyOrder(loginController.userId);
  }

  void getMyOrder() {
    for (var obj in myOrderController.orderList) {
      setState(() {
        orderId.add(obj['order_id']);
        orderDate.add(obj['net_amount']);
        netAmount.add(obj['created_at']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMyOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Order"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                itemCount: orderId.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.015,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(bottomRight:Radius.circular( MediaQuery.of(context).size.height * 0.1)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left:10,right:10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Order ID"),
                                  Text(":"),
                                Text("${orderId[index]}"),
                              ],
                            ),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Order Date"),
                                Text(":"),
                                Text("${orderDate[index]}"),
                              ],
                            ),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Net Amount"),
                                  Text(":"),
                                Text(" ${netAmount[index]}"),
                               
                              ],
                            ),
                             SizedBox(
                                  height: MediaQuery.of(context).size.width * 0.04 ,
                                ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.15,
                                  right:
                                      MediaQuery.of(context).size.width * 0.15),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Colors.blue, // Set the background color
                                ),
                                onPressed: () {},
                                child: Text("Invoice",style: TextStyle(color: Colors.white),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
