class RedFlagAlert {
  final String id;
  final String sender;
  final String message;
  final String category; // 'SCAM', 'SUSPICIOUS', 'SPAM'
  final DateTime timestamp;
  final String appSource; // 'SMS', 'WhatsApp', 'Gmail'

  RedFlagAlert({
    required this.id,
    required this.sender,
    required this.message,
    required this.category,
    required this.timestamp,
    required this.appSource,
  });

  factory RedFlagAlert.fromMap(Map<String, dynamic> map) {
    return RedFlagAlert(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      sender: map['sender'] ?? 'Unknown',
      message: map['body'] ?? map['message'] ?? '',
      category: map['category'] ?? 'SUSPICIOUS',
      timestamp: map['timestamp'] != null
          ? DateTime.parse(map['timestamp'])
          : DateTime.now(),
      appSource: map['appSource'] ?? 'SMS',
    );
  }
}
