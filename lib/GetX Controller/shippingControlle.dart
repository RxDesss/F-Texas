
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:demo_project/Common/commom.dart';
import 'package:demo_project/GetX%20Controller/addressControlle.dart';
import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:demo_project/Screens/checkoutScreen.dart';
import 'package:demo_project/Screens/paymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  RxList<dynamic> shippingMethodsData = <dynamic>[].obs;
  
  RxBool isLoadingShippingAPI = true.obs;
  RxString shippingMethodTax = ''.obs;
  RxString shippingMethodTaxName = ''.obs;
  RxString EstimatedSalesTax = ''.obs;
  RxString combainedRate = ''.obs;
  RxString baseAmount = ''.obs;
  RxString NetAmount = ''.obs;
  RxString PayWith = ''.obs;
  
  List<dynamic> baseAmountFulldata = [].obs;
  void shipping() async {
     Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    await addressController.fetchOldAddress();
    await getBaseAmount();
 
    fetchOrderTax();
    cartController.getCartItems();
    fetchShippingMethods();
       Get.back();
    Get.to(() => const ShippingScreen());
  }

  Future<void> fetchContinueToPayment() async {
    final address = addressController.AddressDatas[0];
    String url = "https://www.texasknife.com/dynamic/texasknifeapi.php?action=insert_update_checkoutship"
        "&bill_name=${address['bill_name']}&bill_l_name=${address['bill_l_name']}"
        "&bill_address1=${address['bill_address1']}&bill_address2=${address['bill_address2']}"
        "&bill_town_city=${address['bill_town_city']}&bill_state_region1=${address['bill_state_region1']}"
        "&bill_zip_code=${address['bill_zip_code']}&bill_country=${address['bill_country']}"
        "&bill_phone=${address['bill_phone']}&bill_email1=${address['bill_email1']}"
        "&customer_id=${address['customer_id']}&sessions_id=${address['sessions_id']}"
        "&rurl=&ship_amt=${shippingMethodTax.value}&tx_amount=\$${EstimatedSalesTax.value}"
        "&check_out_total_amount=\$${NetAmount.value}&payment_type=&shipment_name=${shippingMethodTaxName.value}"
        "&bill_company=${address['bill_company']}";
    
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        continueToPayment.assign(json['data']);
        Get.to(() => const PaymentScreen());
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> fetchPayment(String paymentName) async {
    final address = addressController.AddressDatas[0];
    String url = "https://www.texasknife.com/dynamic/texasknifeapi.php?action=insert_update_checkoutship"
        "&bill_name=${address['bill_name']}&bill_l_name=${address['bill_l_name']}"
        "&bill_address1=${address['bill_address1']}&bill_address2=${address['bill_address2']}"
        "&bill_town_city=${address['bill_town_city']}&bill_state_region1=${address['bill_state_region1']}"
        "&bill_zip_code=${address['bill_zip_code']}&bill_country=${address['bill_country']}"
        "&bill_phone=${address['bill_phone']}&bill_email1=${address['bill_email1']}"
        "&customer_id=${address['customer_id']}&sessions_id=${address['sessions_id']}"
        "&rurl=&ship_amt=${shippingMethodTax.value}&tx_amount=\$${EstimatedSalesTax.value}"
        "&check_out_total_amount=\$${NetAmount.value}&payment_type=$paymentName"
        "&shipment_name=${shippingMethodTaxName.value}&bill_company=${address['bill_company']}";
    
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        continueToPayment.assign(json['data']);
        Get.to(() => const CheckoutScreen());
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> fetchPlaceOrder(BuildContext context) async {
    final address = addressController.AddressDatas[0];
    final productData = baseAmountFulldata[0];
    String url = 'https://www.texasknife.com/dynamic/texasknifeapi.php?action=front_counter_insertion'
        '&website_id=1&customer_id=${address['customer_id']}&customer_email=${address['bill_email1']}&session_id=${address['sessions_id']}'
        '&bill_f_name=${address['bill_name']}&bill_l_name=${address['bill_l_name']}&bill_address1=${address['bill_address1']}'
        '&bill_address2=${address['bill_address2']}&bill_town_city=${address['bill_town_city']}&bill_state_region1=${address['bill_state_region1']}'
        '&bill_zipcode=${address['bill_zip_code']}&bill_country=${address['bill_country']}&bill_phone=${address['bill_phone']}&bill_emaill=${address['bill_email1']}'
        '&payment_type=${PayWith.value}&comments=&number=12345'
        '&ship_f_name=${address['bill_name']}&ship_l_name=${address['bill_l_name']}&ship_address1=${address['bill_address1']}'
        '&ship_address2=${address['bill_address2']}&ship_town_city=${address['bill_town_city']}&ship_state=${address['bill_state_region1']}'
        '&ship_zipcode=${address['bill_zip_code']}&ship_country=${address['bill_country']}&ship_phone=${address['bill_phone']}&ship_email=${address['bill_email1']}'
        '&product_id=${productData["product_ids_exact"]}&quantity=${productData["quantity_exact"]}&product_names=${productData["product_names_exact"]}'
        '&product_skus=${productData["product_skus_exact"]}&product_pricess=${productData["product_pricess_exact"]}&discount=${productData["discount_exact"]}'
        '&discount_price=${productData["discount_price_exact"]}&base_price=${productData["base_price_exact"]}&price=${productData["price_exact"]}'
        '&taxable=${productData["taxable_exact"]}&tax_percentage=${productData["tax_percentage_exact"]}&taxable_amt=${productData["taxable_amt_exact"]}'
        '&ship_amt=${productData["ship_amt_exact"]}&total=${productData["total_exact"]}&net_amount=${productData["net_amount_exact"]}';
    
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Order Placed Successfully"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Comman.sucesstoast("Order Placed sucessfully ❤️");
                    Navigator.pushReplacementNamed(context, '/tabnavigation');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> fetchOrderTax() async {
    final stateRegion = addressController.AddressDatas[0]['bill_state_region1'];
    String url = "https://www.texasknife.com/dynamic/texasknifeapi.php?action=get_tax_details&shipping_state=$stateRegion";
    
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        orderTaxData.assign(json['data'][0]);
        isLoadingShippingAPI.value = false;
        combainedRate.value = orderTaxData[0]['combined_rate'];
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> fetchShippingMethods() async {
    final address = addressController.AddressDatas[0];
    String url = "https://www.texasknife.com/dynamic/texasknifeapi.php?action=ups_shippment_ys"
        "&pounds=2&shipping_city=${address['bill_town_city']}&shipping_state=${address['bill_state_region1']}"
        "&shipping_zip=${address['bill_zip_code']}&ship_country=${address['bill_country']}";
    
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        shippingMethodsData.assign(json['data'][0]);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> getBaseAmount() async {
    String url = 'https://www.texasknife.com/dynamic/texasknifeapi.php?action=final_tax_rate&store_id=1&customer_id=${loginController.userId}';
    
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        baseAmount.value = json['data'][0]['base_price_exact'];
        baseAmountFulldata = json['data'];
      }
    } catch (e) {
      // Handle error
    }
  }

  void getEstimatedSalesTax() {
    final baseAmountValue = double.parse(baseAmount.value);
    final shippingTaxValue = double.parse(shippingMethodTax.value.replaceAll('\$', ''));
    final combinedRateValue = double.parse(combainedRate.value.replaceAll('\%', '')) / 100;
    final subtotal = baseAmountValue + shippingTaxValue;
    final finalEstimatedTax = combinedRateValue * subtotal;
    
    EstimatedSalesTax.value = finalEstimatedTax.toString();
    NetAmount.value = (cartController.totalAmount + shippingTaxValue + finalEstimatedTax).toString();
  }
}
