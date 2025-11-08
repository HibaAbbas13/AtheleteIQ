import '../data/enums/user_role.dart';
import '../data/enums/sports_type.dart';
import '../data/enums/positions.dart';
import '../data/enums/tier.dart';
import 'evaluation.dart';

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final SportType? sport;
  final Position? position;
  final int? height; // in inches
  final int? weight; // in pounds
  final double? gpa;
  final String? profilePhotoUrl;
  final int aiScore;
  final int tokens;
  final Tier tier;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> filmLinks;
  final List<Evaluation> evaluations;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.sport,
    this.position,
    this.height,
    this.weight,
    this.gpa,
    this.profilePhotoUrl,
    required this.aiScore,
    required this.tokens,
    required this.tier,
    required this.createdAt,
    required this.updatedAt,
    required this.filmLinks,
    required this.evaluations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: UserRole.values[json['role']],
      sport: json['sport'] != null ? SportType.values[json['sport']] : null,
      position: json['position'] != null
          ? Position.values[json['position']]
          : null,
      height: json['height'],
      weight: json['weight'],
      gpa: json['gpa']?.toDouble(),
      profilePhotoUrl: json['profilePhotoUrl'],
      aiScore: json['aiScore'] ?? 0,
      tokens: json['tokens'] ?? 0,
      tier: Tier.values[json['tier'] ?? 0],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      filmLinks: List<String>.from(json['filmLinks'] ?? []),
      evaluations:
          (json['evaluations'] as List<dynamic>?)
              ?.map((e) => Evaluation.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.index,
      'sport': sport?.index,
      'position': position?.index,
      'height': height,
      'weight': weight,
      'gpa': gpa,
      'profilePhotoUrl': profilePhotoUrl,
      'aiScore': aiScore,
      'tokens': tokens,
      'tier': tier.index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'filmLinks': filmLinks,
      'evaluations': evaluations.map((e) => e.toJson()).toList(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    SportType? sport,
    Position? position,
    int? height,
    int? weight,
    double? gpa,
    String? profilePhotoUrl,
    int? aiScore,
    int? tokens,
    Tier? tier,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? filmLinks,
    List<Evaluation>? evaluations,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      sport: sport ?? this.sport,
      position: position ?? this.position,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gpa: gpa ?? this.gpa,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      aiScore: aiScore ?? this.aiScore,
      tokens: tokens ?? this.tokens,
      tier: tier ?? this.tier,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      filmLinks: filmLinks ?? this.filmLinks,
      evaluations: evaluations ?? this.evaluations,
    );
  }
}

