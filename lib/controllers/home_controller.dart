import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0;

  void changePage(int index) {
    selectedIndex = index;
    update();
  }
}
