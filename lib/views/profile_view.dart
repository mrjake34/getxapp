import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
                  'İsim: ${controller.profileModel.name}',
                  style: const TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'E-posta: ${controller.profileModel.email}',
                  style: const TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'Bio: ${controller.profileModel.bio}',
                  style: const TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateProfile(
                  'Yeni İsim',
                  'yeni@email.com',
                  'Yeni bio metni',
                );
              },
              child: const Text('Profili Güncelle'),
            ),
          ],
        ),
      ),
    );
  }
}
