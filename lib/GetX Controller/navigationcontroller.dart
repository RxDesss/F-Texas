import 'package:demo_project/Screens/cartScreen.dart';
import 'package:demo_project/Screens/homeScreen.dart';
import 'package:demo_project/Screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';


class NavigationController extends GetxController{
  final Rx<int> selectedIndex=0.obs;
  final screens=[
    HomeScreen(),
    CartScreeen(),
    ProfileScreen()
  ];
}