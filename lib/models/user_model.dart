enum UserRole { athlete, parent, admin }

enum SportType {
  football,
  basketball,
  baseball,
  soccer,
  tennis,
  track,
  volleyball,
  other,
}

enum Position {
  // Football positions
  qb,
  rb,
  wr,
  te,
  ol,
  dl,
  lb,
  cb,
  s,
  // Basketball positions
  pg,
  sg,
  sf,
  pf,
  c,
  // Baseball positions
  pitcher,
  catcher,
  infield,
  outfield,
  // Other
  athlete,
}

enum Tier { bronze, silver, gold, platinum }

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

class Evaluation {
  final String id;
  final String userId;
  final String videoUrl;
  final int aiScore;
  final String feedback;
  final String? suggestedDrill;
  final String? drillUrl;
  final int tokensEarned;
  final DateTime createdAt;
  final Map<String, dynamic> aiAnalysis; // Raw AI analysis data

  Evaluation({
    required this.id,
    required this.userId,
    required this.videoUrl,
    required this.aiScore,
    required this.feedback,
    this.suggestedDrill,
    this.drillUrl,
    required this.tokensEarned,
    required this.createdAt,
    required this.aiAnalysis,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['id'],
      userId: json['userId'],
      videoUrl: json['videoUrl'],
      aiScore: json['aiScore'],
      feedback: json['feedback'],
      suggestedDrill: json['suggestedDrill'],
      drillUrl: json['drillUrl'],
      tokensEarned: json['tokensEarned'],
      createdAt: DateTime.parse(json['createdAt']),
      aiAnalysis: json['aiAnalysis'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'videoUrl': videoUrl,
      'aiScore': aiScore,
      'feedback': feedback,
      'suggestedDrill': suggestedDrill,
      'drillUrl': drillUrl,
      'tokensEarned': tokensEarned,
      'createdAt': createdAt.toIso8601String(),
      'aiAnalysis': aiAnalysis,
    };
  }
}

class LeaderboardEntry {
  final String userId;
  final String name;
  final String? profilePhotoUrl;
  final int rank;
  final int aiScore;
  final Tier tier;
  final SportType? sport;
  final Position? position;
  final int tokens;

  LeaderboardEntry({
    required this.userId,
    required this.name,
    this.profilePhotoUrl,
    required this.rank,
    required this.aiScore,
    required this.tier,
    this.sport,
    this.position,
    required this.tokens,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['userId'],
      name: json['name'],
      profilePhotoUrl: json['profilePhotoUrl'],
      rank: json['rank'],
      aiScore: json['aiScore'],
      tier: Tier.values[json['tier'] ?? 0],
      sport: json['sport'] != null ? SportType.values[json['sport']] : null,
      position: json['position'] != null
          ? Position.values[json['position']]
          : null,
      tokens: json['tokens'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'profilePhotoUrl': profilePhotoUrl,
      'rank': rank,
      'aiScore': aiScore,
      'tier': tier.index,
      'sport': sport?.index,
      'position': position?.index,
      'tokens': tokens,
    };
  }
}

class DrillSuggestion {
  final String id;
  final String title;
  final String description;
  final String category;
  final String difficulty; // 'beginner', 'intermediate', 'advanced'
  final int estimatedTime; // in minutes
  final String? videoUrl;
  final String? imageUrl;
  final List<String> tags;

  DrillSuggestion({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.estimatedTime,
    this.videoUrl,
    this.imageUrl,
    required this.tags,
  });

  factory DrillSuggestion.fromJson(Map<String, dynamic> json) {
    return DrillSuggestion(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      difficulty: json['difficulty'],
      estimatedTime: json['estimatedTime'],
      videoUrl: json['videoUrl'],
      imageUrl: json['imageUrl'],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'estimatedTime': estimatedTime,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl,
      'tags': tags,
    };
  }
}

class TokenTransaction {
  final String id;
  final String userId;
  final String type; // 'earned', 'spent', 'bonus'
  final String description;
  final int amount;
  final DateTime createdAt;
  final String? relatedEvaluationId;

  TokenTransaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.description,
    required this.amount,
    required this.createdAt,
    this.relatedEvaluationId,
  });

  factory TokenTransaction.fromJson(Map<String, dynamic> json) {
    return TokenTransaction(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      description: json['description'],
      amount: json['amount'],
      createdAt: DateTime.parse(json['createdAt']),
      relatedEvaluationId: json['relatedEvaluationId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'description': description,
      'amount': amount,
      'createdAt': createdAt.toIso8601String(),
      'relatedEvaluationId': relatedEvaluationId,
    };
  }
}
