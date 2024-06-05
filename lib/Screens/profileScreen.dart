import 'dart:io';
import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:demo_project/GetX%20Controller/myorderController.dart';
import 'package:demo_project/GetX%20Controller/navigationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LoginController loginController = Get.put(LoginController());
  final NavigationController navigationController = Get.put(NavigationController());
  final MyOrderController myOrderController = Get.put(MyOrderController());
  File? _selectedImage;
  String? userName;
  String? email;

  Future<void> _pickedImage() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      setState(() {
        _selectedImage = File(returnImage.path);
      });
    }
  }

  void getData() {
    final user = loginController.loginList.first;
    setState(() {
      userName = user['user_name'];
      email = user['email'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              myOrderController.getMyOrder(loginController.userId);
            },
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : const NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png") as ImageProvider,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: _pickedImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "UserName: ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userName ?? '',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email: ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email ?? '',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.38,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.black12),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/loginscreen');
                  navigationController.selectedIndex.value = 0;
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout, size: 20.0),
                    SizedBox(width: 4),
                    Text('Logout', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
