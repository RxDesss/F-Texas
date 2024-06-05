import 'package:demo_project/GetX%20Controller/shippingControlle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ShippingController shippingController=Get.put(ShippingController());
  bool showCardFields = false;
  bool showMoneyOrderField = false;
  bool showCheckNumberField = false;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController ccvController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController moneyOrderController = TextEditingController();
  TextEditingController checkNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Define form key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageContainer(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Form(
                key: _formKey, // Attach form key to Form widget
                child: PaymentContainer(
                  showCardFields: showCardFields,
                  showMoneyOrderField: showMoneyOrderField,
                  showCheckNumberField: showCheckNumberField,
                  cardNumberController: cardNumberController,
                  ccvController: ccvController,
                  endDateController: endDateController,
                  moneyOrderController: moneyOrderController,
                  checkNumberController: checkNumberController,
                  onCardCheckboxChanged: (value) {
                    setState(() {
                      showCardFields = value ?? false;
                      if (showCardFields) {
                        showMoneyOrderField = false;
                        showCheckNumberField = false;
                      }
                    });
                  },
                  onMoneyOrderCheckboxChanged: (value) {
                    setState(() {
                      showMoneyOrderField = value ?? false;
                      if (showMoneyOrderField) {
                        showCardFields = false;
                        showCheckNumberField = false;
                      }
                    });
                  },
                  onCheckNumberCheckboxChanged: (value) {
                    setState(() {
                      showCheckNumberField = value ?? false;
                      if (showCheckNumberField) {
                        showCardFields = false;
                        showMoneyOrderField = false;
                      }
                    });
                  },
                ),
              ),
SizedBox(
  height: MediaQuery.of(context).size.height*0.1,
),
              Container(
                width: double.infinity,
                margin:EdgeInsets.all( MediaQuery.of(context).size.height*0.05),
                child: ElevatedButton(
                   style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.amber[100]),
    ),
                  onPressed: () {
                    // Handle button press
                    if (_formKey.currentState!.validate()) {
                      if (showCardFields) {
                        print('Card Number: ${cardNumberController.text}');
                        print('CCV: ${ccvController.text}');
                        print('End Date: ${endDateController.text}');
                        shippingController.fetchPayment("Credit Card");
                        shippingController.PayWith.value="Credit Card";
                        
                      } else if (showMoneyOrderField) {
                        print('Money Order: ${moneyOrderController.text}');
                         shippingController.fetchPayment("Money Order");
                         shippingController.PayWith.value="Money Order";
                      } else if (showCheckNumberField) {
                        print('Cheque Number: ${checkNumberController.text}');
                         shippingController.fetchPayment("Cheque ");
                         shippingController.PayWith.value="Cheque";
                      }
                    }
                  },
                  child: Text('Submit',style: TextStyle(color: Colors.black),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget ImageContainer(context) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.22,
    child: Image.asset("assets/card.png", fit: BoxFit.cover),
  );
}

class PaymentContainer extends StatelessWidget {
  final bool showCardFields;
  final bool showMoneyOrderField;
  final bool showCheckNumberField;
  final TextEditingController cardNumberController;
  final TextEditingController ccvController;
  final TextEditingController endDateController;
  final TextEditingController moneyOrderController;
  final TextEditingController checkNumberController;
  final ValueChanged<bool?>? onCardCheckboxChanged;
  final ValueChanged<bool?>? onMoneyOrderCheckboxChanged;
  final ValueChanged<bool?>? onCheckNumberCheckboxChanged;

  const PaymentContainer({
    required this.showCardFields,
    required this.showMoneyOrderField,
    required this.showCheckNumberField,
    required this.cardNumberController,
    required this.ccvController,
    required this.endDateController,
    required this.moneyOrderController,
    required this.checkNumberController,
    required this.onCardCheckboxChanged,
    required this.onMoneyOrderCheckboxChanged,
    required this.onCheckNumberCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      // height: 300,
      // color: Color.fromARGB(255, 120, 238, 84),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CheckboxListTile(
            title: Text('Credit Card'),
            value: showCardFields,
            onChanged: onCardCheckboxChanged,
          ),
          if (showCardFields)
            Container(
               margin: const EdgeInsets.only(left: 20,right: 20),
               padding: const EdgeInsets.only(left: 10,right: 10,bottom: 25),
               decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
               ),
              child: Column(
                children: [
                  TextFormField(
                    controller: cardNumberController,
                    decoration: InputDecoration(labelText: 'Card Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Card Number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: ccvController,
                    decoration: InputDecoration(labelText: 'CCV'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter CCV';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: endDateController,
                    decoration: InputDecoration(labelText: 'End Date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter End Date';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          CheckboxListTile(
            title: Text('Money Order'),
            value: showMoneyOrderField,
            onChanged: onMoneyOrderCheckboxChanged,
          ),
          if (showMoneyOrderField)
            Container(
               margin: const EdgeInsets.only(left: 20,right: 20),
               padding: const EdgeInsets.only(left: 10,right: 10,bottom: 25),
               decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
               ),
              child: TextFormField(
                controller: moneyOrderController,
                decoration: InputDecoration(labelText: 'Money Order'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Money Order';
                  }
                  return null;
                },
              ),
            ),
          CheckboxListTile(
            title: Text('Check Number'),
            value: showCheckNumberField,
            onChanged: onCheckNumberCheckboxChanged,
          ),
          if (showCheckNumberField)
            Container(
               margin: const EdgeInsets.only(left: 20,right: 20),
               padding: const EdgeInsets.only(left: 10,right: 10,bottom: 25),
               decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
               ),
              child: TextFormField(
                controller: checkNumberController,
                decoration: InputDecoration(labelText: 'Cheque Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Cheque Number';
                  }
                  return null;
                },
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaymentScreen(),
  ));
}
