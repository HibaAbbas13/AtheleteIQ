import 'package:athleteiq/models/evaluation.dart';
import 'package:athleteiq/models/leaderboard_entry.dart'; 
import 'package:athleteiq/models/drill_suggestion.dart';
import '../models/user_model.dart';
import '../data/enums/user_role.dart';
import '../data/enums/sports_type.dart';
import '../data/enums/positions.dart';
import '../data/enums/tier.dart';

class StaticData {
  static List<User> get sampleUsers => [
    User(
      id: '1',
      name: 'Alex Johnson',
      email: 'alex@example.com',
      role: UserRole.athlete,
      sport: SportType.football,
      position: Position.qb,
      height: 72,
      weight: 185,
      gpa: 3.8,
      aiScore: 95,
      tokens: 1200,
      tier: Tier.platinum,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      filmLinks: ['https://example.com/film1.mp4'],
      evaluations: sampleEvaluations.where((e) => e.userId == '1').toList(),
    ),
    User(
      id: '2',
      name: 'Sarah Davis',
      email: 'sarah@example.com',
      role: UserRole.athlete,
      sport: SportType.basketball,
      position: Position.pg,
      height: 68,
      weight: 145,
      gpa: 4.0,
      aiScore: 92,
      tokens: 1100,
      tier: Tier.gold,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now(),
      filmLinks: ['https://example.com/film2.mp4'],
      evaluations: sampleEvaluations.where((e) => e.userId == '2').toList(),
    ),
    User(
      id: '3',
      name: 'Mike Wilson',
      email: 'mike@example.com',
      role: UserRole.athlete,
      sport: SportType.football,
      position: Position.rb,
      height: 70,
      weight: 195,
      gpa: 3.6,
      aiScore: 88,
      tokens: 950,
      tier: Tier.gold,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now(),
      filmLinks: ['https://example.com/film3.mp4'],
      evaluations: sampleEvaluations.where((e) => e.userId == '3').toList(),
    ),
    User(
      id: '4',
      name: 'Emma Rodriguez',
      email: 'emma@example.com',
      role: UserRole.athlete,
      sport: SportType.soccer,
      position: Position.athlete,
      height: 65,
      weight: 130,
      gpa: 3.9,
      aiScore: 85,
      tokens: 800,
      tier: Tier.silver,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
      filmLinks: ['https://example.com/film4.mp4'],
      evaluations: sampleEvaluations.where((e) => e.userId == '4').toList(),
    ),
    User(
      id: '5',
      name: 'John Parent',
      email: 'john.parent@example.com',
      role: UserRole.parent,
      aiScore: 0,
      tokens: 0,
      tier: Tier.bronze,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now(),
      filmLinks: [],
      evaluations: [],
    ),
  ];

  // Sample evaluations
  static List<Evaluation> get sampleEvaluations => [
    Evaluation(
      id: 'eval1',
      userId: '1',
      videoUrl: 'https://example.com/film1.mp4',
      aiScore: 95,
      feedback:
          'Outstanding performance! Excellent decision making and accuracy. Keep up the great work!',
      suggestedDrill: 'Advanced Reading Defense',
      drillUrl: 'https://example.com/drill1',
      tokensEarned: 25,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      aiAnalysis: {
        'decision_making': 95,
        'accuracy': 92,
        'footwork': 88,
        'positioning': 90,
      },
    ),
    Evaluation(
      id: 'eval2',
      userId: '2',
      videoUrl: 'https://example.com/film2.mp4',
      aiScore: 92,
      feedback:
          'Great ball handling and court vision. Work on finishing around the basket.',
      suggestedDrill: 'Post Move Development',
      drillUrl: 'https://example.com/drill2',
      tokensEarned: 20,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      aiAnalysis: {
        'ball_handling': 94,
        'court_vision': 90,
        'shooting': 85,
        'defense': 88,
      },
    ),
    Evaluation(
      id: 'eval3',
      userId: '3',
      videoUrl: 'https://example.com/film3.mp4',
      aiScore: 88,
      feedback:
          'Strong running ability with good vision. Focus on blocking technique.',
      suggestedDrill: 'Zone Blocking Fundamentals',
      drillUrl: 'https://example.com/drill3',
      tokensEarned: 18,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      aiAnalysis: {
        'speed': 92,
        'vision': 85,
        'blocking': 78,
        'elusiveness': 90,
      },
    ),
  ];

  // Sample leaderboard entries
  static List<LeaderboardEntry> get sampleLeaderboard => [
    LeaderboardEntry(
      userId: '1',
      name: 'Alex Johnson',
      rank: 1,
      aiScore: 95,
      tier: Tier.platinum,
      sport: SportType.football,
      position: Position.qb,
      tokens: 1200,
    ),
    LeaderboardEntry(
      userId: '2',
      name: 'Sarah Davis',
      rank: 2,
      aiScore: 92,
      tier: Tier.gold,
      sport: SportType.basketball,
      position: Position.pg,
      tokens: 1100,
    ),
    LeaderboardEntry(
      userId: '3',
      name: 'Mike Wilson',
      rank: 3,
      aiScore: 88,
      tier: Tier.gold,
      sport: SportType.football,
      position: Position.rb,
      tokens: 950,
    ),
    LeaderboardEntry(
      userId: '4',
      name: 'Emma Rodriguez',
      rank: 4,
      aiScore: 85,
      tier: Tier.silver,
      sport: SportType.soccer,
      position: Position.athlete,
      tokens: 800,
    ),
  ];

