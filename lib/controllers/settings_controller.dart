import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/settings_model.dart';

class SettingsController extends GetxController {
  final SettingsModel settingsModel = SettingsModel();

  void toggleDarkMode() {
    settingsModel.toggleDarkMode();
    Get.changeThemeMode(
        settingsModel.isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications() {
    settingsModel.toggleNotifications();
  }

  void setLanguage(String language) {
    settingsModel.setLanguage(language);
  }
}
