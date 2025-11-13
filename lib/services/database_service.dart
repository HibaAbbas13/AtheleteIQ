import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;
  String get uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<UserModel?> get userCollection => _firestore
      .collection('users')
      .withConverter(
        fromFirestore: (snapshot, options) {
          return snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null;
        },
        toFirestore: (object, options) {
          return object!.toMap();
        },
      );
}