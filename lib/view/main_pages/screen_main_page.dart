import 'package:flutter/material.dart';
import 'package:logiology/view/home/screen_home.dart';
import 'package:logiology/view/main_pages/widgets/bottom_navigation_widget.dart';
import 'package:logiology/view/profile/screen_profile.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});

  final _pages = [
    const ScreenHome(),
    ScreenProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int index, _) {
          return _pages[index];
        },
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
