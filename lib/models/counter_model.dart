import 'package:get/get.dart';

class CounterModel {
  var count = 0.obs;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }
}
