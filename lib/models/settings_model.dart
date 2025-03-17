import 'package:get/get.dart';

class SettingsModel {
  var isDarkMode = false.obs;
  var notificationsEnabled = true.obs;
  var language = 'Türkçe'.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
  }

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
  }

  void setLanguage(String newLanguage) {
    language.value = newLanguage;
  }
}
