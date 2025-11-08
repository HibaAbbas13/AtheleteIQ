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

