class QrParser {
  static Map<String, String> analyze(String value) {
    final text = value.trim();
    if (text.toLowerCase().startsWith('upi://')) {
      return {'label': 'UPI Payment Request', 'risk': 'Review before paying'};
    }
    if (text.toLowerCase().startsWith('http://') ||
        text.toLowerCase().startsWith('https://')) {
      return {'label': 'Website QR Code', 'risk': 'Check the destination URL'};
    }
    return {
      'label': 'General QR Content',
      'risk': 'Verify before sharing or opening',
    };
  }
}
