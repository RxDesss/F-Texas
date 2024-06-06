import 'dart:convert';
import 'dart:ffi';
import 'package:demo_project/GetX%20Controller/addressControlle.dart';
import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:demo_project/Screens/checkoutScreen.dart';
import 'package:demo_project/Screens/homeScreen.dart';
import 'package:demo_project/Screens/paymentScreen.dart';
import 'package:demo_project/Screens/tabNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'cartController.dart';
import 'homeController.dart';
import '../Screens/shippingScreen.dart';

class ShippingController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeContoller = Get.find();
  final CartController cartController = Get.find();
  final AddressController addressController = Get.put(AddressController());
  RxList<dynamic> continueToPayment = <dynamic>[].obs;
  RxList<dynamic> orderTaxData = <dynamic>[].obs;
  List<dynamic> shippingMethodsData = [].obs;
  RxBool isLoadingShippingAPI = true.obs;
  RxString shippingMethodTax = ''.obs;
  RxString shippingMethodTaxName=''.obs;
  RxString EstimatedSalesTax = ''.obs;
  RxString combainedRate = ''.obs;
  RxString baseAmount = ''.obs;
  RxString NetAmount = ''.obs;
  RxString PayWith=''.obs;
    List<dynamic> baseAmountFulldata=[].obs;

  get selectedOption => null;

  void shipping() async {
    await addressController.fetchOldAddress();
    getBaseAmount();

    Get.to(() => ShippingScreen());
    fetchOrderTax();
    cartController.getCartItems();
    fetchShippingMethods();
  }

  Future<void> fetchContinueToPayment() async {
    print("bill_name : ${addressController.AddressDatas[0]['bill_name']}");
    print("bill_l_name : ${addressController.AddressDatas[0]['bill_l_name']}");
    print("bill_address1 : ${addressController.AddressDatas[0]['bill_address1']}");
    print("bill_address2 : ${addressController.AddressDatas[0]['bill_address2']}");
    print("bill_town_city : ${addressController.AddressDatas[0]['bill_town_city']}");
    print(
        "bill_state_region1 : ${addressController.AddressDatas[0]['bill_state_region1']}");
    print("bill_zip_code : ${addressController.AddressDatas[0]['bill_zip_code']}");
    print("bill_country : ${addressController.AddressDatas[0]['bill_country']}");
    print("bill_phone : ${addressController.AddressDatas[0]['bill_phone']}");
    print("bill_email1 : ${addressController.AddressDatas[0]['bill_email1']}");
    print("customer_id : ${addressController.AddressDatas[0]['customer_id']}");
    print("sessions_id : ${addressController.AddressDatas[0]['sessions_id']}");
    print("ship_amt : ${shippingMethodTax}");
    print("tx_amount : \$${EstimatedSalesTax}");
    print("check_out_total_amount : \$${NetAmount}");
    print("shipment_name : ${shippingMethodTaxName}");
      print("bill_company : ${addressController.AddressDatas[0]['bill_company']}");


    String url = "https://www.texasknife.com/dynamic/texasknifeapi.php?action=insert_update_checkoutship&bill_name=${addressController.AddressDatas[0]['bill_name']}&bill_l_name=${addressController.AddressDatas[0]['bill_l_name']}&bill_address1=${addressController.AddressDatas[0]['bill_address1']}&bill_address2=${addressController.AddressDatas[0]['bill_address2']}&bill_town_city=${addressController.AddressDatas[0]['bill_town_city']}&bill_state_region1=${addressController.AddressDatas[0]['bill_state_region1']}&bill_zip_code=${addressController.AddressDatas[0]['bill_zip_code']}&bill_country=${addressController.AddressDatas[0]['bill_country']}&bill_phone=${addressController.AddressDatas[0]['bill_phone']}&bill_email1=${addressController.AddressDatas[0]['bill_email1']}&customer_id=${addressController.AddressDatas[0]['customer_id']}&sessions_id=${addressController.AddressDatas[0]['sessions_id']}&rurl=&ship_amt=${shippingMethodTax}&tx_amount=\$${EstimatedSalesTax}&check_out_total_amount=\$${NetAmount}&payment_type=&shipment_name=${shippingMethodTaxName}&bill_company=${addressController.AddressDatas[0]['bill_company']}";
    print('fetchContinueToPayment: $url');
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        continueToPayment.assign(json['data']);

        print("continueToPayment");
        print(continueToPayment);
        Get.to(()=>PaymentScreen());
      }
    } catch (e) {
      print('Error in fetchContinueToPayment: $e');
    }
  }
   Future<void> fetchPayment(paymentName) async {
    print("bill_name : ${addressController.AddressDatas[0]['bill_name']}");
    print("bill_l_name : ${addressController.AddressDatas[0]['bill_l_name']}");
    print("bill_address1 : ${addressController.AddressDatas[0]['bill_address1']}");
    print("bill_address2 : ${addressController.AddressDatas[0]['bill_address2']}");
    print("bill_town_city : ${addressController.AddressDatas[0]['bill_town_city']}");
    print(
        "bill_state_region1 : ${addressController.AddressDatas[0]['bill_state_region1']}");
    print("bill_zip_code : ${addressController.AddressDatas[0]['bill_zip_code']}");
    print("bill_country : ${addressController.AddressDatas[0]['bill_country']}");
    print("bill_phone : ${addressController.AddressDatas[0]['bill_phone']}");
    print("bill_email1 : ${addressController.AddressDatas[0]['bill_email1']}");
    print("customer_id : ${addressController.AddressDatas[0]['customer_id']}");
    print("sessions_id : ${addressController.AddressDatas[0]['sessions_id']}");
    print("ship_amt : ${shippingMethodTax}");
    print("tx_amount : \$${EstimatedSalesTax}");
    print("check_out_total_amount : \$${NetAmount}");
    print("shipment_name : ${shippingMethodTaxName}");
      print("bill_company : ${addressController.AddressDatas[0]['bill_company']}");


    String url = "https://www.texasknife.com/dynamic/texasknifeapi.php?action=insert_update_checkoutship&bill_name=${addressController.AddressDatas[0]['bill_name']}&bill_l_name=${addressController.AddressDatas[0]['bill_l_name']}&bill_address1=${addressController.AddressDatas[0]['bill_address1']}&bill_address2=${addressController.AddressDatas[0]['bill_address2']}&bill_town_city=${addressController.AddressDatas[0]['bill_town_city']}&bill_state_region1=${addressController.AddressDatas[0]['bill_state_region1']}&bill_zip_code=${addressController.AddressDatas[0]['bill_zip_code']}&bill_country=${addressController.AddressDatas[0]['bill_country']}&bill_phone=${addressController.AddressDatas[0]['bill_phone']}&bill_email1=${addressController.AddressDatas[0]['bill_email1']}&customer_id=${addressController.AddressDatas[0]['customer_id']}&sessions_id=${addressController.AddressDatas[0]['sessions_id']}&rurl=&ship_amt=${shippingMethodTax}&tx_amount=\$${EstimatedSalesTax}&check_out_total_amount=\$${NetAmount}&payment_type=${paymentName}&shipment_name=${shippingMethodTaxName}&bill_company=${addressController.AddressDatas[0]['bill_company']}";
    print('fetchPayment api : $url');
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        continueToPayment.assign(json['data']);

        print("continueToPayment");
        print(continueToPayment);
        Get.to(()=>CheckoutScreen());
      }
    } catch (e) {
      print('Error in fetchContinueToPayment: $e');
    }
  }
  
  Future<void> fetchPlaceOrder(context)async{

    String url='https://www.texasknife.com/dynamic/texasknifeapi.php?action=front_counter_insertion&website_id=1&customer_id=${addressController.AddressDatas[0]['customer_id']}&customer_email=${addressController.AddressDatas[0]['bill_email1']}&session_id=${addressController.AddressDatas[0]['sessions_id']}&bill_f_name=${addressController.AddressDatas[0]['bill_name']}&bill_l_name=${addressController.AddressDatas[0]['bill_l_name']}&bill_address1=${addressController.AddressDatas[0]['bill_address1']}&bill_address2=${addressController.AddressDatas[0]['bill_address2']}&bill_town_city=${addressController.AddressDatas[0]['bill_town_city']}&bill_state_region1=${addressController.AddressDatas[0]['bill_state_region1']}&bill_zipcode=${addressController.AddressDatas[0]['bill_zip_code']}&bill_country=${addressController.AddressDatas[0]['bill_country']}&bill_phone=${addressController.AddressDatas[0]['bill_phone']}&bill_emaill=${addressController.AddressDatas[0]['bill_email1']}&payment_type=${PayWith}&comments=&number=12345&ship_f_name=${addressController.AddressDatas[0]['bill_name']}&ship_l_name=${addressController.AddressDatas[0]['bill_l_name']}&ship_address1=${addressController.AddressDatas[0]['bill_address1']}&ship_address2=${addressController.AddressDatas[0]['bill_address2']}&ship_town_city=${addressController.AddressDatas[0]['bill_town_city']}&ship_state=${addressController.AddressDatas[0]['bill_state_region1']}&ship_zipcode=${addressController.AddressDatas[0]['bill_zip_code']}&ship_country=${addressController.AddressDatas[0]['bill_country']}&ship_phone=${addressController.AddressDatas[0]['bill_phone']}&ship_email=${addressController.AddressDatas[0]['bill_email1']}&product_id=${baseAmountFulldata[0]["product_ids_exact"]}&quantity=${baseAmountFulldata[0]["quantity_exact"]}&product_names=${baseAmountFulldata[0]["product_names_exact"]}&product_skus=${baseAmountFulldata[0]["product_skus_exact"]}&product_pricess=${baseAmountFulldata[0]["product_pricess_exact"]}&discount=${baseAmountFulldata[0]["discount_exact"]}&discount_price=${baseAmountFulldata[0]["discount_price_exact"]}&base_price=${baseAmountFulldata[0]["base_price_exact"]}&price=${baseAmountFulldata[0]["price_exact"]}&taxable=${baseAmountFulldata[0]["taxable_exact"]}&tax_percentage=${baseAmountFulldata[0]["tax_percentage_exact"]}&taxable_amt=${baseAmountFulldata[0]["taxable_amt_exact"]}&ship_amt=${baseAmountFulldata[0]["ship_amt_exact"]}&total=${baseAmountFulldata[0]["total_exact"]}&net_amount=${baseAmountFulldata[0]["net_amount_exact"]}';
 

//  print('Place order url : ${url}');
  try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
         showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Order Placed Successfully"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                Navigator.pushReplacementNamed(context, '/tabnavigation');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
     
      }
    } catch (e) {
      print('Error in fetchPlaceOrder: $e');
    }
  }

  Future<void> fetchOrderTax() async {
    String url =
        "https://www.texasknife.com/dynamic/texasknifeapi.php?action=get_tax_details&shipping_state=${addressController.AddressDatas[0]['bill_state_region1']}";
    print('fetchOrderTaxurl : $url');
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        orderTaxData.assign(json['data'][0]);
        isLoadingShippingAPI.value = false;
        combainedRate.value = orderTaxData[0]['combined_rate'];
        print("combained rate in : ${combainedRate}");
        print("orderTaxData");
        print(orderTaxData);
      }
    } catch (e) {
      print('Error in fetchOrderTax: $e');
    }
  }

  Future<void> fetchShippingMethods() async {
    String url =
        "https://texasknife.com/dynamic/texasknifeapi.php?action=ups_shippment_ys&pounds=2&shipping_city=${addressController.AddressDatas[0]['bill_town_city']}&shipping_state=${addressController.AddressDatas[0]['bill_state_region1']}&shipping_zip=${addressController.AddressDatas[0]['bill_zip_code']}&ship_country=${addressController.AddressDatas[0]['bill_country']}";
    print('shippingMethodsData Url : $url');
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        shippingMethodsData.assign(json['data'][0]);
        print("shippingMethodsData");
        print(shippingMethodsData);
      }
    } catch (e) {
      print('Error in shippingMethodsData: $e');
    }
  }

  Future<void> getBaseAmount() async {
    String url =
        'https://www.texasknife.com/dynamic/texasknifeapi.php?action=final_tax_rate&store_id=1&customer_id=${loginController.userId}';
    print("Bala url : ${url}");
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        final data = (json['data'][0]['base_price_exact']);
        baseAmount.value = data;
        baseAmountFulldata=(json['data']);
        print("baseAmountFulldata");
        print(baseAmountFulldata);
        print("getBaseAmount");
        print(data);
      }
    } catch (e) {
      print('Error in getBaseAmount: $e');
    }
  }

  getEstimatedSalesTax() {
    NetAmount.value = "";
    // double baseAmountValue = double.tryParse(baseAmount.value) ?? 0.0;
    // double shippingMethodTaxValue = double.tryParse(shippingMethodTax.value) ?? 0.0;

    // // Check if parsing was successful before performing calculations
    // if (baseAmountValue != null && shippingMethodTaxValue != null) {
    //   double totalAmount = baseAmountValue + shippingMethodTaxValue;
    //   double percentage = double.parse(combainedRate.value) / 100 * cartController.totalAmount;
    //   EstimatedSalesTax.value = percentage.toString();
    // } else {
    //   // Handle the case where parsing fails
    //   print("Error: Unable to parse base amount or shipping method tax.");
    // }
    final baseAmount1 = baseAmount;
    final calculatedShipTax1 = shippingMethodTax;
    final combinedRate1 = combainedRate;
    final subtotal = double.parse(baseAmount1.value) +
        double.parse(calculatedShipTax1.value.replaceAll('\$', ''));
    final finalEstimatedTax =
        double.parse(combinedRate1.value.replaceAll('\%', '')) / 100 * subtotal;
    EstimatedSalesTax.value = finalEstimatedTax.toString();

    final shipTaxWithoutDollar =
        double.parse(calculatedShipTax1.value.replaceAll('\$', ''));

    NetAmount.value =
        (cartController.totalAmount + shipTaxWithoutDollar + finalEstimatedTax)
            .toString();

    print("baseAmount : ${baseAmount}");
    print("shippingMethodTax : ${shipTaxWithoutDollar}");
    print("combainedRate : ${combainedRate}");
    print("SubTotal : ${cartController.totalAmount}");
  }
}