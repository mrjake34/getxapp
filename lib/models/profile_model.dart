import 'package:get/get.dart';

class ProfileModel {
  var name = 'Kullanıcı'.obs;
  var email = 'kullanici@email.com'.obs;
  var bio = 'Flutter ve GetX ile geliştirici'.obs;

  void updateProfile(String newName, String newEmail, String newBio) {
    name.value = newName;
    email.value = newEmail;
    bio.value = newBio;
  }
}
