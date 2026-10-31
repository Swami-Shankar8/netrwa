import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'Netrwa',
      'tagline': 'Think. Check. Pay Safe.',
      'hello_user': 'Hello, User! 👋',
      'stay_alert': 'Stay alert. Stay safe.',
      'security_status': 'Security Status',
      'all_good': 'All good! No major threats detected.',
      'check_messages': 'Check Messages',
      'scan_links': 'Scan Links',
      'analyse_qr': 'Analyse QR Codes',
      'add_apps': 'Add Applications',
      'red_flag': 'Red Flag',
      'hidden_apps': 'Hidden Apps',
    },
    'hi': {
      'app_name': 'नेत्रवा',
      'tagline': 'सोचें। जांचें। सुरक्षित भुगतान करें।',
      'hello_user': 'नमस्ते, यूजर! 👋',
      'stay_alert': 'सतर्क रहें। सुरक्षित रहें।',
      'security_status': 'सुरक्षा स्थिति',
      'all_good': 'सब ठीक है! कोई बड़ा खतरा नहीं मिला।',
      'check_messages': 'मैसेज जांचें',
      'scan_links': 'लिंक स्कैन करें',
      'analyse_qr': 'QR कोड विश्लेषित करें',
      'add_apps': 'ऐप्स जोड़ें',
      'red_flag': 'रेड फ्लैग',
      'hidden_apps': 'छिपे हुए ऐप्स',
    },
    'pa': {
      'app_name': 'ਨੇਤਰਵਾ',
      'tagline': 'ਸੋਚੋ। ਜਾਂਚੋ। ਸੁਰੱਖਿਅਤ ਭੁਗਤਾਨ ਕਰੋ।',
      'hello_user': 'ਸਤਿ ਸ਼੍ਰੀ ਅਕਾਲ, ਯੂਜ਼ਰ! 👋',
      'stay_alert': 'ਸੁਚੇਤ ਰਹੋ। ਸੁਰੱਖਿਅਤ ਰਹੋ।',
      'security_status': 'ਸੁਰੱਖਿਆ ਸਥਿਤੀ',
      'all_good': 'ਸਭ ਠੀਕ ਹੈ! ਕੋਈ ਵੱਡਾ ਖ਼ਤਰਾ ਨਹੀਂ ਮਿਲਿਆ।',
      'check_messages': 'ਮੈਸੇਜ ਚੈੱਕ ਕਰੋ',
      'scan_links': 'ਲਿੰਕ ਸਕੈਨ ਕਰੋ',
      'analyse_qr': 'QR ਕੋਡ ਦੀ ਜਾਂਚ ਕਰੋ',
      'add_apps': 'ਐਪਸ ਜੋੜੋ',
      'red_flag': 'ਰੈੱਡ ਫਲੈਗ',
      'hidden_apps': 'ਛੁਪੇ ਹੋਏ ਐਪਸ',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'pa'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
