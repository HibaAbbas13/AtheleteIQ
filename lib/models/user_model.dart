import '../data/enums/user_role.dart';
import '../data/enums/sports_type.dart';
import 'parent.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? password; // Stored for parent login purposes
  final UserRole role;
  final SportType? sport;
  final String? profilePhotoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Parent> parents;
  final String? linkedAthleteId; // For parents: ID of the athlete they're linked to

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.role,
    this.sport,
    this.profilePhotoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.parents,
    this.linkedAthleteId,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      role: UserRole.values[map['role']],
      sport: map['sport'] != null ? SportType.values[map['sport']] : null,
      profilePhotoUrl: map['profilePhotoUrl'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      parents: (map['parents'] as List<dynamic>?)
          ?.map((p) => Parent.fromMap(p as Map<String, dynamic>))
          .toList() ??
          [],
      linkedAthleteId: map['linkedAthleteId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role.index,
      'sport': sport?.index,
      'profilePhotoUrl': profilePhotoUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'parents': parents.map((p) => p.toMap()).toList(),
      'linkedAthleteId': linkedAthleteId,
      };
  }   

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: UserRole.values[json['role']],
      sport: json['sport'] != null ? SportType.values[json['sport']] : null,
        profilePhotoUrl: json['profilePhotoUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      parents: (json['parents'] as List<dynamic>?)
          ?.map((p) => Parent.fromJson(p as Map<String, dynamic>))
          .toList() ??
          [],
      linkedAthleteId: json['linkedAthleteId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role.index,
      'sport': sport?.index,
      'profilePhotoUrl': profilePhotoUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'parents': parents.map((p) => p.toJson()).toList(),
      'linkedAthleteId': linkedAthleteId,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    UserRole? role,
    SportType? sport,
    String? profilePhotoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Parent>? parents,
    String? linkedAthleteId,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      sport: sport ?? this.sport,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      parents: parents ?? this.parents,
      linkedAthleteId: linkedAthleteId ?? this.linkedAthleteId,
    );
  }
}

