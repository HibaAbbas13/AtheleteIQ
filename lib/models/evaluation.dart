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

