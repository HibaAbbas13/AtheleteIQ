import 'package:athleteiq/services/controller_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:athleteiq/services/database_service.dart';
import 'package:athleteiq/controllers/auth_controller.dart';
import 'package:athleteiq/controllers/user_controller.dart';
import '../repo/user_repository.dart';
import '../models/user_model.dart';
import '../models/parent.dart';
import '../data/enums/user_role.dart';
import '../utils/app_utils.dart';
import '../services/shared_preference.dart';

class AuthService {
  final db = DatabaseService();
  final _auth = FirebaseAuth.instance;
  final _userRepo = UserRepository();

  AuthController get controller => Get.find<AuthController>();
  UserController get userController => Get.find<UserController>();

  
  Future<AuthResult> signInWithEmailAndPassword(
      String email, String password) async {
    print('[AuthService] signInWithEmailAndPassword called for: $email');
    try {
      try {
        print('[AuthService] Attempting Firebase Auth sign in...');
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        print('[AuthService] Firebase Auth sign in successful');
        
        print('[AuthService] Fetching user model from database...');
        final userModel = await _userRepo.getUserByEmail(email);
        if (userModel == null) {
          print('[AuthService] ERROR: User data not found in database');
          return AuthResult.error('User data not found in database. Please contact support.');
        }
        
        print('[AuthService] User found: ${userModel.name}, Role: ${userModel.role}');
        
        // If user is a parent, verify they have a linked athlete
        if (userModel.role == UserRole.parent) {
          print('[AuthService] User is a parent, checking linked athlete...');
          // Verify the parent has a linked athlete
          if (userModel.linkedAthleteId != null) {
            print('[AuthService] Parent has linkedAthleteId: ${userModel.linkedAthleteId}');
            try {
              final athlete = await _userRepo.getUserById(userModel.linkedAthleteId!);
              if (athlete != null) {
                print('[AuthService] Linked athlete found: ${athlete.name}');
                print('[AuthService] Checking parent credentials in athlete\'s parents list...');
                print('[AuthService] Athlete has ${athlete.parents.length} parents in list');
                
                // Verify parent credentials exist in the linked athlete's parents list
                final parentExists = athlete.parents.any(
                  (p) {
                    final emailMatch = p.email.toLowerCase().trim() == email.toLowerCase().trim();
                    final passwordMatch = p.password.trim() == password.trim();
                    print('[AuthService] Checking parent: ${p.email} - Email match: $emailMatch, Password match: $passwordMatch');
                    return emailMatch && passwordMatch;
                  },
                );
                
                if (parentExists) {
                  print('[AuthService] Parent credentials verified in athlete\'s list! Setting parent login...');
                  // Parent is linked and credentials match - allow login
                  userController.updateUser(athlete);
                  controller.setParentLogin(athlete);
                  print('[AuthService] Parent login successful, returning success');
                  return AuthResult.success(athlete, isParentLogin: true);
                } else {
                  // Parent has valid linkedAthleteId and athlete exists, but credentials not in list
                  // This is a data inconsistency - allow login but log warning
                  // Also try to add parent to athlete's list if not already there
                  print('[AuthService] WARNING: Parent credentials not in athlete\'s list, but parent has valid linkedAthleteId');
                  print('[AuthService] Allowing login due to valid link. Attempting to sync parent to athlete\'s list...');
                  
                  try {
                    // Check if parent email exists in list (even if password doesn't match)
                    final parentEmailExists = athlete.parents.any(
                      (p) => p.email.toLowerCase().trim() == email.toLowerCase().trim(),
                    );
                    
                    if (!parentEmailExists) {
                      // Add parent to athlete's parents list to fix data inconsistency
                      final parentToAdd = Parent(
                        email: email,
                        password: password,
                        name: userModel.name,
                      );
                      await _userRepo.addParentToUser(athlete.id, parentToAdd);
                      print('[AuthService] Added parent to athlete\'s parents list to fix data inconsistency');
                    } else {
                      // Parent email exists but password doesn't match - update password
                      print('[AuthService] Parent email exists but password mismatch - updating password in list');
                      // Remove old parent entry and add new one with correct password
                      await _userRepo.removeParentFromUser(athlete.id, email);
                      final parentToAdd = Parent(
                        email: email,
                        password: password,
                        name: userModel.name,
                      );
                      await _userRepo.addParentToUser(athlete.id, parentToAdd);
                      print('[AuthService] Updated parent password in athlete\'s list');
                    }
                  } catch (syncError) {
                    print('[AuthService] WARNING: Could not sync parent to athlete\'s list: $syncError');
                    // Continue with login anyway since parent has valid linkedAthleteId
                  }
                  
                  // Allow login since parent has valid linkedAthleteId
                  userController.updateUser(athlete);
                  controller.setParentLogin(athlete);
                  print('[AuthService] Parent login successful (using linkedAthleteId), returning success');
                  return AuthResult.success(athlete, isParentLogin: true);
                }
              } else {
                print('[AuthService] ERROR: Linked athlete not found');
                // Athlete was unlinked - parent has no profile linked
                await _auth.signOut();
                return AuthResult.error('No profile linked. Please contact your athlete to link your account.');
              }
            } catch (e) {
              print('[AuthService] ERROR loading athlete: $e');
              // Error loading athlete
              await _auth.signOut();
              return AuthResult.error('Unable to load athlete profile. Please contact support.');
            }
          } else {
            print('[AuthService] ERROR: Parent has no linkedAthleteId');
            // Parent has no linked athlete
            await _auth.signOut();
            return AuthResult.error('No profile linked. Please contact your athlete to link your account.');
          }
        }
        
        // User is an athlete - allow login
        print('[AuthService] User is an athlete, allowing login...');
        userController.updateUser(userModel);
        controller.clearParentLogin();
        print('[AuthService] Athlete login successful, returning success');
        return AuthResult.success(userModel, isParentLogin: false);
      } on FirebaseAuthException catch (e) {
        print('[AuthService] FirebaseAuthException: ${e.code} - ${e.message}');
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          print('[AuthService] User not found or wrong password, checking parent credentials...');
          // Try to find parent credentials in athlete's parents list
          final athleteUser =
              await _userRepo.findUserByParentCredentials(email, password);
          
          if (athleteUser != null) {
            print('[AuthService] Found parent credentials in athlete: ${athleteUser.name}');
            if (athleteUser.password == null || athleteUser.password!.isEmpty) {
              print('[AuthService] ERROR: Athlete account has no password');
              return AuthResult.error(
                  'Athlete account not properly configured. Please contact support.');
            }

            try {
              print('[AuthService] Attempting to sign in as athlete...');
              // Sign in as the athlete using their credentials
              await _auth.signInWithEmailAndPassword(
                  email: athleteUser.email, password: athleteUser.password!);
              
              print('[AuthService] Successfully signed in as athlete');
              userController.updateUser(athleteUser);
              controller.setParentLogin(athleteUser);
              
              print('[AuthService] Parent login via athlete credentials successful');
              return AuthResult.success(athleteUser, isParentLogin: true);
            } catch (authError) {
              print('[AuthService] ERROR signing in as athlete: $authError');
              return AuthResult.error(
                  'Unable to authenticate. Please contact support.');
            }
          } else {
            print('[AuthService] ERROR: Parent credentials not found in any athlete\'s parents list');
            // Credentials not found in any athlete's parents list
            return AuthResult.error('Invalid credentials. Parents can only login with credentials provided by their athlete.');
          }
        }
        
        print('[AuthService] Returning error: ${AppUtils.getAuthErrorMessage(e.code)}');
        return AuthResult.error(AppUtils.getAuthErrorMessage(e.code));
      }
    } catch (e) {
      print('[AuthService] Unexpected error: $e');
      return AuthResult.error('An error occurred: ${e.toString()}');
    }
  }

  Future<AuthResult> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user == null) {
        return AuthResult.error('Failed to create user account');
      }

      final selectedRoleString = await SharedPreferencesService.getUserRole();
      
      // Only athletes can sign up - parents are created by athletes
      if (selectedRoleString.isEmpty || selectedRoleString.toLowerCase().trim() != 'athlete') {
        // Delete the Firebase Auth user if created
        try {
          await userCredential.user!.delete();
        } catch (_) {
          // Ignore deletion errors
        }
        return AuthResult.error('Only athletes can create accounts. Parents must use credentials provided by their athlete.');
      }
      
      UserRole userRole = UserRole.athlete;
      
      final userModel = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        password: password,
        role: userRole,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        parents: [],
        linkedAthleteId: null,
      );
  
      try {
        await _userRepo.createUser(userModel);
      } catch (firestoreError) {
        try {
          await userCredential.user!.delete();
        } catch (_) {
        }
        return AuthResult.error(
            'Failed to save user data: ${firestoreError.toString()}');
      }

      await SharedPreferencesService.setUserRole(selectedRoleString.isNotEmpty 
          ? selectedRoleString 
          : 'athlete');
      userController.updateUser(userModel);
      controller.clearParentLogin();

      return AuthResult.success(userModel, isParentLogin: false);
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(AppUtils.getAuthErrorMessage(e.code));
    } catch (e) {
      return AuthResult.error('An error occurred: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    ControllerManager().resetControllers();
    userController.clearUser();
    await controller.logout();
    await SharedPreferencesService.clearAll();
    ControllerManager().unregisterControllers();
  }

}

class AuthResult {
  final bool success;
  final UserModel? user;
  final String? error;
  final bool isParentLogin;

  AuthResult.success(this.user, {this.isParentLogin = false})
      : success = true,
        error = null;

  AuthResult.error(this.error)
      : success = false,
        user = null,
        isParentLogin = false;
}
