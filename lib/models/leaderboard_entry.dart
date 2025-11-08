import '../data/enums/sports_type.dart';
import '../data/enums/positions.dart';
import '../data/enums/tier.dart';

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

