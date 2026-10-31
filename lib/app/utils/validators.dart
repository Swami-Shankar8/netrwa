class AppValidators {
  static bool isValidUrl(String url) {
    final urlPattern = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(url);
  }

  static bool isSuspiciousMessage(String message) {
    final scamKeywords = [
      'win money',
      'lottery',
      'click here',
      'kyc update',
      'account blocked',
      'otp',
      'reward',
      'free iphone',
    ];
    final lowerMsg = message.toLowerCase();
    return scamKeywords.any((keyword) => lowerMsg.contains(keyword));
  }
}
