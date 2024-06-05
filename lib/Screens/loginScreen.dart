import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:demo_project/Screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
final LoginController logincontroller=Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;

void _saveForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      logincontroller.fetchLogin(username, password, context);
     
      // fetchdata(context);
      // loginController.fetchLogin(username, password, context);
      // feature.fetchProduct(productName);
      // print("$username - $password");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.92,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Adjusted mainAxisSize
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.19,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Image.asset(
                        'assets/TexasImage.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue:'dev@desss.com' ,
                            onSaved: (value) {
                              setState(() {
                                username = value;
                              });
                            },
                            decoration:
                                const InputDecoration(hintText: "Username"),
                            validator: (value) {
                              String pattern =
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                              RegExp regExp = RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return "please enter Email";
                              } else if (!regExp.hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            initialValue: '\$heshU98',
                            onSaved: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.length < 5) {
                                return "Enter a valid password";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "Password"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: TextButton(
                        onPressed: () {
                          _saveForm(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    const Text("Don't have an account"),
                    TextButton(
                      onPressed: () {
                      Get.to(()=>RegisterScreen());
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const RegisterScreen()));
                      },
                      child: const Text("Sign Up"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  }
