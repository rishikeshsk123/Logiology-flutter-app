import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/controllers/auth/auth_controller.dart';
import 'package:logiology/view/auth/screen_login.dart';
import 'package:logiology/view/main_pages/screen_main_page.dart';

class ScreenSplash extends StatelessWidget {
  ScreenSplash({super.key});


  @override
  Widget build(BuildContext context) {
  final AuthController authController = Get.find();

  Future.delayed(const Duration(seconds: 1),(){
    if(authController.isAuthenticated()){
      Get.offAll(()=> ScreenMainPage());
    } else {
      Get.offAll(()=> ScreenLogin());
    }
  });
    return Scaffold(
      body: Center(
        child: const CircularProgressIndicator()
      ),
    );
  }
}