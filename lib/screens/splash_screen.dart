import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notekeep/helpers/auth_helper.dart';
import 'package:notekeep/screens/home_screen.dart';
import 'package:notekeep/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  @override
  void initState() {
    getUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void getUserStatus() async {
    isLoggedIn = await AuthHelper.instance.isLoggedIn();
    if (isLoggedIn) {
      Get.to(() => const HomeScreen());
    } else {
      Get.to(() => const LoginScreen());
    }
  }
}
