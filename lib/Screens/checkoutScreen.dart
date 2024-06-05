import 'package:demo_project/GetX%20Controller/addressControlle.dart';
import 'package:demo_project/GetX%20Controller/cartController.dart';
import 'package:demo_project/GetX%20Controller/shippingControlle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartController cartController=Get.put(CartController());
  final ShippingController shippingController=Get.put(ShippingController());
  final AddressController addressController=Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex:13,
                child: Content(context, cartController, shippingController,addressController)),
              Expanded(
                 flex:1,
                child: button(shippingController,context))
            ],
          ) ,),
    );
  }
}

Widget Content(context, cartController, shippingController,addressController){
  return SingleChildScrollView(
    child: Column(
      children: [
     orderItemsSection(context, cartController, shippingController),
     addressMetodPaywith_Section(context,cartController, shippingController,addressController)
      ],
    ),
  );
}

Widget orderItemsSection(BuildContext context, CartController cartController,shippingController) {
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
          offset: Offset(0, 5), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int index = 0; index < cartController.cartData.length; index++)
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 5, top: 5),
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Text(
                          cartController.cartData[index]['product_name'],
                          style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text("${cartController.cartData[index]['quantity']} * ${cartController.cartData[index]['product_price']}",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Total Price: \$${cartController.cartData[index]['total'].toString().length >= 5 ? cartController.cartData[index]['total'].toString().substring(0, 5) : cartController.cartData[index]['total'].toString()}",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
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
          Obx(()=>Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Sub Total",style: TextStyle(fontWeight: FontWeight.bold),), Text("\$ ${cartController.totalAmount1.toString().length >= 5 ? cartController.totalAmount.toString().substring(0, 5) : cartController.totalAmount.toString()}")],
           ) ),
       Obx(() => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text("Shipping Charge", style: TextStyle(fontWeight: FontWeight.bold)),
    Text("${shippingController.shippingMethodTax}")
  ],
)),
      Obx(() => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text("Estimated salesTax", style: TextStyle(fontWeight: FontWeight.bold)),
    Text("\$ ${shippingController.EstimatedSalesTax.toString().length>=5 ? shippingController.EstimatedSalesTax.toString().substring(0,5):shippingController.EstimatedSalesTax.toString()}")
  ],
)),
        Divider(
          color: Colors.black,
          height: MediaQuery.of(context).size.height *
              0.03, // Total height of the divider including space
          thickness: 2, // Thickness of the line itself
          indent: MediaQuery.of(context).size.height *
              0.01, // Starting space of the line
          endIndent: MediaQuery.of(context).size.height *
              0.01, // Ending space of the line
        ),
         Obx(() => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
    Text("\$ ${shippingController.NetAmount.toString().length>=5 ? shippingController.NetAmount.toString().substring(0,5):shippingController.NetAmount.toString()}")
  ],
)),
        // Other rows...
      ],
    ),
  );
}


Widget addressMetodPaywith_Section(context,cartController, shippingController,addressController){
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    child: Column(
      children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Contact"),
          Text(addressController.AddressDatas[0]['bill_email1'])
        ],
       ),
       dividerFunction(context),
  repeatAddress(context,cartController, shippingController,addressController,"Shipping To"),
      dividerFunction(context),
   repeatAddress(context,cartController, shippingController,addressController,"Billing To"),
    dividerFunction(context),
     Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("PayWith"),
          Text('${shippingController.PayWith}')
        ],
       ),
      ],
    ),
  );
}


Widget repeatAddress(context,cartController, shippingController,addressController,heading){
  return Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading),
          Container(
            width: MediaQuery.of(context).size.width*0.5,
            alignment: Alignment.centerRight,
            // color: Colors.amber,
            child: Column(
              
              children: [
               Text("${addressController.AddressDatas[0]['bill_name']}",textAlign:TextAlign.right,),
               Text("${addressController.AddressDatas[0]['bill_l_name']}",textAlign:TextAlign.right,), 
               Text("${addressController.AddressDatas[0]['bill_address1']}",textAlign:TextAlign.right,), 
               Text("${addressController.AddressDatas[0]['bill_address2']}",textAlign:TextAlign.right,),
               Text("${addressController.AddressDatas[0]['bill_town_city']}",textAlign:TextAlign.right,),
               Text("${addressController.AddressDatas[0]['bill_state_region1']}",textAlign:TextAlign.right,),
               Text("${addressController.AddressDatas[0]['bill_country']}",textAlign:TextAlign.right,),
               Text("${addressController.AddressDatas[0]['bill_zip_code']}",textAlign:TextAlign.right,),
              ],
            ),
          )
        ],
       );
}

Widget dividerFunction(context){
  return  Divider(
          color: Colors.black,
          height: MediaQuery.of(context).size.height *
              0.03, // Total height of the divider including space
          thickness: 2, // Thickness of the line itself
          indent: MediaQuery.of(context).size.height *
              0.01, // Starting space of the line
          endIndent: MediaQuery.of(context).size.height *
              0.01, // Ending space of the line
        );
}

Widget button(shippingController,context){
  return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                        onPressed: () {
                             shippingController.fetchPlaceOrder(context);
                        },
                        child: Text("Place Order"),
                      ),
                    );
}