import 'package:demo_project/GetX%20Controller/registerController.dart';
import 'package:demo_project/Screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registercontroller=Get.put(RegisterController());
  final formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Regular expression for email validation
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateReEnterPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _submitForm() {
    if (formkey.currentState != null && formkey.currentState!.validate()) {
        registercontroller.fetchRegister(_nameController.text, _emailController.text, _passwordController, context);
      // Validation passed, perform login or any other action here
      // String name = _nameController.text;
      // String password = _passwordController.text;
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => const Login()));
      print(
          'Register sucessfull Name:${_nameController.text}, Email: ${_emailController.text}, Password: ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          // backgroundColor: const Color.fromARGB(255, 233, 212, 137),
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    // height: 50.0,
                  ),
                  Image.asset(
                    "assets/TexasImage.png",
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Name',
                          hintText: 'Enter Name'),
                      validator: _validateName,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter email'),
                      validator: _validateEmail,
                    ),
                  ),
               SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter password'),
                      validator: _validatePassword,
                    ),
                  ),
             SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Re-enter Password',
                          hintText: 'Enter re-enter password'),
                      validator: _validateReEnterPassword,
                    ),
                  ),
                SizedBox(
             height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.height * 0.30,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          textStyle:  TextStyle(
                            fontSize:MediaQuery.of(context).size.height * 0.025,
                          
                          ),
                          // backgroundColor: Color.fromARGB(255, 82, 240, 51)
                        ),
                        onPressed: _submitForm,
                        child: const Text('REGISTER',style: TextStyle(  color: Colors.white),),
                      )),
                 SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Text("Already I have an account"),
               SizedBox(
                   height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => LoginScreen());
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const LoginScreen()));
                      },
                      child: const Text('Login'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
