import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/parent.dart';
import '../services/database_service.dart';
import '../data/enums/user_role.dart';

class UserRepository {
  final DatabaseService _dbService = DatabaseService();

  CollectionReference<UserModel?> get _userCollection =>
      _dbService.userCollection;
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _userCollection.doc(userId).get();
      return doc.data();
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final querySnapshot = await _userCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isEmpty) {
        return null;
      }
      return querySnapshot.docs.first.data();
    } catch (e) {
      throw Exception('Error getting user by email: $e');
    }
  }

  Future<UserModel?> findUserByParentCredentials(
      String email, String password) async {
    try {
      final querySnapshot = await _userCollection.get();
      
      for (var doc in querySnapshot.docs) {
        final user = doc.data();
        if (user == null) continue;

        for (var parent in user.parents) {
          if (parent.email.toLowerCase() == email.toLowerCase() &&
              parent.password == password) {
            return user;
          }
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error finding user by parent credentials: $e');
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      await _userCollection.doc(user.id).set(user);
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final updatedUser = user.copyWith(
        updatedAt: DateTime.now(),
      );
      await _userCollection.doc(user.id).update(updatedUser.toMap());
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  Future<void> addParentToUser(String userId, Parent parent) async {
    try {
      final user = await getUserById(userId);
      if (user == null) {
        throw Exception('User not found');
      }

      final updatedParents = List<Parent>.from(user.parents)..add(parent);
      final updatedUser = user.copyWith(
        parents: updatedParents,
        updatedAt: DateTime.now(),
      );

      await _userCollection.doc(userId).update(updatedUser.toMap());
    } catch (e) {
      throw Exception('Error adding parent to user: $e');
    }
  }

  Future<void> removeParentFromUser(String userId, String parentEmail) async {
    try {
      final user = await getUserById(userId);
      if (user == null) {
        throw Exception('User not found');
      }

      final updatedParents = user.parents
          .where((p) => p.email.toLowerCase() != parentEmail.toLowerCase())
          .toList();
      final updatedUser = user.copyWith(
        parents: updatedParents,
        updatedAt: DateTime.now(),
      );

      await _userCollection.doc(userId).update(updatedUser.toMap());
    } catch (e) {
      throw Exception('Error removing parent from user: $e');
    }
  }

  Future<void> linkParentToAthlete(String parentId, String athleteId) async {
    try {
      final parent = await getUserById(parentId);
      if (parent == null) {
        throw Exception('Parent not found');
      }
      if (parent.role != UserRole.parent) {
        throw Exception('User is not a parent');
      }

      final athlete = await getUserById(athleteId);
      if (athlete == null) {
        throw Exception('Athlete not found');
      }
      if (athlete.role != UserRole.athlete) {
        throw Exception('User is not an athlete');
      }

      final parentExists = athlete.parents.any(
        (p) => p.email.toLowerCase() == parent.email.toLowerCase(),
      );

      final updatedParent = parent.copyWith(
        linkedAthleteId: athleteId,
        updatedAt: DateTime.now(),
      );
      await _userCollection.doc(parentId).update(updatedParent.toMap());

      if (!parentExists) {
        final parentToAdd = Parent(
          email: parent.email,
          password: parent.password ?? '',
          name: parent.name,
        );

        final updatedParents = List<Parent>.from(athlete.parents)..add(parentToAdd);
        final updatedAthlete = athlete.copyWith(
          parents: updatedParents,
          updatedAt: DateTime.now(),
        );

        await _userCollection.doc(athleteId).update(updatedAthlete.toMap());
      }
    } catch (e) {
      throw Exception('Error linking parent to athlete: $e');
    }
  }

  Future<void> unlinkParentFromAthlete(String parentId) async {
    try {
      final parent = await getUserById(parentId);
      if (parent == null) {
        throw Exception('Parent not found');
      }

      final updatedParent = parent.copyWith(
        linkedAthleteId: null,
        updatedAt: DateTime.now(),
      );
      await _userCollection.doc(parentId).update(updatedParent.toMap());

      if (parent.linkedAthleteId != null) {
        final athlete = await getUserById(parent.linkedAthleteId!);
        if (athlete != null) {
          final updatedParents = athlete.parents
              .where((p) => p.email.toLowerCase() != parent.email.toLowerCase())
              .toList();
          
          final updatedAthlete = athlete.copyWith(
            parents: updatedParents,
            updatedAt: DateTime.now(),
          );

          await _userCollection.doc(parent.linkedAthleteId!).update(updatedAthlete.toMap());
        }
      }
    } catch (e) {
      throw Exception('Error unlinking parent from athlete: $e');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _userCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data())
          .whereType<UserModel>()
          .toList();
    } catch (e) {
      throw Exception('Error getting all users: $e');
    }
  }
}

