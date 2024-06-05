import 'dart:io';
import 'dart:typed_data';
import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:demo_project/GetX%20Controller/myorderController.dart';
import 'package:demo_project/GetX%20Controller/navigationcontroller.dart';
import 'package:demo_project/Screens/myOrders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
final LoginController loginController=Get.put(LoginController());
final NavigationController navigationController=Get.put(NavigationController());
final MyOrderController myOrderController=Get.put(MyOrderController());
File? _selectedImage;
  String? userName;
  String? email;

void _pickedImage() async {
  final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (returnImage != null) {
    setState(() {
      _selectedImage = File(returnImage.path);
    });
    print("Image Not Picked");
  }
}

  void getData() {
    for (var obj in loginController.loginList) {
      setState(() {
        userName = obj['user_name'];
        email=obj['email'];
      });
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.receipt_long),
            onPressed: () {
               myOrderController.getMyOrder(loginController.userId);
              // Get.to(()=>MyOrders() );
              print('Settings icon pressed');
            },
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.1,
            ),

            Center(
    child: Stack(
      children: [
        _selectedImage!=null ?
        CircleAvatar(
        radius: 64,
          backgroundImage:FileImage(_selectedImage!),
        ):
        CircleAvatar(
          radius: 64,
          backgroundImage: const NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
        ),
        Positioned(
          child: IconButton(
            onPressed: (){_pickedImage();},
            icon: const Icon(Icons.add_a_photo),
          ),
          right: 0,
          bottom: 0,
        ),
        
      ],
    ),
  ),

  SizedBox(
          height: MediaQuery.of(context).size.height*0.07,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("UserName   :  ",style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.025,fontWeight: FontWeight.bold),),
            Text("${userName}",style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.02))
          ],
        ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Email   :  ",style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.025,fontWeight: FontWeight.bold)),
            Text("${email}",style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.02))
          ],
        ),
        SizedBox(
           height: MediaQuery.of(context).size.height*0.07,
        ),
         SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.38,
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
            ),
            onPressed: () {
               Navigator.pushReplacementNamed(context, '/loginscreen');
               navigationController.selectedIndex.value=0;
            },
            // Update starts here
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // To keep the icon and text close together
              children: [
                Icon(Icons.logout, size: 20.0), // Adjust the size as needed
                SizedBox(width: 4), // Space between icon and text
                Text(
                  'Logout',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // Update ends here
          ),
        ),


          ],
        ),
      ),
    );
  }
}

