import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logiology/controllers/auth/auth_controller.dart';
import 'package:logiology/core/colors.dart';
import 'package:logiology/core/constants.dart';
import 'package:logiology/view/auth/screen_splash.dart';
import 'package:logiology/view/main_pages/screen_main_page.dart';
import 'package:logiology/view/profile/widgets/profile_image_widget.dart';

class ScreenProfile extends StatelessWidget {
  ScreenProfile({super.key});
final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPurpleColor,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontSize: 26,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileImageWidget(),
                ),
                kHeight20,
                Text(
                  "UserName",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kHeight20,
                Text(
                  "Change Username and Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                kHeight10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: kPurpleBgColor,
                      ),
                      labelText: "Username",
                    ),
                  ),
                ),

                kHeight20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: kPurpleBgColor,
                      ),
                      labelText: "Password",
                    ),
                    obscureText: true,
                  ),
                ),

                kHeight30,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                    width: double.infinity,
                    
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                         authController.updateUser(
                              nameController.text.trim(),
                              passwordController.text.trim(),
                              );

                          
                            Get.offAll(() =>  ScreenMainPage());
                          
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: kPurpleColor,
                        ),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                              color: kWhiteColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,),
                        )),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(
            onPressed: () {
              authController.logout();
              Get.offAll(() => ScreenSplash());
              //
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 22),
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(
                  color: kBlackColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}

