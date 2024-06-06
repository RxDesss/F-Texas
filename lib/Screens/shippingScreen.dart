import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_project/GetX%20Controller/cartController.dart';
import 'package:demo_project/GetX%20Controller/shippingControlle.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final ShippingController shippingController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipping"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                color: const Color.fromARGB(255, 183, 244, 252),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (cartController.isLoadingCartAPI.value) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return orderItemsSection(context, cartController, shippingController);
                      }),
                      Obx(() {
                        if (shippingController.isLoadingShippingAPI.value) {
                          return const Center(child: CircularProgressIndicator());
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
                child: const Text("Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget orderItemsSection(BuildContext context, CartController cartController, ShippingController shippingController) {
  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
    margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
    decoration: BoxDecoration(
      color: Colors.amber[50],
      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.03),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
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
            margin: const EdgeInsets.symmetric(vertical: 5),
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
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Total Price: \$${cartController.cartData[index]['total'].toString().length >= 5 ? cartController.cartData[index]['total'].toString().substring(0, 5) : cartController.cartData[index]['total'].toString()}",
                        style: const TextStyle(fontSize: 12),
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
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Sub Total", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("\$${cartController.totalAmount1.toString().length >= 5 ? cartController.totalAmount1.toString().substring(0, 4) : cartController.totalAmount1.toString()}")
          ],
        )),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Shipping Charge", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("${shippingController.shippingMethodTax}")
          ],
        )),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Estimated salesTax", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("\$${shippingController.EstimatedSalesTax.toString().length >= 5 ? shippingController.EstimatedSalesTax.toString().substring(0, 5) : shippingController.EstimatedSalesTax.toString()}")
          ],
        )),
        Divider(
          color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.03,
          thickness: 2,
          indent: MediaQuery.of(context).size.height * 0.01,
          endIndent: MediaQuery.of(context).size.height * 0.01,
        ),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("\$${shippingController.NetAmount.toString().length >= 5 ? shippingController.NetAmount.toString().substring(0, 5) : shippingController.NetAmount.toString()}")
          ],
        )),
      ],
    ),
  );
}

Widget taxItemSection(BuildContext context, ShippingController shippingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Shipping Method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        color: const Color.fromARGB(255, 248, 243, 242),
        child: Obx(
          () => shippingController.shippingMethodsData.isNotEmpty
              ? ListView.builder(
                  itemCount: shippingController.shippingMethodsData[0]['shipping'].split(',').length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = shippingController.shippingMethodsData[0]['shipping'].split(',')[index];
                    final String optionName = option.split('||')[0];
                    final String optionValue = option.split('||')[1];

                    return ShippingOptionTile(
                      optionName: optionName,
                      optionValue: optionValue,
                    );
                  },
                )
              : const Center(child: Text('No shipping methods available')),
        ),
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
  final ShippingController shippingController = Get.put(ShippingController());
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(widget.optionName),
      value: widget.optionValue,
      groupValue: _isSelected ? widget.optionName : null,
      onChanged: (value) {
        shippingController.shippingMethodTax.value = value!;
        shippingController.shippingMethodTaxName.value = "${widget.optionName} - ${widget.optionValue}";
        shippingController.getEstimatedSalesTax();
        setState(() {
          _isSelected = true;
        });
      },
      subtitle: Text(widget.optionValue),
    );
  }
}
