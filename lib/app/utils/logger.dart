import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(String message, {String tag = 'NETRWA'}) {
    if (kDebugMode) {
      print('[$tag] - $message');
    }
  }

  static void error(String message, [dynamic error]) {
    if (kDebugMode) {
      print('[NETRWA ERROR] - $message : $error');
    }
  }
}
