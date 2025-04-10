import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logiology/controllers/auth/auth_controller.dart';
import 'package:logiology/core/constants.dart';

class ImageSelectorSheet extends StatelessWidget {
  const ImageSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return SafeArea(
      child: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Image',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                )
              ],
            ),
            kHeight10,
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  label: Text("Camera"),
                  onPressed: () {
                    authCtrl.pickImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_enhance_rounded),
                ),

                TextButton.icon(
                  label: Text("Gallery"),
                  onPressed: () {
                    authCtrl.pickImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
