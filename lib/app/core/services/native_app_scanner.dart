import 'package:flutter/services.dart';

import '../../utils/logger.dart';

class NativeAppScanner {
  static const MethodChannel _channel = MethodChannel(
    'netrwa.security/app_scanner',
  );

  /// Fetches installed applications and hidden apps from Android Package Manager
  static Future<List<Map<String, dynamic>>> getInstalledApps() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        'getInstalledApps',
      );
      return result.map((item) => Map<String, dynamic>.from(item)).toList();
    } on PlatformException catch (e) {
      AppLogger.error('Failed to get installed apps from native channel', e);
      return [];
    }
  }

  /// Fetches apps running in background or using high-risk permissions
  static Future<List<Map<String, dynamic>>> getHiddenOrSuspiciousApps() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod('getHiddenApps');
      return result.map((item) => Map<String, dynamic>.from(item)).toList();
    } on PlatformException catch (e) {
      AppLogger.error('Failed to scan hidden apps', e);
      return [];
    }
  }
}
