// ignore_for_file: file_names, non_constant_identifier_names

import 'package:demo_project/GetX%20Controller/addressControlle.dart';
import 'package:demo_project/GetX%20Controller/cartController.dart';
import 'package:demo_project/GetX%20Controller/shippingControlle.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartController cartController = Get.put(CartController());
  final ShippingController shippingController = Get.put(ShippingController());
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 13,
              child: Content(context, cartController, shippingController, addressController),
            ),
            Expanded(
              flex: 1,
              child: CheckoutButton(shippingController, context),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget Content(BuildContext context, CartController cartController, ShippingController shippingController, AddressController addressController) {
  return SingleChildScrollView(
    child: Column(
      children: [
        OrderItemsSection(context, cartController, shippingController),
        AddressMethodPayWithSection(context, cartController, shippingController, addressController),
      ],
    ),
  );
}

Widget OrderItemsSection(BuildContext context, CartController cartController, ShippingController shippingController) {
  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
    margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
    decoration: BoxDecoration(
      color: Colors.amber[50],
      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.03),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int index = 0; index < cartController.cartData.length; index++)
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
            ),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.height * 0.09,
                  color: const Color.fromARGB(255, 245, 209, 215),
                  child: Image.network(
                    cartController.cartData[index]['product_image'],
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Text(
                          cartController.cartData[index]['product_name'],
                          style: const TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "${cartController.cartData[index]['quantity']} * ${cartController.cartData[index]['product_price']}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Total Price: \$${cartController.cartData[index]['total'].toString().substring(0, 5)}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Divider(
          color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.03,
          thickness: 2,
          indent: MediaQuery.of(context).size.height * 0.01,
          endIndent: MediaQuery.of(context).size.height * 0.01,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sub Total",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("\$ ${cartController.totalAmount1.toString().substring(0, 4)}"),
            ],
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Shipping Charge",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${shippingController.shippingMethodTax}"),
            ],
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Estimated salesTax",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("\$ ${shippingController.EstimatedSalesTax.toString().substring(0, 5)}"),
            ],
          ),
        ),
        Divider(
          color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.03,
          thickness: 2,
          indent: MediaQuery.of(context).size.height * 0.01,
          endIndent: MediaQuery.of(context).size.height * 0.01,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("\$ ${shippingController.NetAmount.toString().substring(0, 5)}"),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget AddressMethodPayWithSection(BuildContext context, CartController cartController, ShippingController shippingController, AddressController addressController) {
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(10),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Contact"),
            Text(addressController.AddressDatas[0]['bill_email1']),
          ],
        ),
        const DividerWidget(),
        RepeatAddress(context, addressController, "Shipping To"),
        const DividerWidget(),
        RepeatAddress(context, addressController, "Billing To"),
        const DividerWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Pay With"),
            Text('${shippingController.PayWith}'),
          ],
        ),
      ],
    ),
  );
}

Widget RepeatAddress(BuildContext context, AddressController addressController, String heading) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(heading),
      Container(
        width: MediaQuery.of(context).size.width * 0.5,
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("${addressController.AddressDatas[0]['bill_name']}"),
            Text("${addressController.AddressDatas[0]['bill_l_name']}"),
            Text("${addressController.AddressDatas[0]['bill_address1']}"),
            Text("${addressController.AddressDatas[0]['bill_address2']}"),
            Text("${addressController.AddressDatas[0]['bill_town_city']}"),
            Text("${addressController.AddressDatas[0]['bill_state_region1']}"),
            Text("${addressController.AddressDatas[0]['bill_country']}"),
            Text("${addressController.AddressDatas[0]['bill_zip_code']}"),
          ],
        ),
      ),
    ],
  );
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black,
      height: MediaQuery.of(context).size.height * 0.03,
      thickness: 2,
      indent: MediaQuery.of(context).size.height * 0.01,
      endIndent: MediaQuery.of(context).size.height * 0.01,
    );
  }
}

Widget CheckoutButton(ShippingController shippingController, BuildContext context) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 30),
    decoration: BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextButton(
      onPressed: () {
        shippingController.fetchPlaceOrder(context);
      },
      child: const Text("Place Order"),
    ),
  );
}
