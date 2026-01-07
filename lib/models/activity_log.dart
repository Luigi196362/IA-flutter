class ActivityLog {
  final int id;
  final String description;
  final DateTime timestamp;

  ActivityLog({
    required this.id,
    required this.description,
    required this.timestamp,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
