import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/counter_controller.dart';
import 'controllers/image_controller.dart';
import 'controllers/snake_game_controller.dart';
import 'views/counter_view.dart';
import 'views/image_view.dart';
import 'views/snake_game_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainView(),
      initialBinding: BindingsBuilder(() {
        Get.put(CounterController());
        Get.put(ImageController());
        Get.put(SnakeGameController());
      }),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final currentIndex = Get.find<CounterController>().currentIndex.value;
        switch (currentIndex) {
          case 0:
            return const CounterView();
          case 1:
            return const ImageView();
          case 2:
            return const SnakeGameView();
          default:
            return const CounterView();
        }
      }),
      bottomNavigationBar: Obx(() {
        final controller = Get.find<CounterController>();
        return NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changePage,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.numbers),
              label: 'Sayaç',
            ),
            NavigationDestination(
              icon: Icon(Icons.image),
              label: 'Resimler',
            ),
            NavigationDestination(
              icon: Icon(Icons.games),
              label: 'Yılan Oyunu',
            ),
          ],
        );
      }),
    );
  }
}
