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

