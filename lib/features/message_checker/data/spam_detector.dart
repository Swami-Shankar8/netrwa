class SpamDetector {
  static Map<String, Object> analyze(String message) {
    final text = message.toLowerCase();
    final suspiciousTerms = [
      'otp',
      'pin',
      'kyc',
      'urgent',
      'winner',
      'claim now',
      'account blocked',
      'bank details',
      'bitcoin',
      'free offer',
    ];
    final matches = suspiciousTerms.where((term) => text.contains(term)).length;

    if (matches == 0) {
      return {
        'label': 'Likely Safe',
        'risk': 'Low',
        'score': 15,
        'isSafe': true,
      };
    }
    if (matches >= 3) {
      return {
        'label': 'High Risk Scam',
        'risk': 'High',
        'score': 92,
        'isSafe': false,
      };
    }
    return {
      'label': 'Suspicious Message',
      'risk': 'Medium',
      'score': 62,
      'isSafe': false,
    };
  }
}
