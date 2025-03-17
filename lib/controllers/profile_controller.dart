import 'package:get/get.dart';
import '../models/profile_model.dart';

class ProfileController extends GetxController {
  final ProfileModel profileModel = ProfileModel();

  void updateProfile(String name, String email, String bio) {
    profileModel.updateProfile(name, email, bio);
  }
}
