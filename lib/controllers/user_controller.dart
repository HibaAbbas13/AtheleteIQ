import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repo/user_repository.dart';
import '../controllers/auth_controller.dart';
import '../data/enums/user_role.dart';

class UserController extends GetxController {
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final _userRepo = UserRepository();
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    // Load data if user is already authenticated
    final currentFirebaseUser = _auth.currentUser;
    if (currentFirebaseUser != null && currentUser.value == null) {
      loadUserData(currentFirebaseUser.uid);
    }
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _auth.authStateChanges().listen((User? firebaseUser) {
      print('[UserController] Auth state changed - Firebase user: ${firebaseUser?.email ?? "null"}');
      if (firebaseUser != null) {
        // Only load if current user is null or different user
        if (currentUser.value == null || currentUser.value?.id != firebaseUser.uid) {
          print('[UserController] Loading user data for: ${firebaseUser.uid}');
          loadUserData(firebaseUser.uid);
        } else {
          print('[UserController] User already loaded, skipping...');
        }
      } else if (firebaseUser == null) {
        print('[UserController] Firebase user is null, clearing user data');
        clearUser();
      }
    });
  }

  Future<void> loadUserData(String userId) async {
    print('[UserController] loadUserData called for userId: $userId');
    try {
      final user = await _userRepo.getUserById(userId);
      if (user != null) {
        print('[UserController] User data loaded: ${user.name}, Role: ${user.role}');
        updateUser(user);
        
        // If parent with linked athlete, load athlete data
        if (user.role == UserRole.parent && user.linkedAthleteId != null) {
          print('[UserController] Parent has linkedAthleteId: ${user.linkedAthleteId}, loading athlete data...');
          final athlete = await _userRepo.getUserById(user.linkedAthleteId!);
          if (athlete != null) {
            print('[UserController] Athlete data loaded: ${athlete.name}');
            final authController = Get.find<AuthController>();
            updateUser(athlete);
            authController.setParentLogin(athlete);
            print('[UserController] Parent login state set');
          } else {
            print('[UserController] ERROR: Linked athlete not found');
          }
        }
      } else {
        print('[UserController] ERROR: User data not found for userId: $userId');
      }
    } catch (e) {
      print('[UserController] ERROR loading user data: $e');
    }
  }

  void updateUser(UserModel user) {
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

