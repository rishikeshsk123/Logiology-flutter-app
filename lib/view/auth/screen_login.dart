import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logiology/controllers/auth/auth_controller.dart';
import 'package:logiology/core/colors.dart';
import 'package:logiology/core/constants.dart';
import 'package:logiology/view/main_pages/screen_main_page.dart';

class ScreenLogin extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authController = Get.find<AuthController>();

  ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const CustomLogoImage(),

                  Text(
                    "Welcome!",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "to Logiology",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      color: kPurpleColor,
                    ),
                  ),

                  kHeight20,

                  // Email field
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: kPurpleBgColor,
                      ),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty ? "Enter email" : null,
                  ),

                  kHeight20,

                  // Password field
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: kPurpleBgColor,
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value!.length < 6 ? "Password too short" : null,
                  ),

                  kHeight20,

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          authController.login(emailController.text.trim(),
                              passwordController.text.trim());

                          Get.offAll(() => ScreenMainPage());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: kPurpleColor,
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                              color: kWhiteColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