  // Sample drill suggestions
  static List<DrillSuggestion> get sampleDrills => [
    DrillSuggestion(
      id: 'drill1',
      title: 'Advanced Reading Defense',
      description:
          'Learn to read defensive formations and make quick decisions under pressure.',
      category: 'Football',
      difficulty: 'advanced',
      estimatedTime: 45,
      videoUrl: 'https://example.com/drill-video1.mp4',
      tags: ['football', 'quarterback', 'decision-making'],
    ),
    DrillSuggestion(
      id: 'drill2',
      title: 'Post Move Development',
      description:
          'Master essential post moves for better scoring opportunities.',
      category: 'Basketball',
      difficulty: 'intermediate',
      estimatedTime: 30,
      videoUrl: 'https://example.com/drill-video2.mp4',
      tags: ['basketball', 'post', 'scoring'],
    ),
    DrillSuggestion(
      id: 'drill3',
      title: 'Zone Blocking Fundamentals',
      description: 'Learn proper techniques for zone blocking schemes.',
      category: 'Football',
      difficulty: 'intermediate',
      estimatedTime: 40,
      videoUrl: 'https://example.com/drill-video3.mp4',
      tags: ['football', 'offense', 'blocking'],
    ),
    DrillSuggestion(
      id: 'drill4',
      title: 'Vertical Jump Training',
      description: 'Improve explosive power with plyometric exercises.',
      category: 'General',
      difficulty: 'beginner',
      estimatedTime: 25,
      videoUrl: 'https://example.com/drill-video4.mp4',
      tags: ['general', 'conditioning', 'power'],
    ),
  ];

  // Onboarding content
  static List<Map<String, dynamic>> get onboardingData => [
    {
      'title': 'Welcome to AthleteIQ',
      'subtitle': 'Your AI-Powered Recruiting Assistant',
      'description':
          'Get professional film analysis, personalized improvement plans, and compete on the leaderboard to showcase your talent.',
      'image': 'assets/images/onboarding1.png',
      'color': 0xFF1E3A8A, // primaryBlue
    },
    {
      'title': 'Upload & Analyze',
      'subtitle': 'AI Film Evaluation in Minutes',
      'description':
          'Upload your game footage or paste a Hudl/YouTube link. Our AI analyzes your performance and provides detailed feedback with drill recommendations.',
      'image': 'assets/images/onboarding2.png',
      'color': 0xFFFF6B35, // primaryOrange
    },
  ];

  // Sports and positions data
  static Map<String, List<String>> get sportsPositions => {
    'football': ['QB', 'RB', 'WR', 'TE', 'OL', 'DL', 'LB', 'CB', 'S'],
    'basketball': ['PG', 'SG', 'SF', 'PF', 'C'],
    'baseball': ['Pitcher', 'Catcher', 'Infield', 'Outfield'],
    'soccer': ['Forward', 'Midfielder', 'Defender', 'Goalkeeper'],
    'tennis': ['Singles', 'Doubles'],
    'track': ['Sprints', 'Distance', 'Field Events', 'Relays'],
    'volleyball': [
      'Setter',
      'Outside',
      'Middle',
      'Libero',
      'Defensive Specialist',
    ],
    'other': ['Athlete'],
  };

  // Achievement badges
  static List<Map<String, dynamic>> get achievementBadges => [
    {
      'id': 'first_upload',
      'title': 'First Upload',
      'description': 'Upload your first film',
      'icon': '🎥',
      'unlocked': true,
    },
    {
      'id': 'score_80',
      'title': 'High Scorer',
      'description': 'Achieve an AI score of 80+',
      'icon': '🏆',
      'unlocked': false,
    },
    {
      'id': 'leaderboard_top10',
      'title': 'Top Performer',
      'description': 'Reach top 10 on leaderboard',
      'icon': '⭐',
      'unlocked': false,
    },
  ];

  // Token earning opportunities
  static List<Map<String, dynamic>> get tokenOpportunities => [
    {
      'action': 'Upload Film',
      'tokens': 10,
      'description': 'Earn tokens for each film upload',
    },
    {
      'action': 'High Score Bonus',
      'tokens': 15,
      'description': 'Bonus tokens for scores above 85',
    },
    {
      'action': 'Weekly Challenge',
      'tokens': 25,
      'description': 'Complete weekly improvement challenges',
    },
    {
      'action': 'Leaderboard Position',
      'tokens': 50,
      'description': 'Weekly rewards based on ranking',
    },
  ];
}
