import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/controllers/auth/auth_controller.dart';
import 'package:logiology/view/profile/widgets/image_selector_sheet.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Stack(
      children: [
        Obx(() => authCtrl.profileImagePath.value.isNotEmpty
            ? CircleAvatar(
                radius: 60,
                backgroundImage:
                    FileImage(File(authCtrl.profileImagePath.value)),
              )
            : CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/blank_profile.png'),
              )),
        Positioned(
          bottom: 0,
          right: 4,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const ImageSelectorSheet(),
              );
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Icon(Icons.camera_alt, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
