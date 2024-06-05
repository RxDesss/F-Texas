import 'package:demo_project/GetX%20Controller/navigationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabNavigation extends StatelessWidget {
  const TabNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController=Get.put(NavigationController());
    return Scaffold(
       bottomNavigationBar: Obx(
      
       ()=> NavigationBar(
        height: MediaQuery.of(context).size.height * 0.08,
        elevation:0,
        selectedIndex: navigationController.selectedIndex.value,
        backgroundColor:Colors.blue,
        onDestinationSelected: (index)=>{navigationController.selectedIndex.value=index},
        destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "HOME"),
        NavigationDestination(icon: Icon(Icons.trolley), label: "CART"),
        NavigationDestination(icon: Icon(Icons.person), label: "PROFILE"),
        ],
        ),
     ),
     body: Obx(()=> navigationController.screens[navigationController.selectedIndex.value]),
    );
  }
}