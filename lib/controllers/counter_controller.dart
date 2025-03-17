import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;
  var currentIndex = 0.obs;

  void increment() => count.value++;
  void decrement() => count.value--;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
