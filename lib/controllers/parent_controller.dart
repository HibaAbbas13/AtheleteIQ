import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repo/user_repository.dart';
import '../controllers/user_controller.dart';
import '../data/enums/user_role.dart';

class ParentController extends GetxController {
  final _userRepo = UserRepository();
  final _userController = Get.find<UserController>();

  final RxBool isLoading = false.obs;
  final Rx<UserModel?> linkedAthlete = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadLinkedAthlete();
  }

  Future<void> loadLinkedAthlete() async {
    try {
      final currentUser = _userController.currentUser.value;
      if (currentUser != null && 
          currentUser.role == UserRole.parent && 
          currentUser.linkedAthleteId != null) {
        final athlete = await _userRepo.getUserById(currentUser.linkedAthleteId!);
        linkedAthlete.value = athlete;
      }
    } catch (e) {
      linkedAthlete.value = null;
    }
  }

  Future<bool> linkToAthlete(String athleteEmail) async {
    try {
      isLoading.value = true;
      final currentUser = _userController.currentUser.value;
      if (currentUser == null || currentUser.role != UserRole.parent) {
        throw Exception('User is not a parent');
      }

      final athlete = await _userRepo.getUserByEmail(athleteEmail);
      if (athlete == null) {
        Get.snackbar(
          'Error',
          'Athlete not found',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      if (athlete.role != UserRole.athlete) {
        Get.snackbar(
          'Error',
          'This email does not belong to an athlete',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      await _userRepo.linkParentToAthlete(currentUser.id, athlete.id);

      // Reload user data
      final updatedUser = await _userRepo.getUserById(currentUser.id);
      if (updatedUser != null) {
        _userController.updateUser(updatedUser);
        linkedAthlete.value = athlete;
      }

      Get.snackbar(
        'Success',
        'Successfully linked to ${athlete.name}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to link athlete: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> unlinkAthlete() async {
    try {
      isLoading.value = true;
      final currentUser = _userController.currentUser.value;
      if (currentUser == null) {
        throw Exception('User not found');
      }

      await _userRepo.unlinkParentFromAthlete(currentUser.id);

      // Reload user data
      final updatedUser = await _userRepo.getUserById(currentUser.id);
      if (updatedUser != null) {
        _userController.updateUser(updatedUser);
        linkedAthlete.value = null;
      }

      Get.snackbar(
        'Success',
        'Successfully unlinked from athlete',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to unlink athlete: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void reset() {
    isLoading.value = false;
    linkedAthlete.value = null;
  }
}

