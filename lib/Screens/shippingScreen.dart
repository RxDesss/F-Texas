import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_project/GetX%20Controller/cartController.dart';
import 'package:demo_project/GetX%20Controller/shippingControlle.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final ShippingController shippingController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                color: Color.fromARGB(255, 183, 244, 252),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (cartController.isLoadingCartAPI.value) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return orderItemsSection(context, cartController,shippingController);
                      }),
                      Obx(() {
                        if (shippingController.isLoadingShippingAPI.value) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return taxItemSection(context, shippingController);
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  shippingController.fetchContinueToPayment();
                },
                child: Text("Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
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

Widget taxItemSection(BuildContext context, ShippingController shippingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Shipping Method",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
      ),
      Container(
        height: MediaQuery.of(context).size.height *0.3,
        width:double.infinity,
        color: Colors.deepOrange[50],
        child: shippingController.shippingMethodsData.isNotEmpty ? Obx(
          () => ListView.builder(
            itemCount: shippingController.shippingMethodsData[0]['shipping'].split(',').length,
            itemBuilder: (BuildContext context, int index) {
              final String option =  shippingController.shippingMethodsData[0]['shipping'].split(',')[index];
              final String optionName = option.split('||')[0];
              final String optionValue = option.split('||')[1];

              return ShippingOptionTile(
                optionName: optionName,
                optionValue: optionValue,
              );
            },
          ),
        ) : Center(child: Text('No shipping methods available')),
      ),
    ],
  );
}

class ShippingOptionTile extends StatefulWidget {
  final String optionName;
  final String optionValue;

  const ShippingOptionTile({
    Key? key,
    required this.optionName,
    required this.optionValue,
  }) : super(key: key);

  @override
  _ShippingOptionTileState createState() => _ShippingOptionTileState();
}

class _ShippingOptionTileState extends State<ShippingOptionTile> {
  final ShippingController shippingController=Get.put(ShippingController());
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(widget.optionName),
      value: widget.optionValue,
      groupValue: _isSelected ? widget.optionName : null,
      onChanged: (value) {
        shippingController.shippingMethodTax.value=value!;
        shippingController.shippingMethodTaxName.value="${widget.optionName}-${widget.optionValue}";
        shippingController.getEstimatedSalesTax();
        setState(() {
          print(value);
          _isSelected = true;
          

        });
        // Add your logic here when a radio button is selected
      },
      subtitle: Text(widget.optionValue),
    );
  }
}
