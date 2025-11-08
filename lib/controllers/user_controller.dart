import 'package:get/get.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    // TODO: Load user data from storage or APIß
    userName.value = '';
    userEmail.value = '';
  }

  void updateUser(User user) {
    currentUser.value = user;
    userName.value = user.name;
    userEmail.value = user.email;
  }

  void clearUser() {
    currentUser.value = null;
    userName.value = '';
    userEmail.value = '';
  }
}

