import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: ListView(
        children: [
          Obx(() => SwitchListTile(
                title: const Text('Karanlık Mod'),
                value: controller.settingsModel.isDarkMode.value,
                onChanged: (value) => controller.toggleDarkMode(),
              )),
          Obx(() => SwitchListTile(
                title: const Text('Bildirimler'),
                value: controller.settingsModel.notificationsEnabled.value,
                onChanged: (value) => controller.toggleNotifications(),
              )),
          ListTile(
            title: const Text('Dil'),
            subtitle: Obx(() => Text(controller.settingsModel.language.value)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.bottomSheet(
                Container(
                  color: Get.isDarkMode ? Colors.grey[800] : Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Get.isDarkMode
                                  ? Colors.grey[700]!
                                  : Colors.grey[300]!,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dil Seçimi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Get.back(),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Türkçe',
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        onTap: () {
                          controller.setLanguage('Türkçe');
                          Get.back();
                        },
                      ),
                      ListTile(
                        title: Text(
                          'English',
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        onTap: () {
                          controller.setLanguage('English');
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
