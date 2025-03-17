import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxapp/controllers/home_controller.dart';
import 'counter_view.dart';
import 'profile_view.dart';
import 'settings_view.dart';
import 'image_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: const [
            CounterView(),
            ImageView(),
            ProfileView(),
            SettingsView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Sayaç',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Resimler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ayarlar',
            ),
          ],
        ),
      ),
    );
  }
}
